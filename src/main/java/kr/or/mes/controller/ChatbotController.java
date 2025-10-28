package kr.or.mes.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.mes.service.impl.ChatbotDBService;

@Controller
@RequestMapping("/chatbot")
public class ChatbotController {

    @Autowired
    private ChatbotDBService chatbotDBService; // ✅ DB 연동 서비스 사용

    @PostMapping("/ask")
    @ResponseBody
    public Map<String, String> ask(@RequestBody Map<String, String> request) {
        String question = request.get("question");
        System.out.println("✅ 질문 도착: " + question);

        // ✅ DB 연동형 처리
        String answer = chatbotDBService.processQuestion(question);

        Map<String, String> response = new HashMap();
        response.put("answer", answer);
        return response;
    }

    @GetMapping("/view")
    public String viewPage() {
        return "chatbot/chat_view";
    }
}

