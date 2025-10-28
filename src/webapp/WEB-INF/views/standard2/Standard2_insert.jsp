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
    <div class="page-header">
        <h2>품목 등록</h2>
        <p class="subtitle">신규 품목의 기본정보를 입력해주세요.</p>
    </div>

    <form action="${pageContext.request.contextPath}/standard2/insert" method="post" class="form-card">
        <table class="form-table">
            <tr>
                <th>품목명</th>
                <td><input type="text" name="itemName" required class="input" placeholder="예) 햄치즈샌드위치"></td>
            </tr>
            <tr>
                <th>품목유형</th>
                <td>
                    <select name="itemType" required class="select">
                        <option value="">--선택--</option>
                        <option value="FG">완제품</option>
                        <option value="RM">원자재</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>단위</th>
                <td>
                    <select name="unit" required class="select">
                        <option value="">-- 선택 --</option>
                        <option value="KG">KG</option>
                        <option value="L">L</option>
                        <option value="EA">EA</option>
                    </select>
                </td>
            </tr>
        </table>
        <div class="btn-area">
            <button type="submit" class="btn btn-primary">등록</button>
            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/standard2/list'">목록으로</button>
        </div>
    </form>
</div>


<!-- 🟢 페이지 레이아웃 및 폼 디자인 -->
<style>
.content {
    margin-left: 220px; /* 사이드바 폭 만큼 띄움 */
    margin-top: 80px;   /* 헤더 높이 만큼 띄움 */
    padding: 20px;
}

.page-header {
    margin-bottom: 18px;
}

.subtitle {
    margin: 0;
    color: #6c757d;
    font-size: 13px;
}

.form-card {
    background: #fff;
    border: 1px solid #e9ecef;
    border-radius: 8px;
    padding: 16px;
    width: 520px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}

.form-table {
    border-collapse: collapse;
    width: 100%;
}

.form-table th, .form-table td {
    border: 1px solid #edf2f7;
    padding: 10px 12px;
    text-align: left;
}

.form-table th {
    background-color: #f8f9fa;
    width: 140px;
}

.input, .select {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    outline: none;
    transition: border-color .2s, box-shadow .2s;
    box-sizing: border-box;
}

.input:focus, .select:focus {
    border-color: #80bdff;
    box-shadow: 0 0 0 2px rgba(0,123,255,.15);
}

.btn-area {
    margin-top: 16px;
    display: flex;
    gap: 8px;
}

.btn {
    padding: 10px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
}

.btn-primary { background-color: #2c3e50; color: #fff; }
.btn-primary:hover { background-color: #34495e; }
.btn-secondary { background-color: #adb5bd; color: #fff; }
.btn-secondary:hover { background-color: #9aa2a9; }
</style>

</body>
</html>

