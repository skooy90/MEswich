<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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


.form-card {
    width: 600px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
    padding: 30px;
    border: 1px solid #e9ecef;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #f1f3f5;
}

th {
    width: 120px;
    color: #495057;
    font-weight: 600;
    background-color: #f8f9fa;
}

td {
    color: #212529;
}

input, select {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    font-size: 14px;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

input:focus, select:focus {
    outline: none;
    border-color: #2c3e50;
    box-shadow: 0 0 0 0.2rem rgba(44, 62, 80, 0.25);
}

input[readonly] {
    background-color: #f8f9fa;
    color: #6c757d;
}

.btn-area {
    margin-top: 25px;
    text-align: center;
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn {
    background-color: #2c3e50;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.15s ease-in-out;
    display: inline-block;
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

/* 반응형 디자인 */
@media (max-width: 768px) {
    .content {
        margin-left: 0;
        padding: 10px;
    }
    
    .form-card {
        width: 100%;
        padding: 20px;
    }
    
    th, td {
        padding: 10px 8px;
        font-size: 14px;
    }
    
    .btn-area {
        flex-direction: column;
    }
}
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
