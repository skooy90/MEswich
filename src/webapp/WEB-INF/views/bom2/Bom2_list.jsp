<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    min-height: 100vh;
    background-color: #fff;
}

h2 {
    margin-bottom: 20px;
    text-align: center;
}

.actions {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 15px;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
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
    background-color: #2c3e50;
    color: #fff;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    text-decoration: none;
    cursor: pointer;
    font-size: 14px;
}
.btn:hover {
    background-color: #1a252f;
}

.btn-update {
    background-color: #27ae60;
}
.btn-update:hover {
    background-color: #1e8449;
}
</style>

<div class="content">
    <h2>BOM (자재명세서) 목록</h2>

    <div class="actions">
        <a href="/mes/bom2/insertForm" class="btn">+ 신규 등록</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>제품코드</th>
                <th>제품명</th>
                <th>등록자</th>
                <th>등록일</th>
                <th colspan="2">관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bom" items="${bomList}">
                <tr>
                    <td>${bom.productCode}</td>
                    <td>${bom.productName}</td>
                    <td>${bom.createdBy}</td>
                    <td><fmt:formatDate value="${bom.createdDate}" pattern="yyyy-MM-dd" /></td>
                    <td>
                        <a href="/mes/bom2/detail/${bom.productCode}" class="btn">상세보기</a>
                    </td>
                    <td>
                        <a href="/mes/bom2/updateForm/${bom.bomId}" class="btn btn-update">수정</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>




