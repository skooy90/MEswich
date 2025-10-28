<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LOT 추적 이력 - MES 샌드위치 제조 관리 시스템</title>
</head>
<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/basic/header.jsp" />

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<!-- 본문 영역 -->
<div class="content">
    <!-- 페이지 헤더 카드 -->
    <div class="header-card">
        <div class="header-content">
            <h1>🔍 LOT 추적 이력</h1>
            <p>LOT 번호로 생산 이력을 추적하고 관리하세요</p>
        </div>
        <div class="header-icon">📊</div>
    </div>

    <!-- 검색 카드 -->
    <div class="search-card">
        <div class="search-header">
            <h3>LOT 검색</h3>
            <div class="search-icon">🔎</div>
        </div>
        <form action="/mes/lotTracking2/search" method="get" class="search-form">
            <div class="input-group">
                <label for="lotNumber">LOT 번호</label>
                <input type="text" id="lotNumber" name="lotNumber" value="${lotNumber}" placeholder="예: LOT2024001" required />
                <button type="submit" class="search-btn">
                    <span class="btn-icon">🔍</span>
                    <span>검색</span>
                </button>
            </div>
        </form>
    </div>

    <!-- 결과 카드들 -->
    <c:if test="${not empty trackingList}">
        <div class="results-header">
            <h3>📋 추적 결과 (${trackingList.size()}건)</h3>
            <div class="result-count">총 ${trackingList.size()}개의 이력</div>
        </div>
        
        <div class="cards-container">
            <c:forEach var="row" items="${trackingList}" varStatus="status">
                <div class="tracking-card">
                    <div class="card-header">
                        <div class="card-id">#${row.trackingId}</div>
                        <div class="status-badge status-${row.status.toLowerCase()}">
                            <c:choose>
                                <c:when test="${row.status == 'PLANNED'}">📅 계획됨</c:when>
                                <c:when test="${row.status == 'IN_PROGRESS'}">⚡ 진행중</c:when>
                                <c:when test="${row.status == 'COMPLETED'}">✅ 완료</c:when>
                                <c:when test="${row.status == 'HOLD'}">⏸️ 보류</c:when>
                                <c:when test="${row.status == 'CANCELLED'}">❌ 취소됨</c:when>
                                <c:when test="${row.status == 'WAIT_QUALITY'}">🔍 품질검사 대기</c:when>
                                <c:when test="${row.status == 'QUALITY_PASS'}">✅ 품질검사 통과</c:when>
                                <c:when test="${row.status == 'QUALITY_FAIL'}">❌ 품질검사 실패</c:when>
                                <c:when test="${row.status == 'INVENTORY_CONFIRMED'}">📦 재고 확정</c:when>
                                <c:otherwise>${row.status}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <div class="info-row">
                            <div class="info-item">
                                <div class="info-label">📅 시작일</div>
                                <div class="info-value"><fmt:formatDate value="${row.startDate}" pattern="yyyy-MM-dd HH:mm"/></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">🏁 종료일</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${not empty row.endDate}">
                                            <fmt:formatDate value="${row.startDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty row.remarks}">
                            <div class="remarks-section">
                                <div class="remarks-label">💬 비고</div>
                                <div class="remarks-content">${row.remarks}</div>
                            </div>
                        </c:if>
                        
                        <div class="card-footer">
                            <div class="updated-by">
                                <span class="user-icon">👤</span>
                                <span>수정자: ${row.updatedBy=='system' ? row.updatedBy : '관리자'}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- 데이터 없음 카드 -->
    <c:if test="${empty trackingList and not empty lotNumber}">
        <div class="no-data-card">
            <div class="no-data-icon">🔍</div>
            <h3>검색 결과가 없습니다</h3>
            <p>LOT 번호 "<strong>${lotNumber}</strong>"에 대한 추적 이력이 없습니다.</p>
            <div class="no-data-suggestions">
                <p>💡 확인해보세요:</p>
                <ul>
                    <li>LOT 번호가 정확한지 확인</li>
                    <li>다른 LOT 번호로 검색해보기</li>
                    <li>생산 계획이 등록되었는지 확인</li>
                </ul>
            </div>
        </div>
    </c:if>
</div>

<style>
/* 전역 스타일 */
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f8f9fa;
    min-height: 100vh;
}

/* 본문 영역 */
.content { 
    margin-left: 220px; 
    margin-top: 80px; 
    padding: 30px; 
    min-height: calc(100vh - 80px);
}

/* 헤더 카드 */
.header-card {
    background: #2c3e50;
    color: white;
    padding: 30px;
    border-radius: 12px;
    margin-bottom: 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}


.header-content h1 {
    font-size: 28px;
    margin: 0 0 8px 0;
    font-weight: 700;
}

.header-content p {
    font-size: 16px;
    margin: 0;
    opacity: 0.9;
}

.header-icon {
    font-size: 48px;
    opacity: 0.3;
}

/* 검색 카드 */
.search-card {
    background: white;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    border: 1px solid #e9ecef;
}

