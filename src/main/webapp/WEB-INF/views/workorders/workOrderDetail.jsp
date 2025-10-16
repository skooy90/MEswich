<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>작업지시서 상세보기</title>
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

        .status-ready {
            background-color: #e3f2fd;
            color: #1976d2;
        }

        .status-in-progress {
            background-color: #fff3e0;
            color: #f57c00;
        }

        .status-done {
            background-color: #e8f5e8;
            color: #2e7d32;
        }

        .status-cancelled {
            background-color: #ffebee;
            color: #c62828;
        }

        /* 진행률 바 */
        .progress-container {
            margin-top: 10px;
        }

        .progress-bar {
            width: 100%;
            height: 20px;
            background-color: #e9ecef;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background-color: #28a745;
            transition: width 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
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
                <h1 class="detail-title">📋 작업지시서 상세보기</h1>
                <a href="/mes/work" class="back-btn">← 목록으로</a>
            </div>
            
            <div class="detail-content">
                <c:choose>
                    <c:when test="${not empty error}">
                        <div class="error-message">
                            <strong>오류:</strong> ${error}
                        </div>
                    </c:when>
                    <c:when test="${not empty workOrder}">
                        <!-- 기본 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">📝 기본 정보</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">작업지시번호</span>
                                    <div class="info-value">${workOrder.workOrderNo}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">LOT번호</span>
                                    <div class="info-value">${workOrder.lotNumber}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">제품명</span>
                                    <div class="info-value">${workOrder.productName}</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">제품코드</span>
                                    <div class="info-value">${workOrder.productCode}</div>
                                </div>
                            </div>
                        </div>

                        <!-- 수량 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">📊 수량 정보</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">목표량</span>
                                    <div class="info-value">${workOrder.plannedQty}개</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">실제 생산량</span>
                                    <div class="info-value">${workOrder.actualQty != null ? workOrder.actualQty : 0}개</div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">진행률</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${workOrder.plannedQty > 0}">
                                                <fmt:formatNumber value="${(workOrder.actualQty != null ? workOrder.actualQty : 0) * 100.0 / workOrder.plannedQty}" pattern="#.#"/>%
                                                <div class="progress-container">
                                                    <div class="progress-bar">
                                                        <div class="progress-fill" style="width: ${(workOrder.actualQty != null ? workOrder.actualQty : 0) * 100.0 / workOrder.plannedQty}%">
                                                            <fmt:formatNumber value="${(workOrder.actualQty != null ? workOrder.actualQty : 0) * 100.0 / workOrder.plannedQty}" pattern="#.#"/>%
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>0%</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 상태 및 담당자 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">👥 상태 및 담당자</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">작업 상태</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${workOrder.status == 'READY'}">
                                                <span class="status-badge status-ready">대기중</span>
                                            </c:when>
                                            <c:when test="${workOrder.status == 'IN_PROGRESS'}">
                                                <span class="status-badge status-in-progress">진행중</span>
                                            </c:when>
                                            <c:when test="${workOrder.status == 'DONE'}">
                                                <span class="status-badge status-done">완료</span>
                                            </c:when>
                                            <c:when test="${workOrder.status == 'CANCELLED'}">
                                                <span class="status-badge status-cancelled">취소</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${workOrder.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">담당 작업자</span>
                                    <div class="info-value">${workOrder.workerId != null ? workOrder.workerId : '미배정'}</div>
                                </div>
                            </div>
                        </div>

                        <!-- 일정 정보 -->
                        <div class="info-section">
                            <h2 class="section-title">📅 일정 정보</h2>
                            <div class="info-grid">
                                <div class="info-item">
                                    <span class="info-label">작업 시작일</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty workOrder.startDate}">
                                                <fmt:formatDate value="${workOrder.startDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">작업 완료일</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty workOrder.endDate}">
                                                <fmt:formatDate value="${workOrder.endDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">생성일</span>
                                    <div class="info-value">
                                        <fmt:formatDate value="${workOrder.createdDate}" pattern="yyyy-MM-dd HH:mm"/>
                                    </div>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">수정일</span>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${not empty workOrder.updatedDate}">
                                                <fmt:formatDate value="${workOrder.updatedDate}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 액션 버튼 -->
                        <div class="action-buttons">
                            <c:choose>
                                <c:when test="${workOrder.status == 'READY'}">
                                    <button class="btn btn-warning" onclick="assignWorker('${workOrder.workOrderNo}')">작업자 배정</button>
                                </c:when>
                                <c:when test="${workOrder.status == 'IN_PROGRESS'}">
                                    <button class="btn btn-info" onclick="updateProduction('${workOrder.workOrderNo}', '${workOrder.plannedQty}', '${workOrder.actualQty != null ? workOrder.actualQty : 0}')">생산량 입력</button>
                                    <button class="btn btn-success" onclick="completeWork('${workOrder.workOrderNo}')">작업 완료</button>
                                </c:when>
                                <c:when test="${workOrder.status == 'DONE'}">
                                    <button class="btn btn-info" onclick="transferToQuality('${workOrder.workOrderNo}')">품질관리 전달</button>
                                </c:when>
                            </c:choose>
                            <button class="btn btn-primary" onclick="window.print()">인쇄</button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="error-message">
                            <strong>오류:</strong> 작업지시서 정보를 불러올 수 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        /**
         * 작업자 배정 기능
         * @param {string} workOrderNo - 작업지시번호
         */
        function assignWorker(workOrderNo) {
            const worker = prompt('작업자명을 입력하세요:', '');
            if (worker && worker.trim() !== '') {
                fetch('/mes/work/assignWorker', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'workOrderNo=' + encodeURIComponent(workOrderNo) + '&workerId=' + encodeURIComponent(worker)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('작업자 배정 중 오류가 발생했습니다.');
                });
            }
        }

        /**
         * 생산량 입력 기능
         * @param {string} workOrderNo - 작업지시번호
         * @param {number} plannedQty - 목표량
         * @param {number} currentQty - 현재 생산량
         */
        function updateProduction(workOrderNo, plannedQty, currentQty) {
            const newQty = prompt('새 생산량을 입력하세요:', currentQty);
            if (newQty !== null && newQty.trim() !== '') {
                const qty = parseInt(newQty);
                if (isNaN(qty) || qty < 0) {
                    alert('올바른 생산량을 입력해주세요.');
                    return;
                }
                if (qty > plannedQty) {
                    alert('생산량은 목표량을 초과할 수 없습니다.');
                    return;
                }
                
                fetch('/mes/work/updateProduction', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'workOrderNo=' + encodeURIComponent(workOrderNo) + 
                          '&actualQty=' + encodeURIComponent(qty)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('생산량 업데이트 중 오류가 발생했습니다.');
                });
            }
        }

        /**
         * 작업 완료 처리 기능
         * @param {string} workOrderNo - 작업지시번호
         */
        function completeWork(workOrderNo) {
            if (confirm('작업을 완료하시겠습니까?')) {
                fetch('/mes/work/completeWork', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'workOrderNo=' + encodeURIComponent(workOrderNo)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('작업 완료 처리 중 오류가 발생했습니다.');
                });
            }
        }

        /**
         * 품질관리로 전달 기능
         * @param {string} workOrderNo - 작업지시번호
         */
        function transferToQuality(workOrderNo) {
            if (confirm('이 작업을 품질관리로 전달하시겠습니까?')) {
                fetch('/mes/quality/createInspection', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'workOrderNo=' + encodeURIComponent(workOrderNo)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        window.location.href = '/mes/quality';
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('품질관리 전달 중 오류가 발생했습니다.');
                });
            }
        }
    </script>
</body>
</html>

