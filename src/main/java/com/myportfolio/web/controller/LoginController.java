package com.myportfolio.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@RequestMapping("/login")
public class LoginController {
    @GetMapping("/login")
    public String loginForm() {
        return "loginForm";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/login")
    public String login(String id, String pwd, boolean rememberId,
                        String toURL,
                        RedirectAttributes rattr,
                        HttpServletRequest request,
                        HttpServletResponse response) throws Exception {
        if(!loginCheck(id, pwd)) {
            String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
            rattr.addFlashAttribute("msg",msg);
            return "redirect:/login/login";
        }

        HttpSession session = request.getSession();
        session.setAttribute("id", id);

        if(rememberId) {
            Cookie cookie = new Cookie("id", id);
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("id", id);
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
        toURL = toURL==null || toURL.equals("")? "/" : toURL;

        return "redirect:"+toURL;
    }

    private boolean loginCheck(String id, String pwd) {
        return id.equals("asdf") && String.valueOf(pwd).equals("1234");
    }
}
