<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <div class="page-header">
        <h2>${routingList[0].productName} (${routingList[0].productCode}) 공정 상세</h2>
        <a href="/mes/processRouting2/list" class="btn-back">← 목록으로</a>
    </div>

    <div class="card-container">
        <c:forEach var="item" items="${routingList}">
            <div class="card">
                <div class="card-header">
                    <h3>${item.operationSeq}. ${item.operationName}</h3>
                </div>
                <div class="card-body">
                    <p><strong>공정 코드:</strong> ${item.operationCode}</p>
                    <p><strong>표준 시간:</strong> ${item.standardTime} 분</p>
                    <p><strong>공정 설명:</strong>
                        <c:choose>
                            <c:when test="${not empty item.operationDesc}">
                                ${item.operationDesc}
                            </c:when>
                            <c:otherwise>-</c:otherwise>
                        </c:choose>
                    </p>
                    <p><strong>등록자:</strong> ${item.createdBy}</p>
                    <p><strong>등록일:</strong> 
                        <fmt:formatDate value="${item.createdDate}" pattern="yyyy-MM-dd" />
                    </p>
                </div>

                <div class="card-footer">
                    <c:if test="${not empty item.routingId}">
                        <a href="/mes/processRouting2/updateForm/${item.routingId}" class="btn-edit">✏ 수정</a>
                        <a href="/mes/processRouting2/delete/${item.routingId}" class="btn-delete"
                           onclick="return confirm('정말 삭제하시겠습니까?');">🗑 삭제</a>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
/* 전체 영역 */
.content {
    margin-left: 220px;
    padding: 60px;
    background: #f4f6f9;
    min-height: 100vh;
    font-family: 'Segoe UI', sans-serif;
}

/* 헤더 */
.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}
.page-header h2 {
    font-size: 24px;
    font-weight: 700;
    color: #2c3e50;
    margin: 0;
}

/* 카드 컨테이너 */
.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 25px;
}

/* 카드 */
.card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.08);
    padding: 20px;
    transition: all 0.25s ease-in-out;
    border-top: 5px solid #3498db;
}
.card:hover {
    transform: translateY(-4px);
    box-shadow: 0 5px 12px rgba(0,0,0,0.12);
}

/* 카드 헤더 */
.card-header h3 {
    margin: 0 0 10px 0;
    color: #2c3e50;
    font-size: 18px;
    font-weight: 600;
}

/* 카드 본문 */
.card-body p {
    margin: 6px 0;
    color: #444;
    font-size: 14.5px;
}
.card-body strong {
    color: #2c3e50;
}

/* 버튼 영역 */
.card-footer {
    margin-top: 15px;
    display: flex;
    gap: 10px;
}

/* 수정 버튼 */
.btn-edit {
    background: #3498db;
    color: #fff;
    padding: 8px 14px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.2s;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}
.btn-edit:hover {
    background: #2980b9;
    transform: translateY(-2px);
}

/* 삭제 버튼 */
.btn-delete {
    background: #e74c3c;
    color: #fff;
    padding: 8px 14px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.2s;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}
.btn-delete:hover {
    background: #c0392b;
    transform: translateY(-2px);
}

/* 목록으로 버튼 */
.btn-back {
    display: inline-block;
    background: #2c3e50;
    color: #fff;
    padding: 10px 18px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s;
}
.btn-back:hover {
    background: #34495e;
    transform: translateY(-2px);
}
</style>

