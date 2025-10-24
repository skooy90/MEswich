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
    <div class="page-header">
        <h2>품목 상세 / 수정</h2>
        <p class="subtitle">필요한 항목을 수정한 후 저장하세요.</p>
    </div>

    <form action="${pageContext.request.contextPath}/standard2/update" method="post" class="form-card">
        <input type="hidden" name="itemCode" value="${standard.itemCode}" />

        <table class="form-table">
            <tr>
                <th>품목코드</th>
                <td><input type="text" name="itemCodeDisplay" value="${standard.itemCode}" class="input" readonly></td>
            </tr>

            <tr>
                <th>품목명</th>
                <td><input type="text" name="itemName" value="${standard.itemName}" class="input" required></td>
            </tr>

            <tr>
                <th>품목유형</th>
                <td>
                    <select name="itemType" class="select" disabled>
                        <option value="FG" ${standard.itemType == 'FG' ? 'selected' : ''}>완제품</option>
                        <option value="RM" ${standard.itemType == 'RM' ? 'selected' : ''}>원자재</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>단위</th>
                <td>
                    <select name="unit" class="select" disabled>
                        <option value="KG" ${standard.unit == 'KG' ? 'selected' : ''}>KG</option>
                        <option value="L" ${standard.unit == 'L' ? 'selected' : ''}>L</option>
                        <option value="EA" ${standard.unit == 'EA' ? 'selected' : ''}>EA</option>
                    </select>
                </td>
            </tr>

            <tr>
                <th>생성일</th>
                <td><input type="text" name="createdDate" value="${standard.createdDate}" class="input" readonly></td>
            </tr>

            <tr>
                <th>수정일</th>
                <td><input type="text" name="updatedDate" value="${standard.updatedDate}" class="input" readonly></td>
            </tr>

            <tr>
                <th>생성자</th>
                <td><input type="text" name="createdBy" value="${standard.createdBy}" class="input" readonly></td>
            </tr>

            <tr>
                <th>수정자</th>
                <td><input type="text" name="updatedBy" value="${standard.updatedBy}" class="input" required></td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="submit" class="btn btn-primary">저장</button>
            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/standard2/list'">목록으로</button>
        </div>
    </form>
</div>

<!-- 하단 푸터 -->

<!-- 🧩 스타일 -->
<style>
.content {
    margin-left: 220px;
    margin-top: 80px;
    padding: 20px;
}

.page-header { margin-bottom: 18px; }
h2 { margin: 0 0 6px 0; color: #2c3e50; }
.subtitle { margin: 0; color: #6c757d; font-size: 13px; }

.form-card {
    background: #fff;
    border: 1px solid #e9ecef;
    border-radius: 8px;
    padding: 16px;
    width: 560px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}

.form-table { border-collapse: collapse; width: 100%; }
.form-table th, .form-table td { border: 1px solid #edf2f7; padding: 10px 12px; text-align: left; }
.form-table th { background-color: #f8f9fa; width: 160px; }

.input, .select {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    outline: none;
    transition: border-color .2s, box-shadow .2s;
    box-sizing: border-box;
}
.input:focus, .select:focus { border-color: #80bdff; box-shadow: 0 0 0 2px rgba(0,123,255,.15); }
.input[readonly], .select[disabled] { background-color: #f5f5f5; color: #666; cursor: not-allowed; }

.btn-area { margin-top: 16px; display: flex; gap: 8px; }
.btn { padding: 10px 16px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; }
.btn-primary { background-color: #2c3e50; color: #fff; }
.btn-primary:hover { background-color: #34495e; }
.btn-secondary { background-color: #adb5bd; color: #fff; }
.btn-secondary:hover { background-color: #9aa2a9; }
</style>

</body>
</html>
