package com.myportfolio.web.controller;

import com.myportfolio.web.domain.BoardDto;
import com.myportfolio.web.domain.PageHandler;
import com.myportfolio.web.domain.SearchCondition;
import com.myportfolio.web.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService service;

    // 게시글을 수정하는 메서드
    @PostMapping("/modify")
    public String modify(BoardDto boardDto, SearchCondition sc,
                         RedirectAttributes rattr, Model m) {
        try {
            if(service.modify(boardDto)!=1)
                throw new Exception("Modify is failed");
            rattr.addFlashAttribute("msg", "Mod_ok");

            return "redirect:/board/list" + sc.getQueryString();
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("msg", "Mod_error");

            return "board";
        }
    }


    // 2. 새로운 게시물을 등록하는 메서드
    @PostMapping("/write")
    public String writeNew(BoardDto boardDto, Model m, RedirectAttributes rattr) {
        try {
            if(service.write(boardDto)!=1)
                throw new Exception("Write is failed");
            rattr.addFlashAttribute("msg", "Wrt_ok");
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("msg","Wrt_error");
            return "board";
        }
    }

    // 1. 게시글 내용을 채우는 메서드
    @GetMapping("/write")
    public String write(Model m, BoardDto boardDto) {
        m.addAttribute("mode", "new");
        return "board";
    }

    // 게시글을 삭제하는 메서드
    @PostMapping("/remove")
    public String remove(BoardDto boardDto, SearchCondition sc, RedirectAttributes rattr) {
        try {
            if(service.remove(boardDto.getBno(), boardDto.getWriter())!=1)
                throw new Exception("Delete is faliled");
            rattr.addFlashAttribute("msg", "Del_ok");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "Del_error");
        }
        return "redirect:/board/list"+sc.getQueryString();
    }

    // 게시글 하나를 보여주는 메서드
    @GetMapping("/read")
    public String read(Integer bno, SearchCondition sc,Model m, RedirectAttributes rattr) {
        try {
            BoardDto boardDto = service.read(bno);
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("sc", sc);
            m.addAttribute("writer", boardDto.getWriter());
            return "board";
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "read_error");
            return "redirect:/board/list"+sc.getQueryString();
        }
    }


    // 게시글 목록을 보여주는 메서드
    @GetMapping("/list")
    public String boardList(HttpServletRequest request, Model m,
                            SearchCondition sc) {
        if(!loginCheck(request)) {
            return "redirect:/login/login?toURL="+request.getRequestURL();
        }
        try {
            int totalCnt = service.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);
            PageHandler ph = new PageHandler(totalCnt, sc);


            List<BoardDto> list = service.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", ph);

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "List_error");
            m.addAttribute("totalCnt", 0);
        }
        return "boardList";
    }

    private boolean loginCheck(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session.getAttribute("id")!=null;
    }
}
