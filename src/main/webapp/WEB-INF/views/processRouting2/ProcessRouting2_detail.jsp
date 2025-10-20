<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<meta charset="UTF-8">
<title>공정 상세정보</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/basic/header.jsp"/>
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp"/>

<div class="content">
    <h2>공정 상세 정보</h2>

    <c:if test="${not empty detailList}">
        <div class="info-box">
            <p><strong>제품 코드:</strong> ${detailList[0].productCode}</p>
            <p><strong>제품명:</strong> ${detailList[0].productName}</p>
            <p><strong>총 공정 단계:</strong> ${fn:length(detailList)}</p>
        </div>
    </c:if>

    <table border="1" cellpadding="8" cellspacing="0" style="width:90%; text-align:center;">
        <thead>
            <tr style="background-color:#f1f1f1;">
                <th>공정 순서</th>
                <th>공정 코드</th>
                <th>공정명</th>
                <th>공정 내용</th>
                <th>표준 시간(분)</th>
                <th>등록자</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="d" items="${detailList}">
                <tr>
                    <td>${d.operationSeq}</td>
                    <td>${d.operationCode}</td>
                    <td>${d.operationName}</td>
                    <td>${d.operationDesc}</td>
                    <td>${d.standardTime}</td>
                    <td>${d.createdBy}</td>
                    <td><fmt:formatDate value="${d.createdDate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/processRouting2/updateForm/${detailList[0].productCode}" class="btn">수정</a>
        <a href="${pageContext.request.contextPath}/processRouting2/delete/${detailList[0].productCode}" class="btn btn-danger" 
           onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
        <a href="${pageContext.request.contextPath}/processRouting2/list" class="btn btn-secondary">목록으로</a>
    </div>
</div>

<style>
.content { margin-left:220px; margin-top:80px; padding:20px; }
.info-box { background:#f8f9fa; border:1px solid #dee2e6; border-radius:8px; padding:10px; width:90%; margin-bottom:20px; }
.btn { background:#2c3e50; color:#fff; padding:6px 10px; border-radius:4px; text-decoration:none; }
.btn-danger { background:#dc3545; }
.btn-secondary { background:#6c757d; }
.actions { margin-top:15px; display:flex; gap:10px; }
</style>
</body>
</html>

