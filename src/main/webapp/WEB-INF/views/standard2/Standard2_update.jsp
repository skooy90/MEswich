<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 상세 및 수정</title>
</head>
<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/basic/header.jsp" />

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<!-- 🟢 본문 -->
<div class="content">
    <h2>품목 상세 / 수정</h2>

    <form action="${pageContext.request.contextPath}/standard2/update" method="post">
        <input type="hidden" name="itemCode" value="${standard.itemCode}" />

        <table border="1">
            <tr>
                <th>품목코드</th>
                <td><input type="text" name="itemCodeDisplay" value="${standard.itemCode}" readonly></td>
            </tr>

            <tr>
                <th>품목명</th>
                <td><input type="text" name="itemName" value="${standard.itemName}" required></td>
            </tr>

            <tr>
                <th>품목유형</th>
                <td>
                    <select name="itemType" disabled>
                        <option value="FG" ${standard.itemType == 'FG' ? 'selected' : ''}>완제품</option>
                        <option value="RM" ${standard.itemType == 'RM' ? 'selected' : ''}>원자재</option>
                    </select>
                </td>
            </tr>

					<tr>
					    <th>단위</th>
					    <td>
					        <select name="unit" disabled>
					            <option value="KG" ${standard.unit == 'KG' ? 'selected' : ''}>KG</option>
					            <option value="L" ${standard.unit == 'L' ? 'selected' : ''}>L</option>
					            <option value="EA" ${standard.unit == 'EA' ? 'selected' : ''}>EA</option>
					        </select>
					    </td>
					</tr>

            <tr>
                <th>생성일</th>
                <td><input type="text" name="createdDate" value="${standard.createdDate}" readonly></td>
            </tr>

            <tr>
                <th>수정일</th>
                <td><input type="text" name="updatedDate" value="${standard.updatedDate}" readonly></td>
            </tr>

            <tr>
                <th>생성자</th>
                <td><input type="text" name="createdBy" value="${standard.createdBy}" readonly></td>
            </tr>

            <tr>
                <th>수정자</th>
                <td><input type="text" name="updatedBy" value="${standard.updatedBy}" required></td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="submit">저장</button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/standard2/list'">목록으로</button>
        </div>
    </form>
</div>

<!-- 하단 푸터 -->
<jsp:include page="/WEB-INF/views/basic/footer.jsp" />

<!-- 🧩 스타일 -->
<style>
.content {
    margin-left: 220px;
    margin-top: 80px;
    padding: 20px;
}

h2 {
    margin-bottom: 20px;
    color: #2c3e50;
}

table {
    border-collapse: collapse;
    width: 500px;
    background: #fff;
}

th, td {
    border: 1px solid #ccc;
    padding: 8px 10px;
    text-align: left;
}

th {
    background-color: #ecf0f1;
    width: 140px;
}

input[type="text"], select {
    width: 95%;
    padding: 6px;
    box-sizing: border-box;
}

input[readonly], select[disabled] {
    background-color: #f5f5f5;
    color: #666;
    cursor: not-allowed;
}

.btn-area {
    margin-top: 20px;
}

button {
    padding: 8px 14px;
    border: none;
    border-radius: 5px;
    background-color: #2c3e50;
    color: white;
    cursor: pointer;
    margin-right: 5px;
}

button:hover {
    background-color: #34495e;
}
</style>

</body>
</html>
