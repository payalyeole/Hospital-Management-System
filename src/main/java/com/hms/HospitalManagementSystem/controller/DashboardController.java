package com.hms.HospitalManagementSystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashboardController {

    @RequestMapping("dashboard")
    public String dashboard() {
        System.out.println("This is Dashboard");
        return "dashboard.jsp";
    }
}
