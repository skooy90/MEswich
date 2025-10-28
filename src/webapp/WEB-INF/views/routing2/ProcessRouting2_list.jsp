<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <div class="page-header">
        <h2>공정 라우팅 목록</h2>
        <a href="/mes/processRouting2/insertForm" class="btn-add">+ 신규 공정 등록</a>
    </div>

    <div class="table-container">
        <table class="table-list">
            <thead>
                <tr>
                    <th>제품 코드</th>
                    <th>제품명</th>
                    <th>등록자</th>
                    <th>등록일</th>
                    <th colspan="2">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${routingSummary}">
                    <tr>
                        <td>${item.productCode}</td>
                        <td>${item.productName}</td>
                        <td>${item.createdBy}</td>
                        <td><fmt:formatDate value="${item.createdDate}" pattern="yyyy-MM-dd" /></td>
<td class="action-cell">
    <a href="/mes/processRouting2/detail/${item.productCode}" class="btn-detail">상세</a>
    <a href="/mes/processRouting2/delete/${item.productCode}" 
       class="btn-delete"
       onclick="return confirm('해당 제품(${item.productName})의 모든 공정을 삭제하시겠습니까?');">
       삭제
    </a>
</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<style>
/* ✅ 전체 레이아웃 */
.content {
    margin-left: 220px;
    margin-top: 70px;
    padding: 40px 70px;
    background: #f4f6f9;
    min-height: 100vh;
    font-family: 'Segoe UI', sans-serif;
}

/* ✅ 제목 + 버튼 */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    padding: 14px 20px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}

.page-header h2 {
    font-size: 22px;
    font-weight: 700;
    color: #2c3e50;
    margin: 0;
}

/* 신규 등록 버튼 */
.btn-add {
    display: inline-block;
    background: linear-gradient(135deg, #4a90e2, #357abd);
    color: #fff;
    padding: 9px 16px;
    border-radius: 6px;
    font-weight: 600;
    font-size: 14px;
    text-decoration: none;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    transition: all 0.25s ease;
}
.btn-add:hover {
    background: linear-gradient(135deg, #357abd, #2c3e50);
    transform: translateY(-2px);
    box-shadow: 0 5px 10px rgba(0,0,0,0.2);
}

/* ✅ 테이블 카드 */
.table-container {
    background: #fff;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
}

/* ✅ 테이블 기본 */
.table-list {
    width: 100%;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
}

.table-list th, .table-list td {
    padding: 14px;
    text-align: center;
    font-size: 15px;
    border-bottom: 1px solid #e0e0e0;
}

.table-list th {
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: #fff;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.table-list tr:nth-child(even) {
    background: #fafafa;
}

.table-list tr:hover {
    background: #eef4ff;
    transition: background 0.2s;
}

/* ✅ 상세 버튼 */
.btn-detail {
    background: #3498db;
    color: #fff;
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: 0.2s;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}
.btn-detail:hover {
    background: #2980b9;
    transform: translateY(-2px);
}

/* 관리 버튼 셀 */
.action-cell {
    display: flex;
    justify-content: center;
    gap: 8px; /* 버튼 간 간격 (필요시 6~10px로 조정 가능) */
}

/* 버튼 기본 디자인 */
.btn-detail, .btn-delete {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 5px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    color: #fff;
    transition: 0.2s;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}

/* 상세 버튼 */
.btn-detail {
    background: #3498db;
}
.btn-detail:hover {
    background: #2980b9;
    transform: translateY(-2px);
}

/* 삭제 버튼 */
.btn-delete {
    background: #e74c3c;
}
.btn-delete:hover {
    background: #c0392b;
    transform: translateY(-2px);
}
</style>



