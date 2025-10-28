<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp"/>
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp"/>

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    min-height: 100vh;
    background-color: #fff;
}
h2 {
    color: #2c3e50;
    margin-bottom: 25px;
}
.info-card {
    display: flex;
    justify-content: space-between;
    gap: 30px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    padding: 25px;
}
.section {
    flex: 1;
}
.section h3 {
    color: #34495e;
    margin-bottom: 15px;
}
.table-box table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    padding: 10px;
    border-bottom: 1px solid #eee;
}
th {
    text-align: left;
    width: 120px;
    color: #2c3e50;
}
.btn-area {
    margin-top: 30px;
    text-align: center;
}
.btn {
    background-color: #2c3e50;
    color: #fff;
    padding: 8px 18px;
    border: none;
    border-radius: 6px;
    text-decoration: none;
}
.btn:hover {
    background-color: #1a252f;
}
</style>

<div class="content">
    <h2>마이페이지</h2>

    <div class="info-card">
        <!-- 기본 정보 -->
        <div class="section">
            <h3>기본 정보</h3>
            <div class="table-box">
                <table>
                    <tr><th>사원번호</th><td>${user.userId}</td></tr>
                    <tr><th>이름</th><td>${user.userName}</td></tr>
                    <tr><th>권한</th><td>${user.role}</td></tr>
                    <tr><th>상태</th><td>${user.status}</td></tr>
                </table>
            </div>
        </div>

<!-- 계정 정보 -->
<div class="section">
    <h3>계정 정보</h3>
    <div class="table-box">
        <table>
            <tr><th>비밀번호 상태</th><td>정상</td></tr>
            <tr><th>가입일</th><td><fmt:formatDate value="${user.createdDate}" pattern="yyyy-MM-dd"/></td></tr>
            <tr><th>최종 수정일</th><td><fmt:formatDate value="${user.updatedDate}" pattern="yyyy-MM-dd"/></td></tr>
            <tr><th>마지막 접속일</th><td><fmt:formatDate value="${user.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr> <!-- ✅ 변경 -->
        </table>
    </div>
</div>

    <div class="btn-area">
        <a href="${pageContext.request.contextPath}/mypage/changePasswordForm" class="btn">비밀번호 변경</a>
    </div>
</div>
