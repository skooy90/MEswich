<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
/* 전역 스타일 */
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f8f9fa;
}

.content {
    margin-left: 220px;
    margin-top: 80px;
    padding: 20px;
    background-color: #f8f9fa;
    min-height: calc(100vh - 80px);
}


/* 페이지 헤더 스타일 */
.content > div:first-of-type {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}

/* 테이블 컨테이너 */
.table-container {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
    padding: 0;
    border: 1px solid #e9ecef;
    overflow: hidden;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
}

th, td {
    border: 1px solid #e9ecef;
    padding: 12px;
    font-size: 14px;
}

th {
    background-color: #f8f9fa;
    font-weight: 700;
    color: #495057;
    border-bottom: 2px solid #e9ecef;
}

tr:hover {
    background-color: #f8f9fa;
}

/* 버튼 스타일 */
.btn {
    display: inline-block;
    background-color: #2c3e50;
    color: #fff;
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    text-decoration: none;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.15s ease-in-out;
}

.btn:hover {
    background-color: #34495e;
    transform: translateY(-1px);
}

.btn-secondary {
    background-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #5a6268;
}

.btn-danger {
    background-color: #d63384;
}

.btn-danger:hover {
    background-color: #c2185b;
}

/* 액션 링크 */
.action-links a {
    margin: 0 6px;
    text-decoration: none;
    color: #0b5ed7;
    font-weight: 600;
    font-size: 14px;
}

.action-links a:hover {
    text-decoration: underline;
}

.action-links a[style*="color:#c0392b"] {
    color: #d63384 !important;
}

/* 알림 메시지 스타일 */
.content > div:first-of-type script {
    display: none;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .content {
        margin-left: 0;
        padding: 10px;
    }
    
    .content > div:first-of-type {
        flex-direction: column;
        gap: 15px;
        align-items: stretch;
    }
    
    table {
        font-size: 12px;
    }
    
    th, td {
        padding: 8px 6px;
    }
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
