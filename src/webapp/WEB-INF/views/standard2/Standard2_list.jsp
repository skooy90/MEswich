<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>품목 기준정보 목록</title>
</head>
<body>

<!-- 상단 헤더 -->
<jsp:include page="/WEB-INF/views/basic/header.jsp" />

<!-- 왼쪽 사이드바 -->
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<!-- 🟢 본문 영역 (헤더 높이 + 사이드바 폭을 고려해 margin 설정) -->
<div class="content">
    <div class="page-header">
        <h2>품목 기준정보 목록</h2>
        <div class="actions">
            <a class="btn btn-primary" href="/mes/standard2/insertForm">+ 신규 등록</a>
        </div>
    </div>

    <div class="table-card">
        <table class="list-table">
            <thead>
                <tr>
                    <th>품목코드</th>
                    <th>품목명</th>
                    <th>유형</th>
                    <th>단위</th>
                    <th>등록일</th>
                    <th>생성자</th>
                    <th style="width:120px;">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${standardList}">
                    <tr>
                        <td>${s.itemCode}</td>
                        <td class="text-left">${s.itemName}</td>
                        <td>
                            <span class="badge ${s.itemType == 'FG' ? 'badge-green' : 'badge-blue'}">
                                ${s.itemType}
                            </span>
                        </td>
                        <td>${s.unit}</td>
                        <td><fmt:formatDate value="${s.createdDate}" pattern="yyyy-MM-dd" /></td>
                        <td>${s.createdBy}</td>
                        <td>
                            <a class="link" href="${pageContext.request.contextPath}/standard2/updateForm/${s.itemCode}">수정</a>
                            <span class="divider">|</span>
                            <a class="link link-danger" href="${pageContext.request.contextPath}/standard2/delete/${s.itemCode}">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <!-- 페이징 영역 (더미 UI, 추후 서버 연동 가능) -->
        <div class="pagination">
            <a href="#" class="page-btn">«</a>
            <a href="#" class="page-btn active">1</a>
            <a href="#" class="page-btn">2</a>
            <a href="#" class="page-btn">3</a>
            <a href="#" class="page-btn">»</a>
        </div>
    </div>
</div>


<!-- 🟢 본문 영역 레이아웃 CSS -->
<style>
.content { margin-left: 220px; margin-top: 80px; padding: 20px; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.actions { display: flex; gap: 8px; }
.btn { padding: 8px 12px; border-radius: 6px; text-decoration: none; color: #fff; font-weight: 600; }
.btn-primary { background-color: #2c3e50; }
.btn-primary:hover { background-color: #34495e; }

.table-card { background: #fff; border: 1px solid #e9ecef; border-radius: 8px; padding: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.06); }
.list-table { border-collapse: collapse; width: 100%; }
.list-table thead th { background: #f8f9fa; border-bottom: 1px solid #e9ecef; padding: 10px; font-weight: 700; }
.list-table tbody td { border-top: 1px solid #f1f3f5; padding: 10px; text-align: center; }
.list-table .text-left { text-align: left; }

.badge { display: inline-block; padding: 2px 8px; border-radius: 999px; font-size: 12px; font-weight: 700; }
.badge-green { background: #e6f4ea; color: #1e7e34; }
.badge-blue  { background: #e7f1ff; color: #0b5ed7; }

.link { color: #0b5ed7; text-decoration: none; font-weight: 600; }
.link:hover { text-decoration: underline; }
.link-danger { color: #d63384; }
.divider { color: #adb5bd; margin: 0 6px; }

.pagination { display: flex; gap: 6px; justify-content: center; align-items: center; padding: 12px 0 4px; }
.page-btn { padding: 6px 10px; border: 1px solid #dee2e6; border-radius: 6px; text-decoration: none; color: #495057; background: #fff; }
.page-btn.active, .page-btn:hover { background: #2c3e50; color: #fff; border-color: #2c3e50; }
</style>

</body>
</html>