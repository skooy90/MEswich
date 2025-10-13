<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 기준정보 목록</title>
</head>
<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/basic/header.jsp" />

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<!-- 🟢 본문 영역 (헤더 높이 + 사이드바 폭을 고려해 margin 설정) -->
<div class="content">
    <h2>품목 기준정보 목록</h2>
    <a href="/mes/standard2/insertForm">신규 등록</a>
    <table border="1">
        <tr>
            <th>품목코드</th>
            <th>품목명</th>
            <th>유형</th>
            <th>단위</th>
            <th>등록일</th>
            <th>생성자</th>
            <th>관리</th>
        </tr>
        <c:forEach var="s" items="${standardList}">
            <tr>
                <td>${s.itemCode}</td>
                <td>${s.itemName}</td>
                <td>${s.itemType}</td>
                <td>${s.unit}</td>
                <td><fmt:formatDate value="${s.createdDate}" pattern="yyyy-MM-dd" /></td>
                 <td>${s.createdBy}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/standard2/updateForm/${s.itemCode}">수정</a> |
                    <a href="${pageContext.request.contextPath}/standard2/delete/${s.itemCode}">삭제</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<!-- 하단 푸터 -->
<jsp:include page="/WEB-INF/views/basic/footer.jsp" />

<!-- 🟢 본문 영역 레이아웃 CSS -->
<style>
.content {
    margin-left: 220px; /* 사이드바 너비만큼 띄움 */
    margin-top: 80px;  /* 헤더 높이만큼 띄움 */
    padding: 20px;
}
table {
    border-collapse: collapse;
    width: 90%;
}
th, td {
    padding: 8px;
    text-align: center;
}
</style>

</body>
</html>