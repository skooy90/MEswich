<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>재고 상세정보</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }

        .main-content {
            margin-left: 200px; /* 사이드바 공간 확보 */
            padding: 100px 30px 30px; /* 헤더 높이 + 내부 여백 */
            min-height: 100vh;
        }

        /* 상세 정보 영역 스타일 */
        .detail-area {
            background: #fff;
            padding: 30px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .detail-header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            margin: -30px -30px 20px -30px;
            border-radius: 8px 8px 0 0;
            font-weight: bold;
            font-size: 18px;
        }

        .detail-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .info-group {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 6px;
            border-left: 4px solid #3498db;
        }

        .info-label {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .info-value {
            color: #34495e;
            font-size: 16px;
            margin-bottom: 15px;
        }

        .info-value:last-child {
            margin-bottom: 0;
        }

        /* 버튼 영역 */
        .button-area {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        /* 제목 스타일 */
        h2 {
            margin-top: 0;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            
            .detail-info {
                grid-template-columns: 1fr;
            }
            
            .button-area {
                text-align: left;
            }
            
            .btn {
                display: block;
                width: 100%;
                margin: 10px 0;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>📋 재고 상세정보</h2>
        
        <div class="detail-area">
            <div class="detail-header">
                📦 재고 상세정보
            </div>
            
            <c:choose>
                <c:when test="${not empty inventory}">
                    <div class="detail-info">
                        <div class="info-group">
                            <div class="info-label">재고 ID</div>
                            <div class="info-value">${inventory.inventoryId}</div>
                            
                            <div class="info-label">품목코드</div>
                            <div class="info-value">${inventory.itemCode}</div>
                            
                            <div class="info-label">품목명</div>
                            <div class="info-value">${inventory.productName}</div>
                        </div>
                        
                        <div class="info-group">
                            <div class="info-label">LOT번호</div>
                            <div class="info-value">${inventory.lotNumber}</div>
                            
                            <div class="info-label">현재수량</div>
                            <div class="info-value"><strong style="color: #27ae60; font-size: 18px;">${inventory.currentQty}개</strong></div>
                            
                            <div class="info-label">마지막업데이트</div>
                            <div class="info-value"><fmt:formatDate value="${inventory.lastUpdated}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                        </div>
                    </div>
                    
                    <div class="button-area">
                        <a href="/mes/inventory" class="btn btn-secondary">목록으로</a>
                        <a href="/mes/inventory/detail?inventoryId=${inventory.inventoryId}" class="btn btn-primary">새로고침</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #e74c3c;">
                        <h3>재고 정보를 찾을 수 없습니다.</h3>
                        <p>요청하신 재고 ID가 존재하지 않거나 삭제되었습니다.</p>
                        <a href="/mes/inventory" class="btn btn-primary">목록으로 돌아가기</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</body>
</html>
