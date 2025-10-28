package kr.or.mes.service.impl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class ChatbotGeminiService {

    private final RestTemplate restTemplate;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    public ChatbotGeminiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String ask(String question) {
        // ✅ API 키 검증
        if (geminiApiKey == null || geminiApiKey.trim().isEmpty()) {
            return "⚠️ API Key가 설정되어 있지 않습니다. application.properties를 확인해주세요.";
        }

        // ✅ 요청 URL
        String url = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=" + geminiApiKey;

        // ✅ 요청 본문
//        Map<String, Object> body = Map.of(
//            "contents", List.of(
//                Map.of("parts", List.of(Map.of("text", question)))
//            )
//        );
        
        Map<String, Object> body = new HashMap<String, Object>();

        List<Map<String, Object>> contents = new ArrayList<Map<String, Object>>();
        Map<String, Object> content = new HashMap<String, Object>();

        List<Map<String, Object>> parts = new ArrayList<Map<String, Object>>();
        Map<String, Object> part = new HashMap<String, Object>();
        part.put("text", question);
        parts.add(part);

        content.put("parts", parts);
        contents.add(content);

        body.put("contents", contents);


        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<Map<String, Object>>(body, headers);

        try {
            // ✅ 요청 실행
            ResponseEntity<String> response = restTemplate.postForEntity(url, requestEntity, String.class);
            System.out.println("응답 코드 = " + response.getStatusCode());
            System.out.println("응답 본문 = " + response.getBody());

            // ✅ 상태코드 확인
            if (!response.getStatusCode().is2xxSuccessful()) {
                return "❌ API 호출 실패: " + response.getStatusCode();
            }

            // ✅ 응답 파싱
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());

            JsonNode candidates = root.path("candidates");
            if (candidates.isMissingNode() || !candidates.elements().hasNext()) {
                return "🤔 Gemini로부터 유효한 응답이 없습니다. 다시 시도해보세요.";
            }

            JsonNode first = candidates.get(0)
                    .path("content")
                    .path("parts")
                    .get(0);

            if (first == null || first.path("text").isMissingNode()) {
                return "⚠️ 응답 파싱 중 오류가 발생했습니다. (빈 응답)";
            }

            // ✅ 정상 텍스트 반환
            return first.path("text").asText();

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ 서버 통신 또는 파싱 중 오류 발생: " + e.getMessage();
        }
    }
}


