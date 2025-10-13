<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 등록</title>
</head>
<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/basic/header.jsp" />

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<!-- 🟢 본문 영역 -->
<div class="content">
    <h2>품목 등록</h2>

    <form action="${pageContext.request.contextPath}/standard2/insert" method="post">
        <table border="1">
            <tr>
                <th>품목명</th>
                <td><input type="text" name="itemName" required></td>
            </tr>
            <tr>
                <th>품목유형</th>
                <td>
                    <select name="itemType" required>
                        <option value="">--선택--</option>
                        <option value="FG">완제품</option>
                        <option value="RM">원자재</option>
                    </select>
                </td>
            </tr>
            <tr>
		    <th>단위</th>
		    <td>
		        <select name="unit" required>
		            <option value="">-- 선택 --</option>
		            <option value="KG">KG</option>
		            <option value="L">L</option>
		            <option value="EA">EA</option>
		        </select>
		    </td>
			</tr>
        </table>
        <div class="btn-area">
            <button type="submit">등록</button>
            <button type="button" onclick="location.href='${pageContext.request.contextPath}/standard2/list'">목록으로</button>
        </div>
    </form>
</div>

<!-- 하단 푸터 -->
<jsp:include page="/WEB-INF/views/basic/footer.jsp" />

<!-- 🟢 페이지 레이아웃 및 폼 디자인 -->
<style>
.content {
    margin-left: 220px; /* 사이드바 폭 만큼 띄움 */
    margin-top: 80px;   /* 헤더 높이 만큼 띄움 */
    padding: 20px;
}

h2 {
    margin-bottom: 20px;
    color: #2c3e50;
}

table {
    border-collapse: collapse;
    width: 400px;
    background: #fff;
}

th, td {
    border: 1px solid #ccc;
    padding: 8px 10px;
    text-align: left;
}

th {
    background-color: #ecf0f1;
    width: 120px;
}

input[type="text"], select {
    width: 90%;
    padding: 6px;
    box-sizing: border-box;
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
}

button:hover {
    background-color: #34495e;
}

select {
    width: 95%;
    padding: 6px;
    border-radius: 4px;
    border: 1px solid #ccc;
    background-color: #fff;
    box-sizing: border-box;
}
</style>

</body>
</html>

