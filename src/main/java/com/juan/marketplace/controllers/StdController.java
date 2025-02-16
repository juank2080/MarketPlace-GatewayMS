package com.juan.marketplace.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class StdController {

    @GetMapping("/hello")
    String hello() {
        return "Hello";
    }
}
