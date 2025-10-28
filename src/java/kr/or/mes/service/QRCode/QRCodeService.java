package kr.or.mes.service.QRCode;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class QRCodeService {
	/**
     * 문자열 내용을 기반으로 QR 코드 이미지를 생성하고 PNG 바이트 배열로 반환합니다.
     * @param text QR 코드에 인코딩할 내용 (예: URL 또는 데이터)
     * @param width QR 코드 이미지의 너비(픽셀)
     * @param height QR 코드 이미지의 높이(픽셀)
     * @return PNG 형식의 QR 코드 이미지 바이트 배열
     * @throws WriterException
     * @throws IOException
     */
    public static byte[] generateQRCodeImage(String text, int width, int height)
            throws WriterException, IOException {
        
        // 1. QR 코드 쓰기 객체 생성
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        
        // 2. 텍스트를 비트 매트릭스로 인코딩
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);

        // 3. 비트 매트릭스를 이미지로 변환
        BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix);

        // 4. BufferedImage를 바이트 배열로 변환
        ByteArrayOutputStream pngOutputStream = new ByteArrayOutputStream();
        javax.imageio.ImageIO.write(bufferedImage, "PNG", pngOutputStream);
        
        return pngOutputStream.toByteArray();
    }
	}

