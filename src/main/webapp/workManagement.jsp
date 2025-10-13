<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            min-width: 120px; /* 셀렉트 박스 최소 너비 */
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
            flex: 1; /* 3등분으로 균등 분할 */
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

        /* 페이지네이션 스타일 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            gap: 5px;
        }

        .pagination button {
            padding: 8px 12px;
            border: 1px solid #ddd;
            background: white;
            cursor: pointer;
            border-radius: 4px;
        }

        .pagination button:hover {
            background-color: #f8f9fa;
        }

        .pagination button.active {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
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

    <main class="main-content">
        <h2>🔧 작업관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="">
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
                <div class="list-header">📋 작업 지시서 목록 (작업전)</div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>작업자</th>
                            <th>생성일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>WO001</td>
                            <td>LOT001</td>
                            <td>햄치즈샌드위치</td>
                            <td>100개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-primary" onclick="setWorkQuantity('WO001')">작업량설정</button>
                                <button class="action-btn btn-warning" onclick="assignWorker('WO001')">작업자배정</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO004</td>
                            <td>LOT004</td>
                            <td>햄치즈샌드위치</td>
                            <td>120개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-primary" onclick="setWorkQuantity('WO004')">작업량설정</button>
                                <button class="action-btn btn-warning" onclick="assignWorker('WO004')">작업자배정</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO005</td>
                            <td>LOT005</td>
                            <td>계란샌드위치</td>
                            <td>90개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-primary" onclick="setWorkQuantity('WO005')">작업량설정</button>
                                <button class="action-btn btn-warning" onclick="assignWorker('WO005')">작업자배정</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO006</td>
                            <td>LOT006</td>
                            <td>참치샌드위치</td>
                            <td>80개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-primary" onclick="setWorkQuantity('WO006')">작업량설정</button>
                                <button class="action-btn btn-warning" onclick="assignWorker('WO006')">작업자배정</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO007</td>
                            <td>LOT007</td>
                            <td>햄치즈샌드위치</td>
                            <td>110개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-primary" onclick="setWorkQuantity('WO007')">작업량설정</button>
                                <button class="action-btn btn-warning" onclick="assignWorker('WO007')">작업자배정</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 진행중 탭 -->
            <div id="progress-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 작업 지시서 목록 (진행중)</div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>작업자</th>
                            <th>진행률</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>WO002</td>
                            <td>LOT002</td>
                            <td>햄치즈샌드위치</td>
                            <td>100개</td>
                            <td>김작업</td>
                            <td>65%</td>
                            <td>
                                <button class="action-btn btn-info" onclick="updateProgress('WO002')">작업진행</button>
                                <button class="action-btn btn-success" onclick="completeWork('WO002')">완료</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO003</td>
                            <td>LOT003</td>
                            <td>계란샌드위치</td>
                            <td>90개</td>
                            <td>이작업</td>
                            <td>30%</td>
                            <td>
                                <button class="action-btn btn-info" onclick="updateProgress('WO003')">작업진행</button>
                                <button class="action-btn btn-success" onclick="completeWork('WO003')">완료</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 완료 탭 -->
            <div id="completed-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 작업 지시서 목록 (완료)</div>
                <table class="work-list">
                    <thead>
                        <tr>
                            <th>작업지시번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>목표량</th>
                            <th>완료량</th>
                            <th>작업자</th>
                            <th>완료일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>WO008</td>
                            <td>LOT008</td>
                            <td>햄치즈샌드위치</td>
                            <td>100개</td>
                            <td>98개</td>
                            <td>박작업</td>
                            <td>2024-01-14</td>
                            <td>
                                <button class="action-btn btn-info" onclick="transferToQuality('WO008')">품질전달</button>
                                <button class="action-btn btn-primary" onclick="viewDetails('WO008')">상세보기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>WO009</td>
                            <td>LOT009</td>
                            <td>계란샌드위치</td>
                            <td>90개</td>
                            <td>90개</td>
                            <td>최작업</td>
                            <td>2024-01-14</td>
                            <td>
                                <button class="action-btn btn-info" onclick="transferToQuality('WO009')">품질전달</button>
                                <button class="action-btn btn-primary" onclick="viewDetails('WO009')">상세보기</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <button onclick="changePage('prev')">이전</button>
                <button class="active">1</button>
                <button onclick="changePage(2)">2</button>
                <button onclick="changePage(3)">3</button>
                <button onclick="changePage(4)">4</button>
                <button onclick="changePage(5)">5</button>
                <button onclick="changePage('next')">다음</button>
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

        /**
         * 작업량 설정 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function setWorkQuantity(workOrderId) {
            const quantity = prompt('작업할 수량을 입력하세요:', '');
            if (quantity && !isNaN(quantity) && quantity > 0) {
                alert('작업량이 설정되었습니다: ' + quantity + '개');
                // 실제 구현에서는 서버로 데이터 전송
                console.log('작업량 설정:', workOrderId, quantity);
            }
        }

        /**
         * 작업자 배정 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function assignWorker(workOrderId) {
            const worker = prompt('작업자명을 입력하세요:', '');
            if (worker && worker.trim() !== '') {
                alert('작업자가 배정되었습니다: ' + worker);
                // 실제 구현에서는 서버로 데이터 전송
                console.log('작업자 배정:', workOrderId, worker);
            }
        }

        /**
         * 작업 진행률 업데이트 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function updateProgress(workOrderId) {
            const progress = prompt('현재 진행률을 입력하세요 (0-100):', '');
            if (progress && !isNaN(progress) && progress >= 0 && progress <= 100) {
                alert('진행률이 업데이트되었습니다: ' + progress + '%');
                // 실제 구현에서는 서버로 데이터 전송
                console.log('진행률 업데이트:', workOrderId, progress);
            }
        }

        /**
         * 작업 완료 처리 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function completeWork(workOrderId) {
            if (confirm('작업을 완료하시겠습니까?')) {
                const completedQty = prompt('완료 수량을 입력하세요:', '');
                if (completedQty && !isNaN(completedQty) && completedQty > 0) {
                    alert('작업이 완료되었습니다: ' + completedQty + '개');
                    // 실제 구현에서는 서버로 데이터 전송 후 완료 탭으로 이동
                    console.log('작업 완료:', workOrderId, completedQty);
                }
            }
        }

        /**
         * 품질관리로 전달 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function transferToQuality(workOrderId) {
            if (confirm('품질관리로 전달하시겠습니까?')) {
                alert('품질관리로 전달되었습니다.');
                // 실제 구현에서는 서버로 데이터 전송
                console.log('품질관리 전달:', workOrderId);
            }
        }

        /**
         * 상세보기 기능
         * @param {string} workOrderId - 작업지시번호
         */
        function viewDetails(workOrderId) {
            alert('작업 상세 정보를 표시합니다: ' + workOrderId);
            // 실제 구현에서는 상세 정보 모달 또는 별도 페이지로 이동
            console.log('상세보기:', workOrderId);
        }

        /**
         * 페이지 변경 기능
         * @param {string|number} page - 페이지 번호 또는 'prev', 'next'
         */
        function changePage(page) {
            if (page === 'prev') {
                alert('이전 페이지로 이동');
            } else if (page === 'next') {
                alert('다음 페이지로 이동');
            } else {
                alert('페이지 ' + page + '로 이동');
            }
            // 실제 구현에서는 서버로 페이지 요청
            console.log('페이지 변경:', page);
        }
    </script>
</body>
</html>
