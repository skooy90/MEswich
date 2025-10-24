<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>생산관리 - MES 샌드위치 제조 관리 시스템</title>
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

        /* 검색 영역 스타일 */
        .search-area {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-form input, .search-form select {
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-form button {
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .search-form button:hover {
            background-color: #0056b3;
        }

        .btn-create {
            background-color: #28a745;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-create:hover {
            background-color: #218838;
        }

        /* 테이블 스타일 */
        .table-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #e9ecef;
        }

        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            margin: 2px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn:hover {
            opacity: 0.8;
        }

        /* 상태 표시 */
        .status {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-PLANNED {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .status-IN_PROGRESS {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .status-COMPLETED {
            background-color: #e8f5e8;
            color: #388e3c;
        }

        .status-CANCELLED {
            background-color: #ffebee;
            color: #d32f2f;
        }

        /* 제목 스타일 */
        h2 {
            margin-top: 0;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #495057;
            margin: 20px 0 10px 0;
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

        /* 페이지네이션 */
        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination button {
            margin: 0 2px;
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
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .tab-btn.active {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .tab-btn.all-schedule {
            background-color: #007bff;
            color: white;
        }

        .tab-btn.all-schedule:hover {
            background-color: #0056b3;
        }

        .tab-btn.daily-schedule {
            background-color: #28a745;
            color: white;
        }

        .tab-btn.daily-schedule:hover {
            background-color: #218838;
        }

        /* 탭 콘텐츠 */
        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 금일 생산일정 전용 스타일 */
        .daily-schedule-info {
            background: #e8f5e8;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }

        .daily-schedule-info h3 {
            margin: 0 0 10px 0;
            color: #155724;
            font-size: 16px;
        }

        .daily-schedule-info p {
            margin: 0;
            color: #155724;
            font-size: 14px;
        }

        /* 금일 생산계획 추가 버튼 */
        .btn-daily-create {
            background-color: #ffc107;
            color: #212529;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            margin-left: 10px;
        }

        .btn-daily-create:hover {
            background-color: #e0a800;
        }

        /* 리스트 헤더 스타일 */
        .list-header {
            background-color: #f8f9fa;
            padding: 15px 20px;
            border-bottom: 1px solid #dee2e6;
        }

        .list-header h3 {
            margin: 0 0 5px 0;
            color: #495057;
            font-size: 18px;
        }

        .list-header p {
            margin: 0;
            color: #6c757d;
            font-size: 14px;
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
            
            table {
                font-size: 12px;
            }
            
            th, td {
                padding: 8px 4px;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>🏭 생산관리</h2>
        
        <!-- 에러 메시지 표시 -->
        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>
        
        <!-- 탭 영역 -->
        <div class="tab-area">
            <div class="tab-buttons">
                <button class="tab-btn all-schedule active" onclick="showTab('all-schedule')">
                    📅 전체 생산일정
                </button>
                <button class="tab-btn daily-schedule" onclick="showTab('daily-schedule')">
                    📋 금일 생산일정
                </button>
            </div>
        </div>
        

        <!-- 전체 생산일정 탭 -->
        <div id="all-schedule-tab" class="tab-content active">
        <div class="table-container">
                <div class="list-header">
                    <h3>📅 전체 생산일정</h3>
                    <p>전체 생산계획을 관리합니다. 전체 생산계획에서 금일 생산일정을 생성할 수 있습니다.</p>
                </div>
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="/mes/production/search">
                <input type="text" name="lotNumber" placeholder="LOT번호" value="${searchCondition.lotNumber}" />
                <input type="text" name="productCode" placeholder="제품코드" value="${searchCondition.productCode}" />
                <select name="status">
                    <option value="">전체 상태</option>
                    <option value="PLANNED" ${searchCondition.status == 'PLANNED' ? 'selected' : ''}>계획</option>
                    <option value="IN_PROGRESS" ${searchCondition.status == 'IN_PROGRESS' ? 'selected' : ''}>작업중</option>
                    <option value="COMPLETED" ${searchCondition.status == 'COMPLETED' ? 'selected' : ''}>완료</option>
                </select>
                <button type="submit">🔍 검색</button>
                <a href="/mes/production/create" class="btn-create">➕ 전체 생산계획추가</a>
            </form>
        </div>
            <table>
                <thead>
                    <tr>
                        <th>LOT번호</th>
                        <th>제품코드</th>
                        <th>제품명</th>
                        <th>계획수량</th>
                        <th>생산수량</th>
                        <th>상태</th>
                        <th>계획시작일</th>
                        <th>계획종료일</th>
                        <th>기능</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                            <c:when test="${not empty productionList}">
                                <c:forEach var="production" items="${productionList}">
                                    <tr>
                                        <td>${production.lotNumber}</td>
                                        <td>${production.productCode}</td>
                                        <td><a href="/mes/production/detail?lotNumber=${production.lotNumber}" style="color: #007bff; text-decoration: none;">${production.productName}</a></td>
                                        <td>${production.plannedQty}개</td>
                                        <td>${production.actualQty != null ? production.actualQty : 0}개</td>
                                        <td>
                                            <span class="status status-${production.status}">
                                                <c:choose>
                                                    <c:when test="${production.status == 'PLANNED'}">계획</c:when>
                                                    <c:when test="${production.status == 'IN_PROGRESS'}">작업중</c:when>
                                                    <c:when test="${production.status == 'COMPLETED'}">완료</c:when>
                                                    <c:otherwise>${production.status}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td><fmt:formatDate value="${production.plannedStartDate}" pattern="yyyy-MM-dd" /></td>
                                        <td><fmt:formatDate value="${production.plannedEndDate}" pattern="yyyy-MM-dd" /></td>
                                        <td>
                                            <a href="/mes/production/edit?lotNumber=${production.lotNumber}" class="btn btn-warning">수정</a>
                                            <button onclick="createDailySchedule('${production.lotNumber}', '${production.productName}', '${production.plannedQty}')" 
                                                    class="btn btn-success">금일생산</button>
                                            <form method="post" action="/mes/production/delete" style="display: inline;">
                                                <input type="hidden" name="lotNumber" value="${production.lotNumber}" />
                                                <button type="submit" onclick="return confirm('정말로 삭제하시겠습니까?')" 
                                                        class="btn btn-danger">삭제</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" style="text-align: center; padding: 20px;">
                                        등록된 전체 생산계획이 없습니다.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 금일 생산일정 탭 -->
        <div id="daily-schedule-tab" class="tab-content">
            <div class="daily-schedule-info">
                <h3>📋 금일 생산일정</h3>
                <p>오늘 생산할 계획을 관리합니다. 전체 생산계획에서 일부 수량만 선별하여 금일 생산일정을 생성할 수 있습니다.</p>
            </div>
            
            <div class="search-area">
                <form class="search-form" method="get" action="/mes/production/daily/search">
                    <input type="date" name="scheduleDate" value="${param.scheduleDate}" />
                    <select name="status">
                        <option value="">전체 상태</option>
                        <option value="Production" ${searchCondition.status == 'Production' ? 'selected' : ''}>계획</option>
                        <option value="work" ${searchCondition.status == 'work' ? 'selected' : ''}>작업중</option>
                        <option value="quality" ${searchCondition.status == 'quality' ? 'selected' : ''}>품질검사중</option>
                        <option value="inventory" ${searchCondition.status == 'inventory' ? 'selected' : ''}>완료</option>
                    </select>
                    <button type="submit">🔍 검색</button>
                </form>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>금일생산수량</th>
                            <th>상태</th>
                            <th>생산일</th>
                            <th>작업자</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty dailyScheduleList}">
                                <c:forEach var="dailySchedule" items="${dailyScheduleList}">
                                    <tr>
                                        <td>${dailySchedule.lotNumber}</td>
                                        <td>${dailySchedule.productName}</td>
                                        <td><strong style="color: #28a745;">${dailySchedule.plannedQty}개</strong></td>
                                        <td>
                                            <span class="status status-${dailySchedule.status}">${dailySchedule.statusDisplayName}</span>
                                        </td>
                                        <td><fmt:formatDate value="${dailySchedule.plannedStartDate}" pattern="yyyy-MM-dd" /></td>
                                        <td>${dailySchedule.workerId != null ? dailySchedule.workerId : '미배정'}</td>
                                        <td>
                                            <a href="/mes/production/edit?lotNumber=${dailySchedule.parentLotNumber}" class="btn btn-warning">수정</a>
                                            <button onclick="startDailyProduction('${dailySchedule.dailyPlanId}')" class="btn btn-primary">작업시작</button>
                                            <form method="post" action="/mes/production/daily/delete" style="display: inline;">
                                                <input type="hidden" name="dailyPlanId" value="${dailySchedule.dailyPlanId}" />
                                            <button type="submit" onclick="return confirm('정말로 삭제하시겠습니까?')" 
                                                    class="btn btn-danger">삭제</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" style="text-align: center; padding: 20px;">
                                        등록된 금일 생산일정이 없습니다.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            </div>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <button class="btn btn-primary">이전</button>
            <button class="btn btn-primary">1</button>
            <button class="btn btn-primary">2</button>
            <button class="btn btn-primary">3</button>
            <button class="btn btn-primary">4</button>
            <button class="btn btn-primary">5</button>
            <button class="btn btn-primary">다음</button>
        </div>

    </main>

    <script>
        /**
         * 탭 전환 기능
         * @param {string} tabName - 표시할 탭 이름 (all-schedule, daily-schedule)
         */
         function showTab(tabName, targetElement) {
    // 모든 탭 콘텐츠 숨기기
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
    });
    
    // 모든 탭 버튼 비활성화
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    // 선택된 탭 표시
    document.getElementById(tabName + '-tab').classList.add('active');
    
    // 선택된 탭 버튼 활성화 (targetElement가 있을 때만)
    if (targetElement) {
        targetElement.classList.add('active');
    }
}

        /**
         * 전체 생산계획에서 금일 생산일정 생성
         * @param {string} lotNumber - LOT번호
         * @param {string} productName - 제품명
         * @param {number} totalPlannedQty - 전체 계획수량
         */
        function createDailySchedule(lotNumber, productName, totalPlannedQty) {
            const dailyQty = prompt(`${productName}의 금일 생산수량을 입력하세요 (전체: ${totalPlannedQty}개):`, '');
            
            if (dailyQty !== null && dailyQty.trim() !== '') {
                const qty = parseInt(dailyQty);
                if (isNaN(qty) || qty <= 0) {
                    alert('올바른 생산수량을 입력해주세요.');
                    return;
                }
                if (qty > totalPlannedQty) {
                    alert('금일 생산수량은 전체 계획수량을 초과할 수 없습니다.');
                    return;
                }
                
                // 금일 생산일정 생성 요청
                fetch('/mes/production/daily/createFromAll', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'lotNumber=' + encodeURIComponent(lotNumber) + 
                          '&plannedQty=' + encodeURIComponent(qty)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        // 금일 생산일정 탭으로 전환
                        showTab('daily-schedule', document.querySelector('.tab-btn[onclick*="daily-schedule"]'));
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('금일 생산일정 생성 중 오류가 발생했습니다.');
                });
            }
        }

        /**
         * 금일 생산일정 작업 시작
         * @param {string} dailyScheduleNo - 금일생산번호
         */
        function startDailyProduction(dailyPlanId) {
            if (confirm('금일 생산일정을 시작하시겠습니까?')) {
            	fetch('/mes/production/daily/updateStatus', {
            	    method: 'POST',
            	    headers: {
            	        'Content-Type': 'application/x-www-form-urlencoded',
            	    },
            	    body: 'dailyPlanId=' + encodeURIComponent(dailyPlanId) + 
            	          '&status=work'  // 상태를 'work'로 변경
            	})
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('작업 시작 중 오류가 발생했습니다.');
                });
            }
        }

        /**
         * 페이지네이션 기능
         * @param {number} pageNumber - 페이지 번호
         */
        function goToPage(pageNumber) {
            alert('페이지 ' + pageNumber + '로 이동 - 추후 구현 예정');
        }
    </script>
</body>
</html>
