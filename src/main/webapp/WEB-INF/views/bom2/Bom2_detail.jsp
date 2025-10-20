<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    margin-bottom: 15px;
}

.info-box {
    margin-bottom: 20px;
    padding: 10px 15px;
    border-left: 4px solid #2c3e50;
    background-color: #f9fafb;
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
    border-radius: 4px;
    text-decoration: none;
    margin-top: 20px;
    display: inline-block;
}
.btn:hover {
    background-color: #1a252f;
}
</style>

<div class="content">
    <h2>BOM 상세 정보</h2>

    <div class="info-box">
        <p><strong>제품 코드:</strong> ${productCode}</p>
        <p><strong>등록된 자재 수:</strong> ${fn:length(bomList)}</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>자재코드</th>
                <th>자재명</th>
                <th>단위</th>
                <th>수량</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="bom" items="${bomList}">
                <tr>
                    <td>${bom.materialCode}</td>
                    <td>${bom.materialName}</td>
                    <td>${bom.unit}</td>
                    <td>${bom.quantity}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <a href="/mes/bom2/list" class="btn">← 목록으로</a>
</div>



