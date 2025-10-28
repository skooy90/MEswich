<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MES 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/dashboard.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <!-- 헤더 포함 -->
    <jsp:include page="../basic/header.jsp" />
    
    <!-- 사이드바 포함 -->
    <jsp:include page="../basic/sidebar.jsp" />
    
    <!-- 대시보드 메인 콘텐츠 -->
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>MES 대시보드</h1>
            <p>생산 현황 모니터링</p>
        </div>
        
        <!-- 6개 위젯 그리드 -->
        <div class="widget-grid">
            
            <!-- 1번 위젯: 전체 생산량 (항목 선택 기능 추가) -->
            <div class="widget-card production-widget">
                <div class="widget-header">
                    <h3>전체 생산량</h3>
                    <div class="widget-icon">📊</div>
                </div>
                <div class="widget-content">
                    
                    <!-- 생산 항목 선택 -->
                    <div class="production-selector">
                        <label for="productionSelect">생산 항목 선택:</label>
                        <select id="productionSelect" onchange="loadProductionDetail()">
                            <option value="">전체 생산량 보기</option>
                            <c:forEach var="production" items="${allProductions}">
                                <option value="${production.lotNumber}" 
                                        ${selectedLot == production.lotNumber ? 'selected' : ''}>
                                    ${production.lotNumber} - ${production.productName}
                                </option>
                            </c:forEach>
                        </select>
                        </div>
                        
                    <!-- 선택된 항목 상세 정보 (항상 표시) -->
                    <div class="selected-production-info" id="selected-production-card">
                        <h4>선택된 생산 항목 정보</h4>
                        <div class="production-details">
                            <div class="detail-row">
                                <span class="detail-label">LOT 번호:</span>
                                <span class="detail-value" id="selected-lot-number">
                                    <c:choose>
                                        <c:when test="${not empty selectedProduction}">${selectedProduction.lotNumber}</c:when>
                                        <c:otherwise>항목을 선택하세요</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">제품명:</span>
                                <span class="detail-value" id="selected-product-name">
                                    <c:choose>
                                        <c:when test="${not empty selectedProduction}">${selectedProduction.productName}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">계획 수량:</span>
                                <span class="detail-value" id="selected-planned-qty">
                                    <c:choose>
                                        <c:when test="${not empty selectedProduction}">
                                            <fmt:formatNumber value="${selectedProduction.plannedQty}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label">실제 수량:</span>
                                <span class="detail-value" id="selected-actual-qty">
                                    <c:choose>
                                        <c:when test="${not empty selectedProduction}">
                                            <fmt:formatNumber value="${selectedProduction.actualQty}" pattern="#,###" />개
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                                </div>
                            <div class="detail-row">
                                <span class="detail-label">상태:</span>
                                <span class="detail-value" id="selected-status">
                                    <c:choose>
                                        <c:when test="${not empty selectedProduction}">
                                            <span class="status-${selectedProduction.status.toLowerCase()}">${selectedProduction.status}</span>
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 전체 생산량 통계 (항목이 선택되지 않았을 때만 표시) -->
                    <!-- 생산량 비교 차트 -->
                    <div class="chart-container">
                        <canvas id="productionChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- 2번 위젯: 작업현황 -->
            <div class="widget-card work-status-widget">
                <div class="widget-header">
                    <h3>작업현황</h3>
                    <div class="widget-icon">📊</div>
                </div>
                <div class="widget-content">
                    <!-- 총 작업 현황 카드 -->
                    <div class="work-summary">
                        <div class="work-total">
                            <span class="work-number">${workStatusStats.totalWorks}</span>
                            <span class="work-unit">개</span>
                        </div>
                        <div class="work-label">총 작업 수</div>
                    </div>
                    
                    <!-- 작업 상태별 도넛 차트 -->
                    <div class="work-chart-container">
                        <canvas id="workStatusChart"></canvas>
                    </div>
                    
                    <!-- 완제품별 현황 테이블 -->
                    <div class="product-status-table">
                        <c:if test="${not empty workStatusStats.productList}">
                            <c:forEach var="product" items="${workStatusStats.productList}">
                                <div class="product-row">
                                    <div class="product-info">
                                        <span class="product-name">${product.productName}</span>
                                        <span class="product-qty">계획: ${product.plannedQty} | 실제: ${product.actualQty}</span>
                                    </div>
                                    <div class="product-rate">${product.completionRate}%</div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
            
            
            <!-- 3번 위젯: 불량 원인별 횟수 -->
            <div class="widget-card defect-cause-widget">
                <div class="widget-header">
                    <h3>불량 원인별 횟수</h3>
                    <div class="widget-icon">🔍</div>
                </div>
                <div class="widget-content">
                    <!-- 총 불량 갯수 표시 -->
                    <div class="defect-cause-summary">
                        <div class="defect-cause-total">
                            <span class="defect-cause-number" id="total-defect-causes">${defectCauseStats.totalDefects}</span>
                            <span class="defect-cause-unit">회</span>
                        </div>
                        <div class="defect-cause-label">총 불량 횟수</div>
                    </div>
                    
                    <!-- 불량 원인별 도넛 차트 -->
                    <div class="defect-cause-chart-container">
                        <canvas id="defectCauseChart"></canvas>
                    </div>
                    
                    <!-- 불량 원인별 범례 -->
                    <div class="defect-cause-legend" id="defect-cause-legend">
                        <c:if test="${not empty defectCauseStats.causeList}">
                            <c:forEach var="cause" items="${defectCauseStats.causeList}" varStatus="status">
                                <div class="legend-item">
                                    <div class="legend-color" style="background-color: <c:choose><c:when test="${status.index == 0}">#e74c3c</c:when><c:when test="${status.index == 1}">#f39c12</c:when><c:otherwise>#3498db</c:otherwise></c:choose>"></div>
                                    <div class="legend-text">
                                        <span class="legend-name">${cause.causeName}</span>
                                        <span class="legend-count">${cause.defectCount}회 (${cause.percentage}%)</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <!-- 4번 위젯: 날짜별 불량 갯수 현황 -->
            <div class="widget-card defect-stats-widget">
                <div class="widget-header">
                    <h3>날짜별 불량 갯수 현황</h3>
                    <div class="widget-icon">📊</div>
                </div>
                <div class="widget-content">
                    <!-- 총 불량 갯수 표시 -->
                    <div class="defect-summary">
                        <div class="defect-total">
                            <span class="defect-number" id="total-defects">${defectStats.totalDefects}</span>
                            <span class="defect-unit">개</span>
                        </div>
                        <div class="defect-label">총 불량 갯수</div>
                    </div>
                    
                    <!-- 날짜별 불량 갯수 차트 -->
                    <div class="defect-chart-container">
                        <canvas id="defectChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- 5번 위젯: LOT 추적 -->
            <div class="widget-card lot-tracking-widget">
                <div class="widget-header">
                    <h3>LOT 추적</h3>
                    <div class="widget-icon">🔍</div>
                </div>
                <div class="widget-content">
                    <!-- LOT 검색 입력창 -->
                    <div class="lot-search-container">
                        <input type="text" id="lotSearchInput" placeholder="LOT 번호를 입력하세요" />
                        <button onclick="searchLot()">검색</button>
                    </div>
                    
                    <!-- 검색 결과 영역 -->
                    <div id="lotTrackingResult" class="lot-tracking-result">
                        <div class="no-search">
                            <p>LOT 번호를 입력하여 추적 정보를 확인하세요</p>
                        </div>
                    </div>
                </div>
            </div>
            
