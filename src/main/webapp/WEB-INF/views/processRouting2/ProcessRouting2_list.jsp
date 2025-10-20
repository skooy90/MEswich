<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>공정관리 목록</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/basic/header.jsp"/>
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp"/>

<div class="content">
    <h2>공정 라우팅 목록</h2>
    <table border="1" cellpadding="8" cellspacing="0" style="width:90%; text-align:center;">
        <thead>
            <tr style="background-color:#f1f1f1;">
                <th>라우팅 ID</th>
                <th>제품 코드</th>
                <th>제품명</th>
                <th>등록자</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="r" items="${routingList}">
                <tr>
                    <td>${r.routingId}</td>
                    <td>${r.productCode}</td>
                    <td>${r.productName}</td>
                    <td>${r.createdBy}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/processRouting2/detail/${r.productCode}"
                           class="btn btn-sm btn-primary">상세</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<style>
.content { margin-left:220px; margin-top:80px; padding:20px; }
.btn { background:#2c3e50; color:#fff; padding:6px 10px; border-radius:4px; text-decoration:none; }
.btn:hover { opacity:0.8; }
</style>
</body>
</html>

