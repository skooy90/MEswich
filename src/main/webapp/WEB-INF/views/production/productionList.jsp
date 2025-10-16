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
        
        <!-- 검색 영역 -->
        <div class="search-area">
            <form class="search-form" method="get" action="/production/search">
                <input type="text" name="lotNumber" placeholder="LOT번호" value="${searchCondition.lotNumber}" />
                <input type="text" name="productCode" placeholder="제품코드" value="${searchCondition.productCode}" />
                <select name="status">
                    <option value="">전체 상태</option>
                    <option value="PLANNED" ${searchCondition.status == 'PLANNED' ? 'selected' : ''}>계획</option>
                    <option value="IN_PROGRESS" ${searchCondition.status == 'IN_PROGRESS' ? 'selected' : ''}>진행중</option>
                    <option value="COMPLETED" ${searchCondition.status == 'COMPLETED' ? 'selected' : ''}>완료</option>
                    <option value="CANCELLED" ${searchCondition.status == 'CANCELLED' ? 'selected' : ''}>취소</option>
                </select>
                <button type="submit">🔍 검색</button>
                <a href="create" class="btn-create">➕ 생산계획추가</a>
            </form>
        </div>

        <!-- LOT 목록 테이블 -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>LOT번호</th>
                        <th>제품코드</th>
                        <th>제품명</th>
                        <th>계획수량</th>
                        <th>실제수량</th>
                        <th>상태</th>
                        <th>계획시작일</th>
                        <th>계획종료일</th>
                        <th>생성일</th>
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
                                                <c:when test="${production.status == 'IN_PROGRESS'}">진행중</c:when>
                                                <c:when test="${production.status == 'COMPLETED'}">완료</c:when>
                                                <c:when test="${production.status == 'CANCELLED'}">취소</c:when>
                                                <c:otherwise>${production.status}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${production.plannedStartDate}" pattern="yyyy-MM-dd" /></td>
                                    <td><fmt:formatDate value="${production.plannedEndDate}" pattern="yyyy-MM-dd" /></td>
                                    <td><fmt:formatDate value="${production.createdDate}" pattern="yyyy-MM-dd" /></td>
                                    <td>
                                        <a href="/mes/production/edit?lotNumber=${production.lotNumber}" class="btn btn-warning">수정</a>
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
                                <td colspan="9" style="text-align: center; padding: 20px;">
                                    등록된 생산 LOT가 없습니다.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
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
         * 페이지네이션 기능
         * @param {number} pageNumber - 페이지 번호
         */
        function goToPage(pageNumber) {
            alert('페이지 ' + pageNumber + '로 이동 - 추후 구현 예정');
        }
    </script>
</body>
</html>
