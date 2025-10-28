<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <h2>공정 수정</h2>

    <form action="/mes/processRouting2/update" method="post" class="card-form">
        <div class="card">
            <input type="hidden" name="routingId" value="${processRouting.routingId}" />

            <label>제품 코드</label>
            <input type="text" name="productCode" value="${processRouting.productCode}" readonly />

            <label>공정 순서</label>
            <input type="number" name="operationSeq" value="${processRouting.operationSeq}" required />

            <label>공정 코드</label>
            <input type="text" name="operationCode" value="${processRouting.operationCode}" required />

            <label>공정명</label>
            <input type="text" name="operationName" value="${processRouting.operationName}" required />

            <label>표준 시간</label>
            <input type="number" name="standardTime" value="${processRouting.standardTime}" required />

            <label>공정 설명</label>
            <textarea name="operationDesc">${processRouting.operationDesc}</textarea>

            <label>수정자</label>
            <input type="text" name="updatedBy" value="admin" readonly />

            <div class="btn-group">
                <button type="submit">수정 완료</button>
                <a href="/mes/processRouting2/detail/${processRouting.productCode}">취소</a>
            </div>
        </div>
    </form>
</div>

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    background-color: #fff;
    min-height: 100vh;
}
.card {
    max-width: 600px;
    margin: auto;
    background: #fafafa;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}
.card label {
    font-weight: bold;
    margin-top: 12px;
    display: block;
}
.card input, .card textarea {
    width: 100%;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ccc;
}
.card textarea { resize: vertical; height: 80px; }
.btn-group {
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
}
.btn-group button {
    background-color: #3498db;
    color: white;
    padding: 10px 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
.btn-group a {
    text-decoration: none;
    color: #333;
    padding: 10px 16px;
    background-color: #eee;
    border-radius: 5px;
}
</style>
