<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    background-color: #fff;
    min-height: 100vh;
}
.form-card {
    width: 400px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    padding: 25px;
}
h2 {
    text-align: center;
    color: #2c3e50;
    margin-bottom: 20px;
}
input {
    width: 100%;
    padding: 8px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.btn {
    background-color: #2c3e50;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
}
.btn:hover {
    background-color: #1a252f;
}
.btn-secondary {
    background-color: #7f8c8d;
    text-align: center;
    display: block;
    padding: 8px 16px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
}
</style>

<div class="content">
    <div class="form-card">
        <h2>비밀번호 변경</h2>
       <form id="passwordForm" action="${pageContext.request.contextPath}/mypage/changePassword" method="post" onsubmit="return validatePassword()">
    <label>현재 비밀번호</label>
    <input type="password" name="currentPassword" required />

    <label>새 비밀번호</label>
    <input type="password" id="newPassword" name="newPassword" required />

    <button type="submit" class="btn">비밀번호 변경</button>
</form>
<a href="${pageContext.request.contextPath}/mypage" class="btn-secondary" style="margin-top:10px;">취소</a>
    </div>
</div>

<script>
function validatePassword() {
    const newPassword = document.getElementById("newPassword").value;

    // ✅ 비밀번호 유효성 검사
    const hasNumber = /[0-9]/.test(newPassword);
    const hasLetter = /[A-Za-z]/.test(newPassword);
    const isLongEnough = newPassword.length >= 8;

    if (!isLongEnough || !hasNumber || !hasLetter) {
        alert("비밀번호는 8자 이상이며, 숫자와 영문자를 모두 포함해야 합니다.");
        return false;
    }

    return true;
}
</script>