<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 라우팅 수정</title>
</head>
<body>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <div class="page-header">
        <h2>공정 라우팅 수정</h2>
        <div class="actions">
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/processRouting2/list">목록으로</a>
        </div>
    </div>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/processRouting2/update" method="post">

            <div class="form-group">
                <label>제품코드</label>
                <input type="text" name="productCode" value="${detailList[0].productCode}" readonly />
            </div>

            <c:forEach var="step" items="${detailList}" varStatus="st">
                <div class="process-block">
                    <h4>공정 ${st.index + 1}</h4>
                    <div class="form-row">
                        <label>공정순서</label>
                        <input type="number" name="operationSeq" value="${step.operationSeq}" required />
                    </div>
                    <div class="form-row">
                        <label>공정코드</label>
                        <input type="text" name="operationCode" value="${step.operationCode}" required />
                    </div>
                    <div class="form-row">
                        <label>공정명</label>
                        <input type="text" name="operationName" value="${step.operationName}" required />
                    </div>
                    <div class="form-row">
                        <label>표준시간(분)</label>
                        <input type="number" name="standardTime" value="${step.standardTime}" />
                    </div>
                </div>
            </c:forEach>

            <div class="actions">
                <button type="submit" class="btn btn-primary">수정 완료</button>
            </div>

        </form>
    </div>
</div>

<style>
.content { margin-left: 220px; margin-top: 80px; padding: 20px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.form-card { background: #fff; border: 1px solid #e9ecef; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.06); }
.form-group, .form-row { margin-bottom: 12px; display: flex; flex-direction: column; }
label { font-weight: 600; margin-bottom: 4px; }
input, select { padding: 8px; border: 1px solid #ced4da; border-radius: 6px; }
.process-block { border-left: 5px solid #0b5ed7; padding: 12px 16px; margin-bottom: 16px; background: #f8f9fa; border-radius: 6px; }
.btn { padding: 8px 12px; border-radius: 6px; text-decoration: none; font-weight: 600; cursor: pointer; border: none; }
.btn-primary { background-color: #2c3e50; color: #fff; }
.btn-secondary { background-color: #6c757d; color: #fff; }
.btn:hover { opacity: 0.9; }
.actions { display: flex; gap: 10px; margin-top: 20px; }
</style>

</body>
</html>
