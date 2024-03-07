package com.myportfolio.web.controller;

import com.myportfolio.web.domain.CommentDto;
import com.myportfolio.web.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.xml.stream.events.Comment;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

@Controller
public class CommentController {
    @Autowired
    CommentService service;

    // 댓글을 수정하는 메서드
    @PatchMapping("/comments/{cno}") // /comments/1?bno=1041
    @ResponseBody
    public ResponseEntity<String> modify(@RequestBody CommentDto commentDto,
                                         Integer bno, HttpSession session) {
        //        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf1";
        commentDto.setCommenter(commenter);
        try {
            if(service.modify(commentDto)!=1)
                throw new Exception("Modify is failed");
            return new ResponseEntity<>("Mod_Ok", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Mod_Error", HttpStatus.BAD_REQUEST);
        }
    }


    // 댓글을 등록하는 메서드
    @PostMapping("/comments") // /comments?bno=1041
    @ResponseBody
    public ResponseEntity<String> write(@RequestBody CommentDto commentDto,
                                        Integer bno, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf1";
        commentDto.setCommenter(commenter);
        try {
            if(service.write(commentDto)!=1)
                throw new Exception("Write is failed");
            return new ResponseEntity<>("Wrt_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Wrt_Error", HttpStatus.BAD_REQUEST);

        }
    }


    // 지정된 댓글을 삭제하는 메서드
    @DeleteMapping("/comments/{cno}") // /comments/1?bno=1041
    @ResponseBody
    public ResponseEntity<String> remove(@PathVariable Integer cno,
                                         Integer bno, HttpSession session) {
//        String commenter = (String) session.getAttribute("id");
        String commenter = "asdf1";

        try {
            if(service.remove(cno, bno, commenter)!=1)
                throw new Exception("Delete is failed");
            return new ResponseEntity<>("Del_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Del_Error", HttpStatus.BAD_REQUEST);
        }
    }

    // 지정된 게시글의 모든 댓글을 가져오는 메서드
    @GetMapping("/comments") // /comments?bno=1041
    @ResponseBody
    public ResponseEntity<List<CommentDto>> list(Integer bno) {
        try {
            List<CommentDto> list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list,HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST);
        }
    }
}
