package com.myportfolio.web.controller;

import com.myportfolio.web.domain.BoardDto;
import com.myportfolio.web.domain.PageHandler;
import com.myportfolio.web.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    BoardService service;

    // 게시글을 수정하는 메서드
    @PostMapping("/modify")
    public String modify(BoardDto boardDto, Integer page, Integer pageSize, RedirectAttributes rattr, Model m) {
        try {
            System.out.println("boardDto = " + boardDto);
            if(service.modify(boardDto)!=1)
                throw new Exception("Modify is failed");
            rattr.addFlashAttribute("msg", "Mod_ok");
            rattr.addAttribute("page", page);
            rattr.addAttribute("pageSize", pageSize);
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("msg", "Mod_error");
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
            return "board";
        }
    }


    // 2. 새로운 게시물을 등록하는 메서드
    @PostMapping("/write")
    public String writeNew(BoardDto boardDto, Model m, RedirectAttributes rattr) {
        try {
            System.out.println("boardDto = " + boardDto);
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
    public String remove(BoardDto boardDto, Integer page, Integer pageSize,
                         RedirectAttributes rattr, Model m) {
        try {
            System.out.println("boardDto = " + boardDto);
            if(service.remove(boardDto.getBno(), boardDto.getWriter())!=1)
                throw new Exception("Delete is faliled");
            rattr.addFlashAttribute("msg", "Del_ok");
            rattr.addAttribute("page", page);
            rattr.addAttribute("pageSize", pageSize);
            return "redirect:/board/list";
        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("boardDto", boardDto);
            return "board";
        }
    }

    // 게시글 하나를 보여주는 메서드
    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m, RedirectAttributes rattr) {
        try {
            BoardDto boardDto = service.read(bno);
            m.addAttribute("boardDto", boardDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
            return "board";
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addAttribute("page", page);
            rattr.addAttribute("pageSize", pageSize);
            return "redirect:boardList";
        }
    }


    // 게시글 목록을 보여주는 메서드
    @GetMapping("/list")
    public String boardList(HttpServletRequest request, Model m,
                            @RequestParam(defaultValue = "1") Integer page,
                            @RequestParam(defaultValue = "10") Integer pageSize, RedirectAttributes rattr) {
        if(!loginCheck(request)) {
            return "redirect:/login/login?toURL="+request.getRequestURL();
        }
        try {
            int totalCnt = service.getCount();
            PageHandler ph = new PageHandler(totalCnt, page, pageSize);
            Map map = new HashMap();
            map.put("offset", (page-1)*pageSize);
            map.put("pageSize", pageSize);

            List<BoardDto> list = service.getPage(map);
            m.addAttribute("list", list);
            m.addAttribute("ph", ph);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "boardList";
    }

    private boolean loginCheck(HttpServletRequest request) {
        HttpSession session = request.getSession();
        return session.getAttribute("id")!=null;
    }
}
