<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="side-title">
        <h3>🏭 MES 시스템</h3>
    </div>
    
    <!-- 일반 사용자 메뉴 -->
    <nav class="side-menu">
        <div class="menu-section">
            <h4 class="section-title">📊 모니터링</h4>
            <ul>
                <li><a href="/mes/dashboard">📈 대시보드</a></li>
            </ul>
        </div>
        
        <div class="menu-section">
            <h4 class="section-title">🔧 기본 정보</h4>
            <ul>
                <li><a href="/mes/standard2/list">📋 기준 정보</a></li>
                <li><a href="/mes/bom2/list">🔗 BOM 관리</a></li>
                <li><a href="/mes/processRouting2/list">🛤️ 공정 라우팅</a></li>
            </ul>
        </div>
        
        <div class="menu-section">
            <h4 class="section-title">🏭 생산 관리</h4>
            <ul>
                <li><a href="/mes/production/list">⚙️ 생산 계획</a></li>
                <li><a href="/mes/work">📝 작업 지시</a></li>
                <li><a href="/mes/quality">🔍 품질 관리</a></li>
            </ul>
        </div>
        
        <div class="menu-section">
            <h4 class="section-title">📦 재고 관리</h4>
            <ul>
                <li><a href="/mes/inventory">📊 재고 현황</a></li>
                <li><a href="/mes/lotTracking2/list">🔍 LOT 추적</a></li>
            </ul>
        </div>
    </nav>
    
    <!-- 관리자 전용 메뉴 (하단 고정) -->
    <div class="admin-section">
        <div class="admin-divider"></div>
        <div class="menu-section admin-menu">
            <h4 class="section-title admin-title">👑 관리자 전용</h4>
            <ul>
                <li><a href="/mes/users2/list">👥 사용자 관리</a></li>
            </ul>
        </div>
    </div>
</aside>

<style>
.sidebar {
    position: fixed;
    top: 60px;
    left: 0;
    width: 220px; /* 너비 증가 */
    height: calc(100vh - 60px);
    background: linear-gradient(180deg, #2c3e50 0%, #34495e 100%);
    color: #ecf0f1;
    padding: 0;
    z-index: 500;
    display: flex;
    flex-direction: column;
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
}

.side-title {
    text-align: center;
    padding: 20px 15px;
    background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
    margin: 0;
    border-bottom: 2px solid #2980b9;
}

.side-title h3 {
    margin: 0;
    font-size: 1.2em;
    font-weight: 600;
    color: white;
    text-shadow: 0 1px 2px rgba(0,0,0,0.3);
}

.side-menu {
    flex: 1;
    padding: 15px 0;
    overflow-y: auto;
}

.menu-section {
    margin-bottom: 25px;
}

.section-title {
    font-size: 0.85em;
    font-weight: 600;
    color: #bdc3c7;
    text-transform: uppercase;
    letter-spacing: 1px;
    margin: 0 0 10px 0;
    padding: 0 20px 5px 20px;
    border-bottom: 1px solid #34495e;
}

.menu-section ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.menu-section li {
    margin: 2px 0;
}

.menu-section a {
    display: block;
    color: #ecf0f1;
    text-decoration: none;
    padding: 12px 20px;
    transition: all 0.3s ease;
    border-left: 3px solid transparent;
    font-size: 0.95em;
}

.menu-section a:hover {
    background: linear-gradient(90deg, rgba(52, 152, 219, 0.2) 0%, rgba(52, 152, 219, 0.1) 100%);
    border-left-color: #3498db;
    transform: translateX(5px);
}

.menu-section a:active {
    background: linear-gradient(90deg, rgba(52, 152, 219, 0.3) 0%, rgba(52, 152, 219, 0.2) 100%);
}

/* 관리자 전용 섹션 */
.admin-section {
    margin-top: auto;
    background: linear-gradient(180deg, rgba(231, 76, 60, 0.1) 0%, rgba(192, 57, 43, 0.2) 100%);
    border-top: 2px solid #e74c3c;
}

.admin-divider {
    height: 1px;
    background: linear-gradient(90deg, transparent 0%, #e74c3c 50%, transparent 100%);
    margin: 10px 20px;
}

.admin-menu .section-title {
    color: #e74c3c;
    border-bottom-color: #e74c3c;
}

.admin-menu a {
    color: #ecf0f1;
}

.admin-menu a:hover {
    background: linear-gradient(90deg, rgba(231, 76, 60, 0.2) 0%, rgba(231, 76, 60, 0.1) 100%);
    border-left-color: #e74c3c;
}

/* 스크롤바 스타일링 */
.side-menu::-webkit-scrollbar {
    width: 6px;
}

.side-menu::-webkit-scrollbar-track {
    background: #2c3e50;
}

.side-menu::-webkit-scrollbar-thumb {
    background: #34495e;
    border-radius: 3px;
}

.side-menu::-webkit-scrollbar-thumb:hover {
    background: #3498db;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .sidebar {
        width: 180px;
    }
    
    .side-title h3 {
        font-size: 1em;
    }
    
    .menu-section a {
        padding: 10px 15px;
        font-size: 0.9em;
    }
}
</style>
