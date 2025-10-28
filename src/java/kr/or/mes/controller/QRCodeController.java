package kr.or.mes.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.zxing.WriterException;

import kr.or.mes.service.QRCode.QRCodeService;

@Controller
@RequestMapping("/qr") // URL 경로를 '/qr'로 변경하여 다른 컨트롤러와 분리하는 것을 추천합니다.
public class QRCodeController {

    // 💡 QR 코드 생성 유틸리티 클래스 (이전에 설명드린 QRCodeGenerator.java)를 가정합니다.
    
    /**
     * QR 코드 이미지를 동적으로 생성하여 PNG 형식으로 응답합니다.
     * * @param content QR 코드에 담을 텍스트 (URL, 데이터 등)
     * @return PNG 이미지 파일의 바이트 배열
     */
    @GetMapping(value = "/generate", produces = MediaType.IMAGE_PNG_VALUE)
    @ResponseBody // 메서드의 반환 값이 HTTP 응답 본문(Body)으로 직접 쓰여야 함을 알립니다.
    public byte[] generateQrCode(
            @RequestParam("content") String content,
            @RequestParam(value = "size", defaultValue = "200") int size) { // 크기를 동적으로 받을 수 있도록 추가
        
        try {
            // QRCodeGenerator 유틸리티 클래스를 사용하여 QR 코드 바이트 배열 생성
            // 200x200 크기 대신 size 변수를 사용하여 동적 크기 설정
            return QRCodeService.generateQRCodeImage(content, size, size); 
            
        } catch (WriterException e) {
            // ZXing 라이브러리 에러 처리 (인코딩 실패 등)
            // 실제 프로젝트에서는 로그를 남기고 사용자에게 오류를 알리는 처리가 필요합니다.
            e.printStackTrace();
            return new byte[0]; // 빈 이미지 반환
        } catch (IOException e) {
            // 이미지 스트림 처리 에러
            e.printStackTrace();
            return new byte[0];
        }
    }
}