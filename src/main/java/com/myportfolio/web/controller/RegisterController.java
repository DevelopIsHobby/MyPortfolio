package com.myportfolio.web.controller;

import com.myportfolio.web.dao.UserDao;
import com.myportfolio.web.domain.User;
import com.myportfolio.web.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class RegisterController {
    @Autowired
    UserDao userDao;

    @InitBinder
    public void toDate(WebDataBinder binder) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-mm-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(df, false));




        binder.setValidator(new UserValidator());
    }

    @GetMapping("/register/add")
    public String register() {
        return "registerForm";
    }
    @PostMapping("/register/add")
    public String save(@Valid User user, BindingResult result, Model m) throws Exception{
        // 1. User객체 검증결과 에러가 있으면 registerForm을 보여주고
        if(!result.hasErrors()) {
            // 2. 에러가 없으면 user를 DB에 저장한다.
            if(userDao.insertUser(user)==1) {
                m.addAttribute("msg", "회원가입에 성공하였습니다.");
                return "registerInfo";
            } else {
                m.addAttribute("msg", "회원가입에 실패했습니다.");
                return "registerForm";
            }
        }
        m.addAttribute("msg", "회원가입 도중 에러가 발생했습니다.");
        return "registerForm";
    }
}
