<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <h2>LOT 추적 이력</h2>
    <form action="/mes/lotTracking2/search" method="get" style="margin-bottom:10px;">
        LOT 번호:
        <input type="text" name="lotNumber" value="${lotNumber}" required />
        <button type="submit">조회</button>
    </form>

    <c:if test="${not empty trackingList}">
        <table border="1" cellpadding="6" cellspacing="0" style="width:90%;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>상태</th>
                    <th>시작일</th>
                    <th>종료일</th>
                    <th>비고</th>
                    <th>수정자</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="row" items="${trackingList}">
                    <tr>
                        <td>${row.trackingId}</td>
                        <td>${row.status}</td>
                        <td><fmt:formatDate value="${row.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${row.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>${row.remarks}</td>
                        <td>${row.updatedBy}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
<style>
/* 전체 콘텐츠 영역 */
.content {
    margin-left: 220px;           /* 사이드바 폭 만큼 여백 확보 */
    margin-top: 70px;             /* 헤더 높이만큼 아래로 */
    padding: 20px 40px;
    background-color: #f9fafb;
    min-height: calc(100vh - 70px);
}

/* 제목 */
.content h2 {
    font-size: 22px;
    margin-bottom: 20px;
    color: #2c3e50;
}

/* 검색 폼 */
.content form {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}

.content input[type="text"] {
    padding: 6px 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.content button {
    background-color: #34495e;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.2s;
}
.content button:hover {
    background-color: #2c3e50;
}

/* 테이블 */
table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
}

thead {
    background-color: #2c3e50;
    color: white;
}

th, td {
    text-align: center;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

tbody tr:hover {
    background-color: #f2f6fa;
}

</style>

