<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    background-color: #fff;
    min-height: 100vh;
}

h2 {
    margin-bottom: 20px;
}

.table-container {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    padding: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
}
th {
    background-color: #f4f6f8;
}
tr:hover {
    background-color: #f9f9f9;
}
.btn {
    display: inline-block;
    background-color: #2c3e50;
    color: #fff;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    text-decoration: none;
    cursor: pointer;
}
.btn:hover {
    background-color: #1a252f;
}
.btn-secondary {
    background-color: #7f8c8d;
}
.btn-danger {
    background-color: #c0392b;
}
.btn-danger:hover {
    background-color: #922b21;
}
.action-links a {
    margin: 0 6px;
    text-decoration: none;
}
</style>

<div class="content">
    <h2>사용자 관리</h2>

    <div style="text-align: right; margin-bottom: 15px;">
        <a href="${pageContext.request.contextPath}/users2/insertForm" class="btn">+ 신규 사용자 등록</a>
    </div>

    <div class="table-container">
    <c:if test="${param.updated eq 'true'}">
    <script>
        alert('수정 완료되었습니다.');
    </script>
</c:if>
        <table>
<thead>
    <tr>
        <th>사번</th>
        <th>이름</th>
        <th>권한</th>
        <th>상태</th>
        <th>등록일</th>
        <th>등록자</th>
	    <th>수정일</th>       <!-- ✅ 추가 -->
	    <th>수정자</th>       <!-- ✅ 추가 -->
        <th>관리</th>
    </tr>
</thead>
<tbody>
    <c:forEach var="u" items="${userList}">
        <tr>
            <td>${u.userId}</td>
            <td>${u.userName}</td>
            <td>${u.role}</td>
            <td>${u.status}</td>
            <td>
                <fmt:formatDate value="${u.createdDate}" pattern="yyyy-MM-dd" />
            </td>
            <td>${u.createdBy}</td>
               <td><fmt:formatDate value="${u.updatedDate}" pattern="yyyy-MM-dd" /></td> <!-- ✅ -->
        		<td>${u.updatedBy}</td> <!-- ✅ -->
            <td class="action-links">
                <a href="${pageContext.request.contextPath}/users2/updateForm/${u.userId}" style="color:#2980b9;">수정</a> |
                <a href="${pageContext.request.contextPath}/users2/delete/${u.userId}" style="color:#c0392b;"
                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </td>
        </tr>
    </c:forEach>
</tbody>
        </table>
    </div>
</div>
