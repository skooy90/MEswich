<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>로그인</title>
<style>
body {
	font-family: '맑은 고딕';
	background: #f8f9fa;
}

.login-box {
	width: 350px;
	margin: 120px auto;
	padding: 30px;
	border-radius: 10px;
	background: #fff;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

input {
	width: 100%;
	padding: 10px;
	margin: 8px 0;
	border: 1px solid #ccc;
	border-radius: 4px;
}

button {
	width: 100%;
	padding: 10px;
	background: #2c3e50;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background: #1a252f;
}
</style>
</head>
<body>
	<div class="login-box">
		<h2>MES 로그인</h2>
		<form action="${pageContext.request.contextPath}/auth/login"
			method="post">
			<input type="text" name="userId" placeholder="아이디" required /> <input
				type="password" name="password" placeholder="비밀번호" required />
			<button type="submit">로그인</button>
		</form>

		<c:if test="${not empty error}">
			<p style="color: red;">${error}</p>
		</c:if>
	</div>
</body>
</html>
