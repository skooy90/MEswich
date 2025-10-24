<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재고관리</title>
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

        /* 검색 영역 스타일 */
        .search-area {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .search-form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-form input, .search-form select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-select {
            min-width: 120px;
        }

        .search-btn {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .search-btn:hover {
            background-color: #229954;
        }

        /* 탭 영역 스타일 */
        .tab-area {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .tab-buttons {
            display: flex;
            gap: 10px;
            width: 100%;
        }

        .tab-btn {
            flex: 1;
            padding: 15px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
            min-height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .tab-btn.active {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .tab-btn.inventory {
            background-color: #27ae60;
            color: white;
        }

        .tab-btn.inventory:hover {
            background-color: #229954;
        }

        .tab-btn.inbound {
            background-color: #3498db;
            color: white;
        }

        .tab-btn.inbound:hover {
            background-color: #2980b9;
        }

        /* 목록 영역 스타일 */
        .list-area {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .list-header {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            font-weight: bold;
            font-size: 16px;
        }

        .inventory-list {
            width: 100%;
            border-collapse: collapse;
        }

        .inventory-list th {
            background-color: #34495e;
            color: white;
            padding: 12px 8px;
            text-align: center;
            font-size: 13px;
            border: 1px solid #2c3e50;
        }

        .inventory-list td {
            padding: 12px 8px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        .inventory-list tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .inventory-list tr:hover {
            background-color: #e8f5e8;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 11px;
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

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }
        .btn-success {
            background-color: #27ae60;
            color: white;
        }

        .btn-success:hover {
            background-color: #229954;
        }

        .btn-warning {
            background-color: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background-color: #e67e22;
        }

        .btn-info {
            background-color: #17a2b8;
            color: white;
        }

        .btn-info:hover {
            background-color: #138496;
        }

        /* 제목 스타일 */
        h2 {
            margin-top: 0;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        /* 체크박스 스타일 */
        .checkbox-cell {
            text-align: center;
        }

        /* 일괄 등록 버튼 */
        .batch-register-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .batch-register-btn:hover {
            background-color: #c0392b;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .tab-buttons {
                flex-direction: column;
            }
            
            .inventory-list {
                font-size: 12px;
            }
            
            .inventory-list th, .inventory-list td {
                padding: 8px 4px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>📦 재고관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="/mes/inventory/search">
                <select name="searchCategory" class="search-select">
                    <option value="productName">품목명</option>
                    <option value="itemCode">품목코드</option>
                    <option value="lotNumber">LOT번호</option>
                </select>
                <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" style="flex: 1; min-width: 200px;">
                <button type="submit" class="search-btn">🔍 검색</button>
            </form>
        </div>

        <!-- 탭 영역 -->
        <div class="tab-area">
            <div class="tab-buttons">
                <button class="tab-btn inventory active" onclick="showTab('inventory')">
                    🟢 전체재고현황
                </button>
                <button class="tab-btn inbound" onclick="showTab('inbound')">
                    📥 입고관리
                </button>
            </div>
        </div>

        <!-- 목록 영역 -->
        <div class="list-area">
            <!-- 전체재고현황 탭 -->
            <div id="inventory-tab" class="tab-content">
                <div class="list-header">📦 전체재고현황</div>
                <table class="inventory-list">
                    <thead>
                        <tr>
                            <th>재고ID</th>
                            <th>품목코드</th>
                            <th>품목명</th>
                            <th>LOT번호</th>
                            <th>현재수량</th>
                            <th>마지막업데이트</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty inventoryList}">
                                <c:forEach var="item" items="${inventoryList}">
                                    <tr>
                                        <td>${item.inventoryId}</td>
                                        <td>${item.itemCode}</td>
                                        <td>${item.productName}</td>
                                        <td>${item.lotNumber}</td>
                                        <td><strong style="color: #2c3e50;">${item.currentQty}개</strong></td>
                                        <td><fmt:formatDate value="${item.lastUpdated}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <a href="/mes/inventory/detail?inventoryId=${item.inventoryId}" class="btn btn-primary">상세</a>
                                        <form method="post" action="/mes/inventory/delete" style="display: inline;">
                                                <input type="hidden" name="inventoryId" value="${item.inventoryId}">
                                                <button type="submit" class="btn btn-delete">
                                                    삭제
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 20px;">
                                        등록된 재고가 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 입고관리 탭 -->
            <div id="inbound-tab" class="tab-content" style="display: none;">
                <!-- 등록 대기 항목 -->
                <div class="list-header">📥 등록 대기 항목</div>
                <button class="batch-register-btn" onclick="batchRegister()">일괄등록</button>
                <table class="inventory-list">
                    <thead>
                        <tr>
                            <th>선택</th>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>양품수량</th>
                            <th>검사일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty pendingList}">
                                <c:forEach var="item" items="${pendingList}">
                                    <tr>
                                        <td class="checkbox-cell">
                                            <input type="checkbox" name="inspectionNos" value="${item.inspectionNo}">
                                        </td>
                                        <td>${item.inspectionNo}</td>
                                        <td>${item.lotNumber}</td>
                                        <td>${item.productName}</td>
                                        <td><strong style="color: #27ae60;">${item.goodQty}개</strong></td>
                                        <td><fmt:formatDate value="${item.inspectionDate}" pattern="yyyy-MM-dd" /></td>
                                        <td>
                                            <form method="post" action="/mes/inventory/register" style="display: inline;">
                                                <input type="hidden" name="inspectionNo" value="${item.inspectionNo}">
                                                <button type="submit" class="btn btn-success">
                                                    등록
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 20px;">
                                        등록 대기 항목이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
                <!-- 등록 완료 항목 -->
                <div class="list-header" style="margin-top: 30px;">✅ 등록 완료 항목</div>
                <table class="inventory-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>양품수량</th>
                            <th>검사일</th>
                            <th>등록일</th>
                            <th>상태</th>
            </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty registeredList}">
                                <c:forEach var="item" items="${registeredList}">
                                    <tr>
                                        <td>${item.inspectionNo}</td>
                                        <td>${item.lotNumber}</td>
                                        <td>${item.productName}</td>
                                        <td><strong style="color: #27ae60;">${item.goodQty}개</strong></td>
                                        <td><fmt:formatDate value="${item.inspectionDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${item.updatedDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                        <td>
                                            <span class="btn btn-secondary" style="cursor: default;">등록됨</span>
                                        </td>
                </tr>
            </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 20px;">
                                        등록 완료 항목이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
        </table>
            </div>
        </div>
    </main>

    <script>
        /**
         * 탭 전환 기능
         * @param {string} tabName - 표시할 탭 이름 (inventory, inbound)
         */
        function showTab(tabName) {
            // 모든 탭 콘텐츠 숨기기
            var tabs = document.querySelectorAll('.tab-content');
            for (var i = 0; i < tabs.length; i++) {
                tabs[i].style.display = 'none';
            }
            
            // 모든 탭 버튼 비활성화
            var buttons = document.querySelectorAll('.tab-btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }
            
            // 선택된 탭 표시
            document.getElementById(tabName + '-tab').style.display = 'block';
            
            // 선택된 탭 버튼 활성화
            event.target.classList.add('active');
        }

        /**
         * 일괄 등록 기능 (단순화)
         */
        function batchRegister() {
            var checkboxes = document.querySelectorAll('input[name="inspectionNos"]:checked');
            if (checkboxes.length === 0) {
                alert('등록할 항목을 선택해주세요.');
                return;
            }
            
            if (confirm('선택한 ' + checkboxes.length + '개 항목을 일괄 등록하시겠습니까?')) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = '/mes/inventory/batchRegister';
                
                for (var i = 0; i < checkboxes.length; i++) {
                    var input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'inspectionNos';
                    input.value = checkboxes[i].value;
                    form.appendChild(input);
                }
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
