<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
            min-width: 120px; /* 셀렉트 박스 최소 너비 */
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
            flex: 1; /* 3등분으로 균등 분할 */
            padding: 15px 20px; /* 상하 패딩 증가 */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s;
            min-height: 50px; /* 최소 높이 설정 */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .tab-btn.active {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .tab-btn.waiting {
            background-color: #f39c12;
            color: white;
        }

        .tab-btn.waiting:hover {
            background-color: #e67e22;
        }

        .tab-btn.inspecting {
            background-color: #3498db;
            color: white;
        }

        .tab-btn.inspecting:hover {
            background-color: #2980b9;
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

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: none;
            border-radius: 8px;
            width: 80%;
            max-width: 600px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }

        .modal-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover {
            color: #000;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #2c3e50;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group textarea {
            height: 80px;
            resize: vertical;
        }

        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
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
            background-color: #27ae60;
            color: white;
            border-color: #27ae60;
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
            
            .quality-list {
                font-size: 12px;
            }
            
            .quality-list th, .quality-list td {
                padding: 8px 4px;
            }
            
            .modal-content {
                width: 95%;
                margin: 10% auto;
            }
        }
    </style>
</head>

<body>

    <main class="main-content">
        <h2>🔍 품질관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="">
                <select name="searchCategory" class="search-select">
                    <option value="productName" ${param.searchCategory == 'productName' ? 'selected' : ''}>제품명</option>
                    <option value="inspectionId" ${param.searchCategory == 'inspectionId' ? 'selected' : ''}>검사번호</option>
                    <option value="lotNumber" ${param.searchCategory == 'lotNumber' ? 'selected' : ''}>LOT번호</option>
                    <option value="inspector" ${param.searchCategory == 'inspector' ? 'selected' : ''}>검사자</option>
                </select>
                <input type="text" name="searchKeyword" placeholder="검색어를 입력하세요" value="${param.searchKeyword}">
                <button type="submit" class="search-btn">🔍 검색</button>
            </form>
        </div>

        <!-- 탭 영역 -->
        <div class="tab-area">
            <div class="tab-buttons">
                <button class="tab-btn waiting active" onclick="showTab('waiting')">
                    🟡 검사대기
                </button>
                <button class="tab-btn inspecting" onclick="showTab('inspecting')">
                    🔍 검사중
                </button>
                <button class="tab-btn completed" onclick="showTab('completed')">
                    ✅ 검사완료
                </button>
            </div>
        </div>

        <!-- 목록 영역 -->
        <div class="list-area">
            <!-- 검사대기 탭 -->
            <div id="waiting-tab" class="tab-content">
                <div class="list-header">📋 품질 검사 목록 (검사대기)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>작업완료수량</th>
                            <th>검사자</th>
                            <th>검사일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>QI001</td>
                            <td>LOT001</td>
                            <td>햄치즈샌드위치</td>
                            <td>100개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-warning" onclick="startInspection('QI001')">검사시작</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI004</td>
                            <td>LOT004</td>
                            <td>햄치즈샌드위치</td>
                            <td>120개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-warning" onclick="startInspection('QI004')">검사시작</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI005</td>
                            <td>LOT005</td>
                            <td>계란샌드위치</td>
                            <td>90개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-warning" onclick="startInspection('QI005')">검사시작</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI006</td>
                            <td>LOT006</td>
                            <td>참치샌드위치</td>
                            <td>80개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-warning" onclick="startInspection('QI006')">검사시작</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI007</td>
                            <td>LOT007</td>
                            <td>햄치즈샌드위치</td>
                            <td>110개</td>
                            <td>미배정</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-warning" onclick="startInspection('QI007')">검사시작</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 검사중 탭 -->
            <div id="inspecting-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 품질 검사 목록 (검사중)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>작업완료수량</th>
                            <th>검사자</th>
                            <th>검사시작일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>QI002</td>
                            <td>LOT002</td>
                            <td>햄치즈샌드위치</td>
                            <td>98개</td>
                            <td>김검사</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-success" onclick="completeInspection('QI002')">검사완료</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI003</td>
                            <td>LOT003</td>
                            <td>계란샌드위치</td>
                            <td>90개</td>
                            <td>이검사</td>
                            <td>2024-01-15</td>
                            <td>
                                <button class="action-btn btn-success" onclick="completeInspection('QI003')">검사완료</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 검사완료 탭 -->
            <div id="completed-tab" class="tab-content" style="display: none;">
                <div class="list-header">📋 품질 검사 목록 (검사완료)</div>
                <table class="quality-list">
                    <thead>
                        <tr>
                            <th>검사번호</th>
                            <th>LOT번호</th>
                            <th>제품명</th>
                            <th>완품수량</th>
                            <th>불량수량</th>
                            <th>검사자</th>
                            <th>검사완료일</th>
                            <th>기능</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>QI008</td>
                            <td>LOT008</td>
                            <td>햄치즈샌드위치</td>
                            <td>95개</td>
                            <td>3개</td>
                            <td>박검사</td>
                            <td>2024-01-14</td>
                            <td>
                                <button class="action-btn btn-info" onclick="transferToInventory('QI008')">재고전달</button>
                                <button class="action-btn btn-primary" onclick="viewInspectionDetails('QI008')">상세보기</button>
                            </td>
                        </tr>
                        <tr>
                            <td>QI009</td>
                            <td>LOT009</td>
                            <td>계란샌드위치</td>
                            <td>88개</td>
                            <td>2개</td>
                            <td>최검사</td>
                            <td>2024-01-14</td>
                            <td>
                                <button class="action-btn btn-info" onclick="transferToInventory('QI009')">재고전달</button>
                                <button class="action-btn btn-primary" onclick="viewInspectionDetails('QI009')">상세보기</button>
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

    <!-- 검사 결과 입력 모달 -->
    <div id="inspectionModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <span class="modal-title">🔍 검사 결과 입력</span>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <form id="inspectionForm">
                <div class="form-group">
                    <label for="goodQty">완품수량:</label>
                    <input type="number" id="goodQty" name="goodQty" min="0" required>
                </div>
                <div class="form-group">
                    <label for="defectQty">불량수량:</label>
                    <input type="number" id="defectQty" name="defectQty" min="0" required>
                </div>
                <div class="form-group">
                    <label for="defectReason">불량이유:</label>
                    <textarea id="defectReason" name="defectReason" placeholder="불량이 있을 경우 사유를 입력하세요"></textarea>
                </div>
                <div class="form-group">
                    <label for="inspector">검사자:</label>
                    <select id="inspector" name="inspector" required>
                        <option value="">검사자를 선택하세요</option>
                        <option value="김검사">김검사</option>
                        <option value="이검사">이검사</option>
                        <option value="박검사">박검사</option>
                        <option value="최검사">최검사</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="inspectionDate">검사일:</label>
                    <input type="date" id="inspectionDate" name="inspectionDate" required>
                </div>
                <div class="modal-buttons">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">취소</button>
                    <button type="submit" class="btn btn-success">검사완료</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // 현재 검사 ID 저장용 변수
        let currentInspectionId = '';

        /**
         * 탭 전환 기능
         * @param {string} tabName - 표시할 탭 이름 (waiting, inspecting, completed)
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
         * 검사 시작 기능
         * @param {string} inspectionId - 검사번호
         */
        function startInspection(inspectionId) {
            const inspector = prompt('검사자명을 입력하세요:', '');
            if (inspector && inspector.trim() !== '') {
                if (confirm('검사를 시작하시겠습니까?')) {
                    alert('검사가 시작되었습니다. 검사자: ' + inspector);
                    // 실제 구현에서는 서버로 데이터 전송 후 검사중 탭으로 이동
                    console.log('검사 시작:', inspectionId, inspector);
                }
            }
        }

        /**
         * 검사 완료 기능
         * @param {string} inspectionId - 검사번호
         */
        function completeInspection(inspectionId) {
            currentInspectionId = inspectionId;
            
            // 오늘 날짜를 기본값으로 설정
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('inspectionDate').value = today;
            
            // 모달 표시
            document.getElementById('inspectionModal').style.display = 'block';
        }

        /**
         * 모달 닫기 기능
         */
        function closeModal() {
            document.getElementById('inspectionModal').style.display = 'none';
            document.getElementById('inspectionForm').reset();
            currentInspectionId = '';
        }

        /**
         * 검사 결과 제출 처리
         */
        document.getElementById('inspectionForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const goodQty = parseInt(formData.get('goodQty'));
            const defectQty = parseInt(formData.get('defectQty'));
            const defectReason = formData.get('defectReason');
            const inspector = formData.get('inspector');
            const inspectionDate = formData.get('inspectionDate');
            
            // 검증
            if (goodQty + defectQty === 0) {
                alert('완품수량과 불량수량의 합이 0이 될 수 없습니다.');
                return;
            }
            
            if (defectQty > 0 && !defectReason.trim()) {
                alert('불량이 있을 경우 불량이유를 입력해주세요.');
                return;
            }
            
            // 검사 완료 처리
            alert('검사가 완료되었습니다.\n완품: ' + goodQty + '개, 불량: ' + defectQty + '개');
            
            // 실제 구현에서는 서버로 데이터 전송
            console.log('검사 완료:', {
                inspectionId: currentInspectionId,
                goodQty: goodQty,
                defectQty: defectQty,
                defectReason: defectReason,
                inspector: inspector,
                inspectionDate: inspectionDate
            });
            
            // 모달 닫기
            closeModal();
        });

        /**
         * 재고관리로 전달 기능
         * @param {string} inspectionId - 검사번호
         */
        function transferToInventory(inspectionId) {
            if (confirm('재고관리로 완품을 전달하시겠습니까?')) {
                alert('재고관리로 전달되었습니다.');
                // 실제 구현에서는 서버로 데이터 전송
                console.log('재고관리 전달:', inspectionId);
            }
        }

        /**
         * 검사 상세보기 기능
         * @param {string} inspectionId - 검사번호
         */
        function viewInspectionDetails(inspectionId) {
            alert('검사 상세 정보를 표시합니다: ' + inspectionId);
            // 실제 구현에서는 상세 정보 모달 또는 별도 페이지로 이동
            console.log('검사 상세보기:', inspectionId);
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

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const modal = document.getElementById('inspectionModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>
