<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="side-title">
        <h3>메뉴</h3>
    </div>
    <nav class="side-menu">
        <ul>
            <li><a href="#">📊 대시보드</a></li>
            <li><a href="#">🏭 생산 관리</a></li>
            <li><a href="#">🧾 작업 지시</a></li>
            <li><a href="#">📦 재고 관리</a></li>
            <li><a href="#">🔧 기준 정보</a></li>
            <li><a href="#">👤 사용자 관리</a></li>
        </ul>
    </nav>
</aside>

<style>
.sidebar {
    position: fixed; /* 왼쪽 고정 */
    top: 60px; /* header 높이만큼 아래로 */
    left: 0;
    width: 200px;
    height: calc(100vh - 60px);
    background-color: #34495e;
    color: #ecf0f1;
    padding-top: 20px;
    z-index: 500; /* header보다 아래 */
}

.side-title {
    text-align: center;
    margin-bottom: 20px;
}

.side-menu ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.side-menu li {
    margin: 10px 0;
}

.side-menu a {
    display: block;
    color: #ecf0f1;
    text-decoration: none;
    padding: 10px 20px;
    transition: background 0.3s;
}

.side-menu a:hover {
    background-color: #2c3e50;
}
</style>
