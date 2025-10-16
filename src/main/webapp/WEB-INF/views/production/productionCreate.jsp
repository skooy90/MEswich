<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>생산계획 추가 - MES 샌드위치 제조 관리 시스템</title>
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

        /* 제목 스타일 */
        h2 {
            margin-top: 0;
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
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

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
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

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background-color: #0056b3;
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
            <h2>🏭 생산계획 추가</h2>
            
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
            
            <form method="post" action="/mes/production/create" id="productionForm">
                <div class="form-group">
                    <label for="productCode">제품코드 *</label>
                    <select id="productCode" name="productCode" required>
                        <option value="">제품을 선택하세요</option>
                        <c:forEach var="product" items="${productList}">
                            <option value="${product.itemCode}" ${param.productCode == product.itemCode ? 'selected' : ''}>
                                ${product.itemCode} - ${product.itemName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="plannedQty">계획수량 *</label>
                    <input type="number" id="plannedQty" name="plannedQty" min="1" required 
                           value="${param.plannedQty}" placeholder="계획 수량을 입력하세요">
                </div>

                <div class="form-group">
                    <label for="plannedStartDate">계획시작일 *</label>
                    <input type="date" id="plannedStartDate" name="plannedStartDate" required 
                           value="${param.plannedStartDate}">
                </div>

                <div class="form-group">
                    <label for="plannedEndDate">계획종료일 *</label>
                    <input type="date" id="plannedEndDate" name="plannedEndDate" required 
                           value="${param.plannedEndDate}">
                </div>

                <!-- 생산 LOT 상태 (기본값: PLANNED) -->
                <input type="hidden" name="status" value="PLANNED">

                <div class="button-group">
                    <button type="submit" class="btn btn-primary">등록</button>
                    <a href="/mes/production/list" class="btn btn-secondary">취소</a>
                </div>
            </form>
        </div>
    </main>

    <script>
        /**
         * 폼 유효성 검사
         */
        document.getElementById('productionForm').addEventListener('submit', function(e) {
            const plannedQty = document.getElementById('plannedQty').value;
            const plannedStartDate = document.getElementById('plannedStartDate').value;
            const plannedEndDate = document.getElementById('plannedEndDate').value;
            
            // 계획수량 검증
            if (plannedQty <= 0) {
                alert('계획수량은 1 이상이어야 합니다.');
                e.preventDefault();
                return;
            }
            
            // 날짜 검증
            if (plannedStartDate && plannedEndDate) {
                if (new Date(plannedStartDate) > new Date(plannedEndDate)) {
                    alert('계획종료일은 계획시작일보다 이후여야 합니다.');
                    e.preventDefault();
                    return;
                }
            }
        });

        /**
         * 계획시작일 변경 시 계획종료일 최소값 설정
         */
        document.getElementById('plannedStartDate').addEventListener('change', function() {
            const startDate = this.value;
            const endDateInput = document.getElementById('plannedEndDate');
            
            if (startDate) {
                endDateInput.min = startDate;
            }
        });

        /**
         * 계획종료일 변경 시 계획시작일 최대값 설정
         */
        document.getElementById('plannedEndDate').addEventListener('change', function() {
            const endDate = this.value;
            const startDateInput = document.getElementById('plannedStartDate');
            
            if (endDate) {
                startDateInput.max = endDate;
            }
        });
    </script>
</body>
</html>


