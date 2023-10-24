package com.github.grimly.small.app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {
    @GetMapping("/ping")
    public PongMessage answerToPing() {
        return new PongMessage("pong");
    }
}
