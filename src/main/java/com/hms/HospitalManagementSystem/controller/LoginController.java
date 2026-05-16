package com.hms.HospitalManagementSystem.controller;

import com.hms.HospitalManagementSystem.models.User;
import com.hms.HospitalManagementSystem.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class LoginController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(
            @RequestParam String username,
            @RequestParam String password,
            HttpSession session) {

        Optional<User> userOptional = userRepository.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getPassword().equals(password)) {
                session.setAttribute("USER", username);
                session.setAttribute("ROLE", user.getRole());
                return "redirect:/";
            }
        }

        return "redirect:/login?error=true";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String doRegister(
            @RequestParam String username,
            @RequestParam String password,
            Model model) {

        Optional<User> existingUser = userRepository.findByUsername(username);
        if (existingUser.isPresent()) {
            return "redirect:/register?error=true";
        }

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole("USER");
        userRepository.save(newUser);

        return "redirect:/login?registered=true";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}