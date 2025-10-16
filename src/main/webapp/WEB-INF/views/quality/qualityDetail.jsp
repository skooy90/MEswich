<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>품질검사 상세보기</title>
    <style>
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

        /* 상세보기 컨테이너 */
        .detail-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .detail-header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .detail-title {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }

        .back-btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }

        .back-btn:hover {
            background-color: #2980b9;
        }

        .detail-content {
            padding: 30px;
        }

        /* 정보 섹션 */
        .info-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #3498db;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            font-size: 14px;
        }

        .info-value {
            padding: 10px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            font-size: 16px;
            color: #333;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-align: center;
            min-width: 80px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-hold {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .status-pass {
            background-color: #d4edda;
            color: #155724;
        }

        .status-fail {
            background-color: #f8d7da;
            color: #721c24;
        }

        /* 검사 결과 섹션 */
        .result-section {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }

        .result-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .result-item {
            text-align: center;
            padding: 15px;
            background: white;
            border-radius: 6px;
            border: 1px solid #dee2e6;
        }

        .result-number {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }

        .result-label {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }

        .defect-reason {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 4px;
            padding: 15px;
            margin-top: 15px;
        }

        .defect-reason-label {
            font-weight: bold;
            color: #856404;
            margin-bottom: 8px;
        }

        .defect-reason-text {
            color: #856404;
            line-height: 1.5;
        }

        /* 액션 버튼 */
        .action-buttons {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
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

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-success:hover {
            background-color: #1e7e34;
        }

        .btn-info {
            background-color: #17a2b8;
            color: white;
        }

        .btn-info:hover {
            background-color: #138496;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        /* 오류 메시지 */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            margin: 20px 0;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 80px 15px 15px;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .result-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <div class="detail-container">
            <div class="detail-header">
                <h1 class="detail-title">🔍 품질검사 상세보기</h1>
                <a href="/mes/quality" class="back-btn">← 목록으로</a>
            </div>
            
            <div class="detail-content">
                <c:choose>
                    <c:when test="${not empty error}">
                        <div class="error-message">
                            <strong>오류:</strong> ${error}
                        </div>
                    </c:when>
                    <c:when test="${not empty quality}">
                        <!-- 기본 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">📝 기본 정보</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">검사번호</span>
                                    <div class="info-value">${quality.inspectionNo}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">작업지시번호</span>
                                    <div class="info-value">${quality.workOrderNo}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">LOT번호</span>
                                    <div class="info-value">${quality.lotNumber}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">제품명</span>
                                    <div class="info-value">${quality.productName}</div>
                                </div>
                            </div>
                        </div>

                        <!-- 검사 상태 및 담당자 -->
                        <div class="info-section">
                            <h2 class="section-title">👥 검사 상태 및 담당자</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">검사 상태</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${quality.status == 'PENDING'}">
                                                <span class="status-badge status-pending">검사대기</span>
                                            </c:when>
                                            <c:when test="${quality.status == 'HOLD'}">
                                                <span class="status-badge status-hold">검사중</span>
                                            </c:when>
                                            <c:when test="${quality.status == 'PASS'}">
                                                <span class="status-badge status-pass">합격</span>
                                            </c:when>
                                            <c:when test="${quality.status == 'FAIL'}">
                                                <span class="status-badge status-fail">불합격</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${quality.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">검사자 ID</span>
                                    <div class="info-value">${quality.inspectorId != null ? quality.inspectorId : '미배정'}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">검사자명</span>
                                    <div class="info-value">${quality.inspectorName != null ? quality.inspectorName : '미배정'}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">검사일</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty quality.inspectionDate}">
                                                <fmt:formatDate value="${quality.inspectionDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 검사 결과 -->
                        <c:if test="${quality.status == 'PASS' || quality.status == 'FAIL'}">
                            <div class="info-section">
                                <h2 class="section-title">📊 검사 결과</h2>
                                <div class="result-section">
                                    <div class="result-grid">
                                        <div class="result-item">
                                            <div class="result-number">${quality.goodQty != null ? quality.goodQty : 0}</div>
                                            <div class="result-label">완품수량</div>
                                        </div>
                                        <div class="result-item">
                                            <div class="result-number">${quality.defectQty != null ? quality.defectQty : 0}</div>
                                            <div class="result-label">불량수량</div>
                                        </div>
                                        <div class="result-item">
                                            <div class="result-number">
                                                <c:choose>
                                                    <c:when test="${(quality.goodQty != null ? quality.goodQty : 0) + (quality.defectQty != null ? quality.defectQty : 0) > 0}">
                                                        <fmt:formatNumber value="${(quality.goodQty != null ? quality.goodQty : 0) * 100.0 / ((quality.goodQty != null ? quality.goodQty : 0) + (quality.defectQty != null ? quality.defectQty : 0))}" pattern="#.#"/>%
                                                    </c:when>
                                                    <c:otherwise>0%</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="result-label">양품률</div>
                                        </div>
                                    </div>
                                    
                                    <c:if test="${quality.defectQty != null && quality.defectQty > 0 && not empty quality.defectReason}">
                                        <div class="defect-reason">
                                            <div class="defect-reason-label">불량사유:</div>
                                            <div class="defect-reason-text">${quality.defectReason}</div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>

                        <!-- 일정 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">📅 일정 정보</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">생성일</span>
                                    <div class="info-value">
                                        <fmt:formatDate value="${quality.createdDate}" pattern="yyyy-MM-dd HH:mm"/>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">수정일</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty quality.updatedDate}">
                                                <fmt:formatDate value="${quality.updatedDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">생성자</span>
                                    <div class="info-value">${quality.createdBy != null ? quality.createdBy : 'SYSTEM'}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">수정자</span>
                                    <div class="info-value">${quality.updatedBy != null ? quality.updatedBy : '-'}</div>
                                </div>
                            </div>
                        </div>

                        <!-- 액션 버튼 -->
                        <div class="action-buttons">
                            <c:choose>
                                <c:when test="${quality.status == 'PENDING'}">
                                    <form method="post" action="/mes/quality/startInspection" style="display: inline;">
                                        <input type="hidden" name="inspectionNo" value="${quality.inspectionNo}">
                                        <input type="text" name="inspectorName" placeholder="검사자명" required>
                                        <button type="submit" class="btn btn-warning">검사시작</button>
                                    </form>
                                </c:when>
                                <c:when test="${quality.status == 'HOLD'}">
                                    <a href="/mes/quality/completeInspection?inspectionNo=${quality.inspectionNo}" class="btn btn-success">검사완료</a>
                                </c:when>
                                <c:when test="${quality.status == 'PASS'}">
                                    <a href="/mes/quality/transferToInventory?inspectionNo=${quality.inspectionNo}" class="btn btn-info">재고전달</a>
                                </c:when>
                            </c:choose>
                            <button class="btn btn-primary" onclick="window.print()">인쇄</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="error-message">
                            <strong>오류:</strong> 품질검사 정보를 불러올 수 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

</body>
</html>



