package com.hms.HospitalManagementSystem.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/")
    public String dashboard(HttpSession session) {

        if (session.getAttribute("USER") == null) {
            return "redirect:/login";
        }
        return "dashboard";
    }
}
