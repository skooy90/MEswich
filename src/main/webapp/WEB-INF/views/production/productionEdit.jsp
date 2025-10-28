<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>생산 LOT 수정 - MES 샌드위치 제조 관리 시스템</title>
    <style>
        /* 전역 스타일 */
        * {
            box-sizing: border-box;
        }

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

        /* 폼 컨테이너 */
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }


        /* 정보 표시 영역 */
        .info-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 4px;
            margin-bottom: 30px;
            border-left: 4px solid #007bff;
        }

        .info-section h3 {
            margin-top: 0;
            color: #495057;
            font-size: 16px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 15px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 12px;
            margin-bottom: 5px;
        }

        .info-value {
            color: #212529;
            font-size: 14px;
        }

        /* 폼 그룹 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group input:focus {
            outline: none;
            border-color: #ffc107;
            box-shadow: 0 0 0 2px rgba(255,193,7,0.25);
        }

        .form-group input[readonly] {
            background-color: #e9ecef;
            color: #6c757d;
        }

        /* 버튼 영역 */
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        /* 에러 메시지 */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }

        /* 성공 메시지 */
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            
            .form-container {
                padding: 20px;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <div class="form-container">
            <h2>✏️ 생산 LOT 수정</h2>
            
            <!-- 에러 메시지 표시 -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <!-- 성공 메시지 표시 -->
            <c:if test="${not empty success}">
                <div class="success-message">
                    ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty production}">
                <!-- 기존 정보 표시 -->
                <div class="info-section">
                    <h3>📋 기존 정보</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">LOT번호</span>
                            <span class="info-value">${production.lotNumber}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">제품코드</span>
                            <span class="info-value">${production.productCode}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">제품명</span>
                            <span class="info-value">${production.productName}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">상태</span>
                            <span class="info-value">
                                <c:choose>
                                    <c:when test="${production.status == 'PLANNED'}">계획</c:when>
                                    <c:when test="${production.status == 'IN_PROGRESS'}">진행중</c:when>
                                    <c:when test="${production.status == 'COMPLETED'}">완료</c:when>
                                    <c:when test="${production.status == 'CANCELLED'}">취소</c:when>
                                    <c:otherwise>${production.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- 수정 폼 -->
                <form method="post" action="/mes/production/edit" id="editForm">
                    <input type="hidden" name="lotNumber" value="${production.lotNumber}" />
                    
                    <div class="form-group">
                        <label for="plannedQty">계획수량 *</label>
                        <input type="number" id="plannedQty" name="plannedQty" min="1" required 
                               value="${production.plannedQty}" placeholder="계획 수량을 입력하세요">
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-warning">수정</button>
                        <a href="/mes/production/detail?lotNumber=${production.lotNumber}" class="btn btn-secondary">취소</a>
                    </div>
                </form>
            </c:if>
        </div>
    </main>

    <script>
        /**
         * 폼 유효성 검사
         */
        document.getElementById('editForm').addEventListener('submit', function(e) {
            const plannedQty = document.getElementById('plannedQty').value;
            
            // 계획수량 검증
            if (plannedQty <= 0) {
                alert('계획수량은 1 이상이어야 합니다.');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>