.search-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.search-header h3 {
    font-size: 20px;
    margin: 0;
    color: #2c3e50;
    font-weight: 700;
}

.search-icon {
    font-size: 24px;
}

.search-form {
    margin: 0;
}

.input-group {
    display: flex;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
}

.input-group label {
    font-weight: 600;
    color: #495057;
    font-size: 16px;
    min-width: 80px;
}

.input-group input[type="text"] {
    flex: 1;
    min-width: 300px;
    padding: 12px 16px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    font-size: 16px;
    transition: all 0.3s ease;
    background: #fff;
}

.input-group input[type="text"]:focus {
    outline: none;
    border-color: #2c3e50;
    background: white;
    box-shadow: 0 0 0 2px rgba(44, 62, 80, 0.1);
}

.search-btn {
    padding: 12px 24px;
    background: #2c3e50;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
}

.search-btn:hover {
    background: #34495e;
    transform: translateY(-1px);
}

.btn-icon {
    font-size: 18px;
}

/* 결과 헤더 */
.results-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding: 0 10px;
}

.results-header h3 {
    font-size: 20px;
    margin: 0;
    color: #2c3e50;
    font-weight: 700;
}

.result-count {
    background: #e9ecef;
    color: #495057;
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

/* 카드 컨테이너 */
.cards-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
    gap: 20px;
    margin-bottom: 25px;
}

/* 추적 카드 */
.tracking-card {
    background: white;
    border-radius: 12px;
    padding: 0;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    border: 1px solid #e9ecef;
    overflow: hidden;
}

.tracking-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

.card-header {
    background: #f8f9fa;
    padding: 18px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #e9ecef;
}

.card-id {
    font-size: 20px;
    font-weight: 700;
    color: #495057;
}

.status-badge {
    padding: 8px 16px;
    border-radius: 20px;
    font-size: 16px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 5px;
}

.status-planned { 
    background-color: #e9ecef; 
    color: #495057; 
}

.status-in_progress { 
    background-color: #fff3cd; 
    color: #856404; 
}

.status-completed { 
    background-color: #d4edda; 
    color: #155724; 
}

.status-hold { 
    background-color: #f8d7da; 
    color: #721c24; 
}

.status-cancelled { 
    background-color: #e2e3e5; 
    color: #6c757d; 
}

.status-wait_quality { 
    background-color: #cce5ff; 
    color: #004085; 
}

.status-quality_pass { 
    background-color: #d1ecf1; 
    color: #0c5460; 
}

.status-quality_fail { 
    background-color: #f5c6cb; 
    color: #721c24; 
}

.status-inventory_confirmed { 
    background-color: #d4edda; 
    color: #155724; 
}

.card-body {
    padding: 20px;
}

.info-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 18px;
}

.info-item {
    text-align: center;
}

.info-label {
    font-size: 14px;
    color: #6c757d;
    margin-bottom: 6px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.info-value {
    font-size: 18px;
    color: #2c3e50;
    font-weight: 600;
}

.remarks-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 18px;
}

.remarks-label {
    font-size: 14px;
    color: #6c757d;
    margin-bottom: 8px;
    font-weight: 600;
}

.remarks-content {
    font-size: 16px;
    color: #495057;
    line-height: 1.5;
}

.card-footer {
    border-top: 1px solid #e9ecef;
    padding-top: 15px;
}

.updated-by {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 16px;
    color: #6c757d;
}

.user-icon {
    font-size: 18px;
}

/* 데이터 없음 카드 */
.no-data-card {
    background: white;
    padding: 50px 30px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    border: 1px solid #e9ecef;
}

.no-data-icon {
    font-size: 60px;
    margin-bottom: 20px;
    opacity: 0.5;
}

.no-data-card h3 {
    font-size: 24px;
    color: #6c757d;
    margin-bottom: 12px;
    font-weight: 700;
}

.no-data-card p {
    font-size: 16px;
    color: #adb5bd;
    margin-bottom: 25px;
}

.no-data-suggestions {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    text-align: left;
    max-width: 400px;
    margin: 0 auto;
}

.no-data-suggestions p {
    font-size: 16px;
    color: #495057;
    margin-bottom: 12px;
    font-weight: 600;
}

.no-data-suggestions ul {
    margin: 0;
    padding-left: 20px;
}

.no-data-suggestions li {
    font-size: 15px;
    color: #6c757d;
    margin-bottom: 8px;
    line-height: 1.5;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .content {
        margin-left: 0;
        padding: 20px;
    }
    
    .header-card {
        flex-direction: column;
        text-align: center;
        gap: 20px;
    }
    
    .header-content h1 {
        font-size: 28px;
    }
    
    .cards-container {
        grid-template-columns: 1fr;
    }
    
    .input-group {
        flex-direction: column;
        align-items: stretch;
    }
    
    .input-group input[type="text"] {
        min-width: auto;
    }
    
    .info-row {
        grid-template-columns: 1fr;
        gap: 15px;
    }
}
</style>

</body>
</html>