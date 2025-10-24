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
            
            <!-- 2번 위젯: 날짜별 불량 갯수 현황 -->
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
            
            <!-- 4번 위젯: 작업현황 -->
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
            
            <!-- 5번 위젯: 양품현황 (미구현) -->
            <div class="widget-card quality-widget">
                <div class="widget-header">
                    <h3>양품현황</h3>
                    <div class="widget-icon">✅</div>
                </div>
                <div class="widget-content">
                    <div class="coming-soon">
                        <div class="coming-soon-icon">🚧</div>
                        <p>구현 예정</p>
                        <small>품질 현황 및 양품률</small>
                    </div>
                </div>
            </div>
            
            <!-- 6번 위젯: LOT 추적 (미구현) -->
            <div class="widget-card lot-tracking-widget">
                <div class="widget-header">
                    <h3>LOT 추적</h3>
                    <div class="widget-icon">🔍</div>
                </div>
                <div class="widget-content">
                    <div class="coming-soon">
                        <div class="coming-soon-icon">🚧</div>
                        <p>구현 예정</p>
                        <small>LOT 번호 검색 기능</small>
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
    </script>
</body>
</html>