package kr.or.mes.service.impl;

import java.util.*;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.mes.dao.Inventory2.Inventory2DAO;
import kr.or.mes.dao.Quality.QualityDAO;
import kr.or.mes.dto.Inventory2DTO;
import kr.or.mes.dto.Quality2DTO;

@Service
public class ChatbotDBService {

    @Autowired
    private ChatbotGeminiService geminiService;

    @Autowired
    private Inventory2DAO inventoryDAO;

    @Autowired
    private QualityDAO qualityDAO;

    /**
     * 사용자의 질문을 분석하고 DB에서 데이터 가져온 후 Gemini로 전달
     */
    public String processQuestion(String question) {
        try {
            String lower = question.toLowerCase();

            // 품질 관련 질문
            if (lower.contains("품질") || lower.contains("불량") || lower.contains("양품")) {
                return handleQualityQuestion(question);
            }

            // 재고 관련 질문
            if (lower.contains("재고") || lower.contains("입고") || lower.contains("출고")) {
                return handleInventoryQuestion(question);
            }

            // 일반 질문은 Gemini로 바로 전달
            return geminiService.ask(question);

        } catch (Exception e) {
            e.printStackTrace();
            return "❌ 처리 중 오류 발생: " + e.getMessage();
        }
    }

    /**
     * 품질 검사 데이터 요약
     */
    private String handleQualityQuestion(String question) {
        List<Quality2DTO> list = qualityDAO.selectAllQuality(new Quality2DTO());
        if (list == null || list.isEmpty()) {
            return "현재 등록된 품질검사 데이터가 없습니다.";
        }

        Map<String, int[]> summary = new LinkedHashMap<String, int[]>();
        for (Quality2DTO q : list) {
            summary.putIfAbsent(q.getProductName(), new int[2]); // [good, bad]
            summary.get(q.getProductName())[0] += (q.getGoodQty() != null ? q.getGoodQty() : 0);
            summary.get(q.getProductName())[1] += (q.getDefectQty() != null ? q.getDefectQty() : 0);
        }

        StringBuilder prompt = new StringBuilder("다음은 MES 품질검사 결과입니다:\n");
        for (Entry<String, int[]> entry : summary.entrySet()) {
            prompt.append(String.format("- %s: 양품 %d개, 불량 %d개\n",
                    entry.getKey(), entry.getValue()[0], entry.getValue()[1]));
        }
        prompt.append("이 데이터를 바탕으로 불량률을 요약해줘.");

        return geminiService.ask(prompt.toString());
    }

    /**
     * 재고 데이터 요약
     */
    private String handleInventoryQuestion(String question) {
        List<Inventory2DTO> list = inventoryDAO.selectAllInventory(new Inventory2DTO());
        if (list == null || list.isEmpty()) {
            return "현재 등록된 재고 데이터가 없습니다.";
        }

        Map<String, Integer> summary = new LinkedHashMap<String, Integer>();
        for (Inventory2DTO inv : list) {
            summary.put(inv.getProductName(),
                summary.getOrDefault(inv.getProductName(), 0) + inv.getCurrentQty());
        }

        StringBuilder prompt = new StringBuilder("현재 재고 현황은 다음과 같습니다:\n");
        int total = 0;
        for (Entry<String, Integer> e : summary.entrySet()) {
            prompt.append(String.format("- %s: %d개\n", e.getKey(), e.getValue()));
            total += e.getValue();
        }
        prompt.append(String.format("총 재고량은 %d개입니다. 간단히 요약해줘.", total));

        return geminiService.ask(prompt.toString());
    }
}

