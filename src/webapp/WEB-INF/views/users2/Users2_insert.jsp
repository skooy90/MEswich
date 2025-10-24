<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
    color: #2c3e50;
}

.form-card {
    width: 500px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    padding: 25px;
}

table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    padding: 10px;
    text-align: left;
}
th {
    width: 120px;
    color: #2c3e50;
}
input, select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
.btn-area {
    margin-top: 20px;
    text-align: center;
}
.btn {
    background-color: #2c3e50;
    color: #fff;
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
}
.btn:hover {
    background-color: #1a252f;
}
.btn-secondary {
    background-color: #7f8c8d;
}
.btn-secondary:hover {
    background-color: #606e73;
}
</style>

<div class="content">
    <h2>신규 사용자 등록</h2>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/users2/insert" method="post">
            <table>
					<tr>
					    <th>사번</th>
					    <td><input type="text" name="userId" value="${newUserId}" readonly></td>
					</tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="userName" required></td>
                </tr>
                <tr>
                    <th>부서</th>
                    <td><input type="text" name="department" placeholder="예: 생산팀, 품질팀"></td>
                </tr>
                <tr>
                    <th>권한</th>
                    <td>
                        <select name="role" required>
                            <option value="">-- 선택 --</option>
                            <option value="ADMIN">관리자</option>
                            <option value="USER">일반 사용자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="text" name="password" placeholder="입력하지 않으면 사번으로 설정됩니다."></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn">등록</button>
                <a href="${pageContext.request.contextPath}/users2/list" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
</div>
