<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 50px;
    text-align: center;
    background-color: #fff;
    min-height: 100vh;
}
.message-box {
    display: inline-block;
    background: #ecf0f1;
    padding: 25px 40px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}
h3 { color: #2c3e50; margin-bottom: 20px; }
.btn {
    background-color: #2c3e50;
    color: #fff;
    padding: 8px 16px;
    border-radius: 5px;
    text-decoration: none;
}
.btn:hover {
    background-color: #1a252f;
}
</style>

<div class="content">
    <div class="message-box">
        <h3>${message}</h3>
        <a href="${pageContext.request.contextPath}/mypage" class="btn">마이페이지로 돌아가기</a>
    </div>
</div>
