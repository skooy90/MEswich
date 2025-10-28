<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <title>품질관리</title>
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

        .tab-btn.pending {
            background-color: #f39c12;
            color: white;
        }

        .tab-btn.pending:hover {
            background-color: #e67e22;
        }

        .tab-btn.hold {
            background-color: #3498db;
            color: white;
        }

        .tab-btn.hold:hover {
            background-color: #2980b9;
        }

        .tab-btn.pass {
            background-color: #27ae60;
            color: white;
        }

        .tab-btn.pass:hover {
            background-color: #229954;
        }

        .tab-btn.fail {
            background-color: #e74c3c;
            color: white;
        }

        .tab-btn.fail:hover {
            background-color: #c0392b;
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

        .quality-list {
            width: 100%;
            border-collapse: collapse;
        }

        .quality-list th {
            background-color: #34495e;
            color: white;
            padding: 12px 8px;
            text-align: center;
            font-size: 13px;
            border: 1px solid #2c3e50;
        }

        .quality-list td {
            padding: 12px 8px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        .quality-list tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .quality-list tr:hover {
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
            
            .quality-list {
                font-size: 12px;
            }
            
            .quality-list th, .quality-list td {
                padding: 8px 4px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>🔍 품질관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="/mes/quality">
                <select name="status" class="search-select">
                    <option value="">전체</option>
                    <option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>검사대기</option>
                    <option value="HOLD" ${selectedStatus == 'HOLD' ? 'selected' : ''}>검사중</option>
                    <option value="PASS" ${selectedStatus == 'PASS' ? 'selected' : ''}>검사합격</option>
                    <option value="FAIL" ${selectedStatus == 'FAIL' ? 'selected' : ''}>검사불합격</option>
                </select>
                <button type="submit" class="search-btn">🔍 필터</button>
            </form>
        </div>

        <!-- 탭 영역 -->
        <div class="tab-area">
            <div class="tab-buttons">
                <button class="tab-btn pending active" onclick="showTab('pending')">
                    🟡 검사대기
                </button>
                <button class="tab-btn hold" onclick="showTab('hold')">
                    🔍 검사중
                </button>
                <button class="tab-btn pass" onclick="showTab('pass')">
                    ✅ 검사합격
                </button>
                <button class="tab-btn fail" onclick="showTab('fail')">
                    ❌ 검사불합격
                </button>
            </div>
        </div>

        <!-- 목록 영역 -->
        <div class="list-area">
            <!-- 검사대기 탭 -->
            <div id="pending-tab" class="tab-content">
                <div class="list-header">📋 품질 검사 목록 (검사대기)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>제품수량</th>
                            <th>상태</th>
                            <th>생성일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:forEach var="item" items="${list}">
                                    <c:if test="${item.status == 'PENDING'}">
                                        <tr>
                                            <td>${item.inspectionNo}</td>
                                            <td>${item.lotNumber}</td>
                                            <td>${item.productName}</td>
                                            <td><strong style="color: #2c3e50;">${item.plannedQty != null ? item.plannedQty : 0}개</strong></td>
                                            <td><span style="color: #f39c12; font-weight: bold;">검사 대기</span></td>
                                            <td><fmt:formatDate value="${item.createdDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <form method="post" action="/mes/quality/startInspection" style="display: inline;">
                                                    <input type="hidden" name="inspectionNo" value="${item.inspectionNo}">
                                                    <input type="text" name="inspectorName" placeholder="검사자명" required style="width: 80px; padding: 4px; border: 1px solid #ddd; border-radius: 3px;">
                                                    <button type="submit" class="btn btn-warning">검사시작</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 20px;">
                                        검사대기 항목이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 검사중 탭 -->
            <div id="hold-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 품질 검사 목록 (검사중)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>제품수량</th>
                            <th>검사자</th>
                            <th>상태</th>
                            <th>생성일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:forEach var="item" items="${list}">
                                    <c:if test="${item.status == 'HOLD'}">
                                        <tr>
                                            <td>${item.inspectionNo}</td>
                                            <td>${item.lotNumber}</td>
                                            <td>${item.productName}</td>
                                            <td><strong style="color: #2c3e50;">${item.plannedQty != null ? item.plannedQty : 0}개</strong></td>
                                            <td>${item.inspectorName}</td>
                                            <td><span style="color: #3498db; font-weight: bold;">검사중</span></td>
                                            <td><fmt:formatDate value="${item.createdDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <form method="post" action="/mes/quality/completeInspection" style="display: inline;">
                                                    <input type="hidden" name="inspectionNo" value="${item.inspectionNo}">
                                                    <input type="number" name="goodQty" placeholder="양품수량" required min="0" max="${item.plannedQty != null ? item.plannedQty : 999999}" style="width: 80px; padding: 4px; border: 1px solid #ddd; border-radius: 3px; margin-right: 5px;">
                                                    <input type="number" name="defectQty" placeholder="불량수량" min="0" value="0" style="width: 80px; padding: 4px; border: 1px solid #ddd; border-radius: 3px; margin-right: 5px;">
                                                    <select name="defectReason"  style="width: 120px; padding: 4px; border: 1px solid #ddd; border-radius: 3px; margin-right: 5px;">
                                                    	<option value="설비결함">설비결함</option>
                                                    	<option value="포장불량">포장불량</option>
                                                    	<option value="모형문제">모형문제</option>
                                                    </select>
<!--                                                     <input type="select" name="defectReason" placeholder="불량사유" style="width: 120px; padding: 4px; border: 1px solid #ddd; border-radius: 3px; margin-right: 5px;"> -->
                                                    <button type="submit" class="btn btn-success">검사완료</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" style="text-align: center; padding: 20px;">
                                        검사중인 항목이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 검사합격 탭 -->
            <div id="pass-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 품질 검사 목록 (검사합격)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>제품수량</th>
                            <th>양품수량</th>
                            <th>검사자</th>
                            <th>상태</th>
                            <th>검사일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:forEach var="item" items="${list}">
                                    <c:if test="${item.status == 'PASS'}">
                                        <tr>
                                            <td>${item.inspectionNo}</td>
                                            <td>${item.lotNumber}</td>
                                            <td>${item.productName}</td>
                                            <td><strong style="color: #2c3e50;">${item.plannedQty != null ? item.plannedQty : 0}개</strong></td>
                                            <td>${item.goodQty != null ? item.goodQty : 0}개</td>
                                            <td>${item.inspectorName}</td>
                                            <td><span style="color: #27ae60; font-weight: bold;">완품</span></td>
                                            <td><fmt:formatDate value="${item.inspectionDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <form method="post" action="/mes/quality/registerGoodInventory" style="display: inline;">
                                                    <input type="hidden" name="inspectionNo" value="${item.inspectionNo}">
                                                    <button type="submit" class="btn btn-success">재고등록</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" style="text-align: center; padding: 20px;">
                                        검사합격 항목이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- 검사불합격 탭 -->
            <div id="fail-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 품질 검사 목록 (검사불합격)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>제품수량</th>
                            <th>불량수량</th>
                            <th>불량사유</th>
                            <th>검사자</th>
                            <th>상태</th>
                            <th>검사일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty list}">
                                <c:forEach var="item" items="${list}">
                                    <c:if test="${item.status == 'FAIL'}">
                                        <tr>
                                            <td>${item.inspectionNo}</td>
                                            <td>${item.lotNumber}</td>
                                            <td>${item.productName}</td>
                                            <td><strong style="color: #2c3e50;">${item.plannedQty != null ? item.plannedQty : 0}개</strong></td>
                                            <td>${item.defectQty != null ? item.defectQty : 0}개</td>
                                            <td>${item.defectReason != null ? item.defectReason : '-'}</td>
                                            <td>${item.inspectorName}</td>
                                            <td><span style="color: #e74c3c; font-weight: bold;">불량</span></td>
                                            <td><fmt:formatDate value="${item.inspectionDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <form method="post" action="/mes/quality/processDefect" style="display: inline;">
                                                    <input type="hidden" name="inspectionNo" value="${item.inspectionNo}">
                                                    <button type="submit" class="btn btn-danger">불량처리</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" style="text-align: center; padding: 20px;">
                                        검사불합격 항목이 없습니다.
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
         * @param {string} tabName - 표시할 탭 이름 (pending, hold, pass, fail)
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
    </script>
</body>
</html>