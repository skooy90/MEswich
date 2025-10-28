<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>작업관리</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }

        .main-content {
            margin-left: 200px;
            padding: 100px 30px 30px;
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
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .search-btn:hover {
            background-color: #2980b9;
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
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .tab-btn.active {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .tab-btn.pending {
            background-color: #e74c3c;
            color: white;
        }

        .tab-btn.pending:hover {
            background-color: #c0392b;
        }

        .tab-btn.progress {
            background-color: #f39c12;
            color: white;
        }

        .tab-btn.progress:hover {
            background-color: #e67e22;
        }

        .tab-btn.completed {
            background-color: #27ae60;
            color: white;
        }

        .tab-btn.completed:hover {
            background-color: #229954;
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

        .work-list {
            width: 100%;
            border-collapse: collapse;
        }

        .work-list th {
            background-color: #34495e;
            color: white;
            padding: 12px 8px;
            text-align: center;
            font-size: 13px;
            border: 1px solid #2c3e50;
        }

        .work-list td {
            padding: 12px 8px;
            text-align: center;
            border: 1px solid #ddd;
            font-size: 13px;
        }

        .work-list tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .work-list tr:hover {
            background-color: #e8f4f8;
        }

        /* 버튼 스타일 */
        .action-btn {
            padding: 4px 8px;
            margin: 2px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 11px;
            font-weight: bold;
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

        .btn-info {
            background-color: #17a2b8;
            color: white;
        }

        .btn-info:hover {
            background-color: #138496;
        }

        .btn-warning {
            background-color: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background-color: #e67e22;
        }

        /* 상태 배지 */
        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: bold;
            text-align: center;
            min-width: 60px;
        }

        .status-ready {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .status-in-progress {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .status-completed {
            background-color: #e8f5e8;
            color: #2e7d32;
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
            
            .work-list {
                font-size: 12px;
            }
            
            .work-list th, .work-list td {
                padding: 8px 4px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>🔧 작업관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="/mes/work/search">
                <select name="searchCategory" class="search-select">
                    <option value="productName" ${param.searchCategory == 'productName' ? 'selected' : ''}>제품명</option>
                    <option value="lotNumber" ${param.searchCategory == 'lotNumber' ? 'selected' : ''}>LOT번호</option>
                    <option value="worker" ${param.searchCategory == 'worker' ? 'selected' : ''}>작업자</option>
                    <option value="workOrderId" ${param.searchCategory == 'workOrderId' ? 'selected' : ''}>작업지시번호</option>
                </select>
                <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="${param.searchKeyword}">
                <button type="submit" class="search-btn">🔍 검색</button>
            </form>
        </div>

        <!-- 탭 영역 -->
        <div class="tab-area">
            <div class="tab-buttons">
                <button class="tab-btn pending active" onclick="showTab('pending')">
                    🔴 작업전
                </button>
                <button class="tab-btn progress" onclick="showTab('progress')">
                    🟡 진행중
                </button>
                <button class="tab-btn completed" onclick="showTab('completed')">
                    🟢 완료
                </button>
            </div>
        </div>

        <!-- 목록 영역 -->
        <div class="list-area">
            <!-- 작업전 탭 -->
            <div id="pending-tab" class="tab-content">
                <div class="list-header">📋 작업지시서 목록 (작업전) - <span class="status-badge status-ready">READY</span></div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>상태</th>
                            <th>작업자</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="hasReadyItems" value="false" />
                        <c:forEach var="workOrder" items="${allWorkOrdersList}">
                            <c:if test="${workOrder.status == 'READY'}">
                                <c:set var="hasReadyItems" value="true" />
                                <tr>
                                    <td><strong>${workOrder.workOrderNo}</strong></td>
                                    <td>${workOrder.lotNumber}</td>
                                    <td>${workOrder.productName}</td>
                                    <td>${workOrder.plannedQty}개</td>
                                    <td>
                                        <span class="status-badge status-ready">
                                        작업 전 
                                        </span>
                                    </td>
                                    <td>${workOrder.workerId != null ? workOrder.workerId : '관리자'}</td>
                                    <td>
                                        <form method="post" action="/mes/work/startWork" style="display: inline;">
                                            <input type="hidden" name="workOrderNo" value="${workOrder.workOrderNo}">
                                            <button type="submit" class="action-btn btn-primary">작업진행</button>
                                        </form>
                                            <a href="/mes/bom2/detail/${workOrder.productCode}">
                                            <button type="submit" class="action-btn btn-primary">BOM보기</button>
                                            </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!hasReadyItems}">
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 20px;">
                                    작업전 항목이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- 진행중 탭 -->
            <div id="progress-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 작업지시서 목록 (진행중) - <span class="status-badge status-in-progress">IN_PROGRESS</span></div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>생산량</th>
                            <th>상태</th>
                            <th>작업자</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="hasProgressItems" value="false" />
                        <c:forEach var="workOrder" items="${allWorkOrdersList}">
                            <c:if test="${workOrder.status == 'IN_PROGRESS'}">
                                <c:set var="hasProgressItems" value="true" />
                                <tr>
                                    <td><strong>${workOrder.workOrderNo}</strong></td>
                                    <td>${workOrder.lotNumber}</td>
                                    <td>${workOrder.productName}</td>
                                    <td>${workOrder.plannedQty}개</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${workOrder.actualQty != null}">
                                                <strong style="color: #e67e22;">${workOrder.actualQty}개</strong>
                                            </c:when>
                                            <c:otherwise><span style="color: #999;">0개</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="status-badge status-in-progress">진행중 </span>
                                    </td>
                                    <td>${workOrder.workerId != null ? workOrder.workerId : '관리자'}</td>
                                    <td>
                                        <form method="post" action="/mes/work/updateProduction" style="display: inline;">
                                            <input type="hidden" name="workOrderNo" value="${workOrder.workOrderNo}">
                                            <input type="number" name="actualQty" value="${workOrder.actualQty != null ? workOrder.actualQty : 0}" 
                                                   min="0" max="${workOrder.plannedQty}" style="width: 80px; margin-right: 5px;">
                                            <button type="submit" class="action-btn btn-info">생산량입력</button>
                                        </form>
                                        <form method="post" action="/mes/work/completeWork" style="display: inline;">
                                            <input type="hidden" name="workOrderNo" value="${workOrder.workOrderNo}">
                                            <button type="submit" class="action-btn btn-success">완료</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!hasProgressItems}">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 20px;">
                                    진행중인 작업이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- 완료 탭 -->
            <div id="completed-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 작업지시서 목록 (완료) - <span class="status-badge status-completed">DONE</span></div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>완료량</th>
                            <th>상태</th>
                            <th>작업자</th>
                            <th>완료일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="hasCompletedItems" value="false" />
                        <c:forEach var="workOrder" items="${allWorkOrdersList}">
                            <c:if test="${workOrder.status == 'DONE'}">
                                <c:set var="hasCompletedItems" value="true" />
                                <tr>
                                    <td><strong>${workOrder.workOrderNo}</strong></td>
                                    <td>${workOrder.lotNumber}</td>
                                    <td>
                                        <a href="/mes/work/detail?workOrderNo=${workOrder.workOrderNo}" 
                                           style="color: #3498db; text-decoration: none; font-weight: bold;">
                                            ${workOrder.productName}
                                        </a>
                                    </td>
                                    <td>${workOrder.plannedQty}개</td>
                                    <td>
                                        <strong style="color: #27ae60;">${workOrder.actualQty != null ? workOrder.actualQty : 0}개</strong>
                                    </td>
                                    <td>
                                        <span class="status-badge status-completed">완료</span>
                                    </td>
                                    <td>${workOrder.workerId != null ? workOrder.workerId : '관리자'}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty workOrder.endDate}">
                                                <fmt:formatDate value="${workOrder.endDate}" pattern="yyyy-MM-dd" />
                                            </c:when>
                                            <c:otherwise><span style="color: #999;">-</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form method="post" action="/mes/work/transferToQuality" style="display: inline;">
                                            <input type="hidden" name="workOrderNo" value="${workOrder.workOrderNo}">
                                            <button type="submit" class="action-btn btn-info" 
                                                    onclick="return confirm('품질관리로 전달하시겠습니까?')">품질관리로 보내기</button>
                                        </form>
                                        <form method="post" action="/mes/work/backToWork" style="display: inline;">
                                            <input type="hidden" name="workOrderNo" value="${workOrder.workOrderNo}">
                                            <button type="submit" class="action-btn btn-warning" 
                                                    onclick="return confirm('작업 중 상태로 돌아가시겠습니까?')">작업 중으로</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${!hasCompletedItems}">
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 20px;">
                                    완료된 작업이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        /**
         * 탭 전환 기능
         * @param {string} tabName - 표시할 탭 이름 (pending, progress, completed)
         */
        function showTab(tabName) {
            // 모든 탭 콘텐츠 숨기기
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.style.display = 'none';
            });
            
            // 모든 탭 버튼 비활성화
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // 선택된 탭 표시
            document.getElementById(tabName + '-tab').style.display = 'block';
            
            // 선택된 탭 버튼 활성화
            event.target.classList.add('active');
        }
    </script>
</body>
</html>