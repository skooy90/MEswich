<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="main-header">
    <div class="logo">
        <h2>MEswich Dashboard</h2>
    </div>
    <div class="user-menu">
        <a href="#">관리자</a>
        <span>|</span>
        <a href="#">로그아웃</a>
    </div>
</header>

<style>
/* --- 전역 박스모델 정렬 (padding 포함해서 width 계산) --- */
* {
    box-sizing: border-box;
}

/* --- 헤더 영역 --- */
.main-header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 60px;
    background-color: #2c3e50;
    color: #fff;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 25px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    z-index: 1000;
    overflow: hidden; /* 오른쪽 잘림 방지 */
}

.main-header .logo h2 {
    margin: 0;
    font-size: 20px;
    font-weight: bold;
    white-space: nowrap;
}

.main-header .user-menu {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-shrink: 0;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}

.main-header .user-menu a {
    color: #fff;
    text-decoration: none;
    font-size: 15px;
}

.main-header .user-menu a:hover {
    text-decoration: underline;
}
</style>

