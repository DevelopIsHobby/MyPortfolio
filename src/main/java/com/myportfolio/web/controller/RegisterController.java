package com.myportfolio.web.controller;

import com.myportfolio.web.domain.User;
import com.myportfolio.web.validator.UserValidator;
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
    public String save(@Valid User user, BindingResult result, Model m) {
        System.out.println("result = " + result);
        System.out.println("user = " + user);
        if(result.hasErrors()) {
            return "registerForm";
        }

        return "registerInfo";
    }
}
