<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>생산 LOT 상세보기 - MES 샌드위치 제조 관리 시스템</title>
<style>
/* 전역 스타일 */
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	font-family: 'Segoe UI', sans-serif;
	background-color: #f8f9fa;
}

.main-content {
	margin-left: 200px; /* 사이드바 공간 확보 */
	padding: 100px 30px 30px; /* 헤더 높이 + 내부 여백 */
	min-height: 100vh;
}

/* 상세 정보 컨테이너 */
.detail-container {
	background: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	max-width: 800px;
	margin: 0 auto;
}

/* 제목 스타일 */
h2 {
	margin-top: 0;
	color: #2c3e50;
	margin-bottom: 30px;
	text-align: center;
	border-bottom: 2px solid #007bff;
	padding-bottom: 10px;
}

/* 정보 테이블 */
.info-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

.info-table th, .info-table td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #e9ecef;
}

.info-table th {
	background-color: #f8f9fa;
	font-weight: 600;
	color: #495057;
	width: 200px;
}

.info-table td {
	color: #212529;
}

/* 상태 표시 */
.status {
	padding: 6px 12px;
	border-radius: 12px;
	font-size: 14px;
	font-weight: 500;
}

.status-PLANNED {
	background-color: #e3f2fd;
	color: #1976d2;
}

.status-IN_PROGRESS {
	background-color: #fff3e0;
	color: #f57c00;
}

.status-COMPLETED {
	background-color: #e8f5e8;
	color: #388e3c;
}

.status-CANCELLED {
	background-color: #ffebee;
	color: #d32f2f;
}

/* 버튼 영역 */
.button-group {
	display: flex;
	gap: 10px;
	justify-content: center;
	margin-top: 30px;
}

.btn {
	padding: 12px 24px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
	display: inline-block;
	text-align: center;
}

.btn-primary {
	background-color: #007bff;
	color: white;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.btn-warning {
	background-color: #ffc107;
	color: #212529;
}

.btn-warning:hover {
	background-color: #e0a800;
}

.btn-secondary {
	background-color: #6c757d;
	color: white;
}

.btn-secondary:hover {
	background-color: #5a6268;
}

/* 에러 메시지 */
.error-message {
	background-color: #f8d7da;
	color: #721c24;
	padding: 10px;
	border-radius: 4px;
	margin-bottom: 20px;
	border: 1px solid #f5c6cb;
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	.main-content {
		margin-left: 0;
		padding: 80px 15px 15px;
	}
	.detail-container {
		padding: 20px;
	}
	.info-table th, .info-table td {
		padding: 10px 8px;
		font-size: 14px;
	}
	.button-group {
		flex-direction: column;
	}
}
</style>
</head>

<body>
	<%@ include file="../basic/header.jsp"%>
	<%@ include file="../basic/sidebar.jsp"%>

	<main class="main-content">
		<div class="detail-container">
			<h2>🏭 생산 LOT 상세정보</h2>
			<!-- 에러 메시지 표시 -->
			<c:if test="${not empty error}">
				<div class="error-message">${error}</div>
			</c:if>

			<c:if test="${not empty production}">
				<table class="info-table">
					<tr>
						<th>LOT번호</th>
						<td>${production.lotNumber}</td>
					</tr>
					<tr>
						<th>제품코드</th>
						<td>${production.productCode}</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td>${production.productName}</td>
					</tr>
					<tr>
						<th>계획수량</th>
						<td>${production.plannedQty}개</td>
					</tr>
					<tr>
						<th>실제수량</th>
						<td>${production.actualQty != null ? production.actualQty : 0}개</td>
					</tr>
					<tr>
						<th>상태</th>
						<td><span class="status status-${production.status}">
								<c:choose>
									<c:when test="${production.status == 'PLANNED'}">계획</c:when>
									<c:when test="${production.status == 'IN_PROGRESS'}">진행중</c:when>
									<c:when test="${production.status == 'COMPLETED'}">완료</c:when>
									<c:when test="${production.status == 'CANCELLED'}">취소</c:when>
									<c:otherwise>${production.status}</c:otherwise>
								</c:choose>
						</span></td>
					</tr>
					<tr>
						<th>계획시작일</th>
						<td><fmt:formatDate value="${production.plannedStartDate}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th>계획종료일</th>
						<td><fmt:formatDate value="${production.plannedEndDate}"
								pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<th>생성일</th>
						<td><fmt:formatDate value="${production.createdDate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
					<c:if test="${not empty production.updatedDate}">
						<tr>
							<th>수정일</th>
							<td><fmt:formatDate value="${production.updatedDate}"
									pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</c:if>
				</table>
			<img src="/mes/qr/generate?content=http://116.36.205.25:9003/mes/production/detail?lotNumber=${production.lotNumber}&size=150"
				alt="QR Code" />

				<div class="button-group">
					<a href="/mes/production/edit?lotNumber=${production.lotNumber}"
						class="btn btn-warning">수정</a> <a href="/mes/production/list"
						class="btn btn-secondary">목록으로</a>
				</div>
			</c:if>
		</div>
	</main>
</body>
</html>