<!-- 6번 위젯: Chatbot -->
<div class="widget-card chatbot-widget">
    <div class="widget-header">
        <h3>MEswich AI 챗봇</h3>
        <div class="widget-icon">🤖</div>
    </div>
    <div class="widget-content chatbot-container">
        <div class="chatbot-box">
            <textarea id="chatbot-question" rows="3" cols="50" placeholder="질문을 입력하세요" style="width:100%; resize:none;"></textarea><br>
            <button onclick="sendChatbotQuestion()" class="chatbot-btn">질문하기</button>

            <h4>응답:</h4>
            <div id="chatbot-response" style="white-space: pre-wrap; background:#f9f9f9; border:1px solid #ddd; border-radius:6px; padding:10px; min-height:60px;"></div>
        </div>
    </div>
</div>
            
        </div>
    </div>
    
    
    <script>
        // 생산 항목 선택 시 상세 정보 로드
        function loadProductionDetail() {
            const selectedLot = document.getElementById('productionSelect').value;
            if (selectedLot) {
                // 선택된 항목의 상세 정보를 AJAX로 로드
                fetch('/mes/dashboard/api/production-detail?lotNumber=' + encodeURIComponent(selectedLot))
                    .then(response => response.json())
                    .then(data => {
                        console.log('받은 데이터:', data); // 디버깅용
                        updateProductionDetail(data);
                        updateChart(data);
                    })
                    .catch(error => {
                        console.error('상세 정보 로드 중 오류:', error);
                        alert('데이터를 불러오는 중 오류가 발생했습니다.');
                    });
            } else {
                // 전체 생산량 보기로 돌아가기 - 전체 통계 카드들 다시 보이기
                const overallStatsCards = document.getElementById('overall-stats-cards');
                if (overallStatsCards) {
                    overallStatsCards.style.display = 'grid';
                }
                
                // 선택된 항목 정보 초기화
                const lotNumberElement = document.getElementById('selected-lot-number');
                const productNameElement = document.getElementById('selected-product-name');
                const plannedQtyElement = document.getElementById('selected-planned-qty');
                const actualQtyElement = document.getElementById('selected-actual-qty');
                const statusElement = document.getElementById('selected-status');
                
                if (lotNumberElement) lotNumberElement.textContent = '항목을 선택하세요';
                if (productNameElement) productNameElement.textContent = '-';
                if (plannedQtyElement) plannedQtyElement.textContent = '-';
                if (actualQtyElement) actualQtyElement.textContent = '-';
                if (statusElement) statusElement.innerHTML = '-';
                
                // 차트도 전체 데이터로 업데이트
                updateChart(null);
            }
        }
        
        // 선택된 생산 항목 상세 정보 업데이트 (기존 카드의 값만 변경)
        function updateProductionDetail(data) {
            if (!data) {
                console.error('데이터가 없습니다.');
                return;
            }
            
            // ID로 요소를 찾아서 값만 업데이트 (새로운 HTML 생성하지 않음)
            const lotNumberElement = document.getElementById('selected-lot-number');
            const productNameElement = document.getElementById('selected-product-name');
            const plannedQtyElement = document.getElementById('selected-planned-qty');
            const actualQtyElement = document.getElementById('selected-actual-qty');
            const statusElement = document.getElementById('selected-status');
            
            if (lotNumberElement) lotNumberElement.textContent = data.lotNumber || 'N/A';
            if (productNameElement) productNameElement.textContent = data.productName || 'N/A';
            if (plannedQtyElement) plannedQtyElement.textContent = (data.plannedQty || 0).toLocaleString() + '개';
            if (actualQtyElement) actualQtyElement.textContent = (data.actualQty || 0).toLocaleString() + '개';
            if (statusElement) {
                statusElement.innerHTML = '<span class="status-' + (data.status || '').toLowerCase() + '">' + (data.status || 'N/A') + '</span>';
            }
            
            // 전체 생산량 통계 카드들 숨기기
            const overallStatsCards = document.getElementById('overall-stats-cards');
            if (overallStatsCards) {
                overallStatsCards.style.display = 'none';
            }
        }
        
        // 차트 업데이트
        function updateChart(data) {
            if (data && data.plannedQty !== undefined && data.actualQty !== undefined) {
                // 선택된 항목의 데이터로 차트 업데이트
                productionChart.data.datasets[0].data = [data.plannedQty, data.actualQty];
                productionChart.data.labels = ['계획 수량', '실제 수량'];
                productionChart.options.plugins.title.text = data.lotNumber + ' - ' + data.productName;
            } else {
                // 전체 생산량 데이터로 차트 업데이트
                productionChart.data.datasets[0].data = [
                    ${productionStats.totalPlannedQty},
                    ${productionStats.totalActualQty}
                ];
                productionChart.data.labels = ['총 계획 수량', '총 실제 수량'];
                productionChart.options.plugins.title.text = '전체 생산량 비교';
            }
            productionChart.update();
        }
        
        // 초기 차트 생성
        const productionCtx = document.getElementById('productionChart').getContext('2d');
        const productionChart = new Chart(productionCtx, {
            type: 'bar',
            data: {
                labels: ['계획 수량', '실제 수량'],
                datasets: [{
                    label: '생산량',
                    data: [
                        ${productionStats.totalPlannedQty},
                        ${productionStats.totalActualQty}
                    ],
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.8)',
                        'rgba(75, 192, 192, 0.8)'
                    ],
                    borderColor: [
                        'rgba(54, 162, 235, 1)',
                        'rgba(75, 192, 192, 1)'
                    ],
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    title: {
                        display: true,
                        text: '전체 생산량 비교'
                    },
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return value.toLocaleString() + '개';
                            }
                        }
                    }
                }
            }
        });
        
