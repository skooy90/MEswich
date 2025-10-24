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
    width: 500px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    padding: 25px;
}
h2 { margin-bottom: 20px; color: #2c3e50; }
input, select {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
th, td { padding: 10px; text-align: left; }
th { width: 120px; color: #2c3e50; }
.btn-area { margin-top: 20px; text-align: center; }
.btn {
    background-color: #2c3e50;
    color: #fff;
    padding: 8px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
}
.btn:hover { background-color: #1a252f; }
.btn-secondary {
    background-color: #7f8c8d;
}
.btn-secondary:hover { background-color: #606e73; }
</style>

<div class="content">
    <h2>사용자 정보 수정</h2>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/users2/update" method="post">
            <table>
                <tr>
                    <th>사번</th>
                    <td><input type="text" name="userId" value="${user.userId}" readonly></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><input type="text" name="userName" value="${user.userName}" required></td>
                </tr>
                <tr>
                    <th>권한</th>
                    <td>
                        <select name="role" required>
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>관리자</option>
                            <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>일반 사용자</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>
                        <select name="status">
                            <option value="ACTIVE" ${user.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                            <option value="INACTIVE" ${user.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                            <option value="LOCKED" ${user.status == 'LOCKED' ? 'selected' : ''}>LOCKED</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="text" name="password" value="${user.password}" required></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn">수정</button>
                <a href="${pageContext.request.contextPath}/users2/list" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
</div>
