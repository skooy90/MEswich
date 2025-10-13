<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

        .status-planned {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .status-in-progress {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .status-completed {
            background-color: #e8f5e8;
            color: #388e3c;
        }

        .status-cancelled {
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
    </style>
</head>

<body>
<%--     <%@ include file="../basic/header.jsp" %> --%>
<%--     <%@ include file="../basic/sidebar.jsp" %> --%>

    <main class="main-content">
        <h2>🏭 생산관리</h2>
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form">
                <input type="text" name="lotNumber" placeholder="LOT번호" />
                <input type="text" name="productName" placeholder="제품명" />
                <select name="status">
                    <option value="">전체 상태</option>
                    <option value="PLANNED">계획</option>
                    <option value="IN_PROGRESS">진행중</option>
                    <option value="COMPLETED">완료</option>
                    <option value="CANCELLED">취소</option>
                </select>
                <button type="submit">🔍 검색</button>
                <button type="button" onclick="openCreateProductionPlan()">➕ 생산계획추가</button>
            </form>
        </div>

        <!-- LOT 목록 테이블 -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>LOT번호</th>
                        <th>제품명</th>
                        <th>수량</th>
                        <th>상태</th>
                        <th>생성일</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 샘플 데이터 -->
                    <tr>
                        <td>LOT20241201001</td>
                        <td>햄치즈샌드위치</td>
                        <td>100개</td>
                        <td><span class="status status-in-progress">진행중</span></td>
                        <td>2024-12-01</td>
                    </tr>
                    <tr>
                        <td>LOT20241201002</td>
                        <td>계란샌드위치</td>
                        <td>150개</td>
                        <td><span class="status status-completed">완료</span></td>
                        <td>2024-12-01</td>
                    </tr>
                    <tr>
                        <td>LOT20241201003</td>
                        <td>참치샌드위치</td>
                        <td>80개</td>
                        <td><span class="status status-planned">계획</span></td>
                        <td>2024-12-01</td>
                    </tr>
                    <tr>
                        <td>LOT20241201004</td>
                        <td>햄치즈샌드위치</td>
                        <td>120개</td>
                        <td><span class="status status-planned">계획</span></td>
                        <td>2024-12-01</td>
                    </tr>
                    <tr>
                        <td>LOT20241201005</td>
                        <td>계란샌드위치</td>
                        <td>90개</td>
                        <td><span class="status status-in-progress">진행중</span></td>
                        <td>2024-12-01</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div style="text-align: center; margin-top: 20px;">
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
        // 생산 계획 추가 모달 열기
        function openCreateProductionPlan() {
            alert('생산 계획 추가 기능 - 추후 구현 예정');
        }

        // 검색 기능
        function searchLots() {
            alert('검색 기능 - 추후 구현 예정');
        }

        // 페이지네이션
        function goToPage(pageNumber) {
            alert('페이지 ' + pageNumber + '로 이동 - 추후 구현 예정');
        }
    </script>
</body>
</html>