//         // 30초마다 1번 위젯 데이터 새로고침
//         setInterval(function() {
//             fetch('/mes/dashboard/api/production-stats')
//                 .then(response => response.json())
//                 .then(data => {
//                     // 차트 데이터 업데이트
//                     productionChart.data.datasets[0].data = [
//                         data.totalPlannedQty,
//                         data.totalActualQty
//                     ];
//                     productionChart.update();
//                 })
//                 .catch(error => {
//                     console.error('데이터 새로고침 중 오류:', error);
//                 });
//         }, 30000);
        
        // 2번 위젯: 불량 통계 차트 생성
        let defectChart = null;
        
        // 불량 통계 차트 생성
        function createDefectChart() {
            const ctx = document.getElementById('defectChart');
            if (!ctx) return;
            
            // 서버사이드 데이터 사용
            const dailyDefects = [
                <c:forEach var="daily" items="${defectStats.dailyDefects}" varStatus="status">
                {dateStr: '${daily.dateStr}', defectCount: ${daily.defectCount}}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];
            
            if (!dailyDefects || dailyDefects.length === 0) return;
            
            // 기존 차트가 있으면 제거
            if (defectChart) {
                defectChart.destroy();
            }
            
            const labels = dailyDefects.map(item => item.dateStr);
            const defectCounts = dailyDefects.map(item => item.defectCount);
            
            defectChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '불량 갯수',
                        data: defectCounts,
                        borderColor: '#e74c3c',
                        backgroundColor: 'rgba(231, 76, 60, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: '날짜별 불량 갯수 추이'
                        },
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString() + '개';
                                }
                            }
                        }
                    }
                }
            });
        }
        
        // 페이지 로드 시 차트 생성
        document.addEventListener('DOMContentLoaded', function() {
            // 서버사이드 데이터로 차트 생성
            createDefectChart();
            createDefectCauseChart();
            createWorkStatusChart();
            
            // 작업현황 하단 테이블 페이징 초기화 추가
            setTimeout(() => {
                initWorkStatusPagination();
            }, 100);
        });
        
        // 3번 위젯: 불량 원인별 도넛 차트 생성
        let defectCauseChart = null;
        
        // 불량 원인별 도넛 차트 생성
        function createDefectCauseChart() {
            const ctx = document.getElementById('defectCauseChart');
            if (!ctx) return;
            
            // 서버사이드 데이터 사용
            const causeList = [
                <c:forEach var="cause" items="${defectCauseStats.causeList}" varStatus="status">
                {causeName: '${cause.causeName}', defectCount: ${cause.defectCount}, percentage: ${cause.percentage}}<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];
            
            if (!causeList || causeList.length === 0) return;
            
            // 기존 차트가 있으면 제거
            if (defectCauseChart) {
                defectCauseChart.destroy();
            }
            
            const labels = causeList.map(item => item.causeName);
            const defectCounts = causeList.map(item => item.defectCount);
            const percentages = causeList.map(item => item.percentage);
            
            // 색상 배열 (3가지 원인에 맞춤)
            const colors = ['#e74c3c', '#f39c12', '#3498db'];
            const backgroundColors = colors.map(color => color + '80'); // 투명도 추가
            
            defectCauseChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '불량 갯수',
                        data: defectCounts,
                        backgroundColor: backgroundColors,
                        borderColor: colors,
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: '불량 원인별 분포'
                        },
                        legend: {
                            display: false // 범례는 별도로 표시
                        }
                    },
                    cutout: '60%' // 도넛 차트의 내부 구멍 크기
                }
            });
            
        }
        
        // 4번 위젯: 작업현황 도넛 차트 생성
        let workStatusChart = null;
        
        // 작업현황 도넛 차트 생성
        function createWorkStatusChart() {
            const ctx = document.getElementById('workStatusChart');
            if (!ctx) return;
            
            // 서버사이드 데이터 사용
            const statusList = [
            	<c:forEach var="workStatus" items="${workStatusStats.statusList}" varStatus="status">
                {status: '${workStatus.status}', workCount: ${workStatus.workCount}}<c:if test="${!status.last}">,</c:if>
            </c:forEach>
            ];
            
            if (!statusList || statusList.length === 0) return;
            
            // 기존 차트가 있으면 제거
            if (workStatusChart) {
                workStatusChart.destroy();
            }
            
            const labels = statusList.map(item => item.status);
            const workCounts = statusList.map(item => item.workCount);
            
            // 색상 배열 (작업 상태별)
            const colors = ['#3498db', '#f39c12', '#2ecc71', '#e74c3c'];
            const backgroundColors = colors.map(color => color + '80'); // 투명도 추가
            
            workStatusChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '작업 수',
                        data: workCounts,
                        backgroundColor: backgroundColors,
                        borderColor: colors,
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        title: {
                            display: true,
                            text: '작업 상태별 분포'
                        },
                        legend: {
                            display: true,
                            position: 'bottom'
                        }
                    },
                    cutout: '60%' // 도넛 차트의 내부 구멍 크기
                }
            });
        }
        
        // LOT 검색 기능
        function searchLot() {
            const lotNumber = document.getElementById('lotSearchInput').value;
            if (!lotNumber.trim()) {
                alert('LOT 번호를 입력해주세요.');
                return;
            }
            
            fetch('/mes/dashboard/api/lot-tracking?lotNumber=' + encodeURIComponent(lotNumber))
                .then(response => response.json())
                .then(data => {
                    displayLotTrackingResult(data, lotNumber);
                })
                .catch(error => {
                    console.error('LOT 추적 조회 중 오류:', error);
                    alert('LOT 정보를 불러오는 중 오류가 발생했습니다.');
                });
        }
        
        // 상태값을 한글로 변환하는 함수
        function getStatusKorean(status) {
            const statusMap = {
                'PLANNED': '계획됨',
                'IN_PROGRESS': '진행중',
                'COMPLETED': '완료',
                'HOLD': '보류',
                'CANCELLED': '취소됨',
                'WAIT_QUALITY': '품질검사 대기',
                'QUALITY_PASS': '품질검사 통과',
                'QUALITY_FAIL': '품질검사 실패',
                'INVENTORY_CONFIRMED': '재고 확정'
            };
            return statusMap[status] || status; // 매핑되지 않은 경우 원본 반환
        }
        
        // LOT 추적 결과 표시
        function displayLotTrackingResult(trackingList, lotNumber) {
            const resultDiv = document.getElementById('lotTrackingResult');
            
            if (!trackingList || trackingList.length === 0) {
                resultDiv.innerHTML = 
                    '<div class="no-result">' +
                        '<p>LOT 번호 "' + lotNumber + '"에 대한 추적 정보가 없습니다.</p>' +
                    '</div>';
                return;
            }
            
            // 현재 상태 (가장 최근)
            const currentStatus = trackingList[trackingList.length - 1];
            
            // 이력 목록 (최근 5건만)
            const recentHistory = trackingList.slice(-5).reverse();
            
            // 이력 HTML 생성
            let historyHtml = '';
            for (let i = 0; i < recentHistory.length; i++) {
                const item = recentHistory[i];
                const koreanStatus = getStatusKorean(item.status);
                historyHtml += '<div class="history-item">';
                historyHtml += '<span class="status-badge status-' + item.status.toLowerCase() + '">' + koreanStatus + '</span>';
                historyHtml += '<span class="date">' + formatDate(item.startDate) + '</span>';
                if (item.remarks) {
                    historyHtml += '<span class="remarks">' + item.remarks + '</span>';
                }
                historyHtml += '</div>';
            }
            
            const currentKoreanStatus = getStatusKorean(currentStatus.status);
            
            resultDiv.innerHTML = 
                '<div class="lot-summary">' +
                    '<h4>' + lotNumber + '</h4>' +
                    '<div class="current-status">' +
                        '현재 상태: <span class="status-' + currentStatus.status.toLowerCase() + '">' + currentKoreanStatus + '</span>' +
                    '</div>' +
                    '<div class="elapsed-time">' +
                        '시작일: ' + formatDate(currentStatus.startDate) +
                    '</div>' +
                '</div>' +
                '<div class="recent-history">' +
                    '<h5>최근 이력 (최근 5건)</h5>' +
                    '<div class="history-list">' +
                        historyHtml +
                    '</div>' +
                '</div>';
        }
        
        // 날짜 포맷팅 함수
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('ko-KR') + ' ' + date.toLocaleTimeString('ko-KR', {hour: '2-digit', minute: '2-digit'});
        }
        
        //6번 위젯 
        function sendChatbotQuestion() {
    const q = document.getElementById("chatbot-question").value.trim();
    if (!q) {
        alert("질문을 입력하세요.");
        return;
    }

    const url = "<c:url value='/chatbot/ask' />";

    fetch(url, {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify({question: q})
    })
    .then(res => {
        if (!res.ok) throw new Error(`HTTP Error! Status: ${res.status}`);
        return res.json();
    })
    .then(data => {
        document.getElementById("chatbot-response").innerText = data.answer;
    })
    .catch(error => {
        document.getElementById("chatbot-response").innerText = `❌ 오류 발생: ${error.message}`;
        console.error('Chatbot Error:', error);
    });
}

        // 작업현황 하단 테이블 페이징 기능
        let currentWorkPage = 1;
        const workItemsPerPage = 4; // 한 페이지에 표시할 항목 수

        // 작업현황 페이징 초기화
        function initWorkStatusPagination() {
            const productRows = document.querySelectorAll('.product-row');
            const totalItems = productRows.length;
            const totalPages = Math.ceil(totalItems / workItemsPerPage);
            
            if (totalPages <= 1) return; // 페이지가 1개 이하면 페이징 숨김
            
            // 페이징 컨트롤 생성
            createWorkPaginationControls(totalPages);
            
            // 첫 페이지 표시
            showWorkPage(1);
        }

        // 페이징 컨트롤 생성
        function createWorkPaginationControls(totalPages) {
            const productStatusTable = document.querySelector('.product-status-table');
            
            // 페이징 컨트롤 HTML 생성
            const paginationHTML = `
                <div class="work-pagination-controls">
                    <button class="work-pagination-btn work-prev-btn" onclick="changeWorkPage(-1)" disabled>
                        ◀ 이전
                    </button>
                    <span class="work-pagination-info">
                        <span id="work-current-page">1</span> / <span id="work-total-pages">${totalPages}</span>
                    </span>
                    <button class="work-pagination-btn work-next-btn" onclick="changeWorkPage(1)">
                        다음 ▶
                    </button>
                </div>
            `;
            
            // 페이징 컨트롤을 테이블 뒤에 추가
            productStatusTable.insertAdjacentHTML('afterend', paginationHTML);
        }

        // 페이지 변경
        function changeWorkPage(direction) {
            const productRows = document.querySelectorAll('.product-row');
            const totalItems = productRows.length;
            const totalPages = Math.ceil(totalItems / workItemsPerPage);
            
            // 현재 페이지 계산
            currentWorkPage += direction;
            
            // 페이지 범위 체크
            if (currentWorkPage < 1) currentWorkPage = 1;
            if (currentWorkPage > totalPages) currentWorkPage = totalPages;
            
            // 페이지 표시
            showWorkPage(currentWorkPage);
            
            // 버튼 상태 업데이트
            updateWorkPaginationButtons(totalPages);
        }

        // 특정 페이지 표시
        function showWorkPage(page) {
            const productRows = document.querySelectorAll('.product-row');
            
            // 모든 항목 숨기기
            productRows.forEach(row => {
                row.style.display = 'none';
            });
            
            // 현재 페이지 항목들만 표시
            const startIndex = (page - 1) * workItemsPerPage;
            const endIndex = startIndex + workItemsPerPage;
            
            for (let i = startIndex; i < endIndex && i < productRows.length; i++) {
                productRows[i].style.display = 'flex';
            }
            
            // 페이지 정보 업데이트
            document.getElementById('work-current-page').textContent = page;
        }

        // 페이징 버튼 상태 업데이트
        function updateWorkPaginationButtons(totalPages) {
            const prevBtn = document.querySelector('.work-prev-btn');
            const nextBtn = document.querySelector('.work-next-btn');
            
            // 이전 버튼 상태
            if (currentWorkPage <= 1) {
                prevBtn.disabled = true;
                prevBtn.style.opacity = '0.5';
            } else {
                prevBtn.disabled = false;
                prevBtn.style.opacity = '1';
            }
            
            // 다음 버튼 상태
            if (currentWorkPage >= totalPages) {
                nextBtn.disabled = true;
                nextBtn.style.opacity = '0.5';
            } else {
                nextBtn.disabled = false;
                nextBtn.style.opacity = '1';
            }
        }
    </script>
</body>
</html>