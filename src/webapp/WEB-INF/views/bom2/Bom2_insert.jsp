<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <div class="page-header">
        <h2>BOM 등록</h2>
    </div>

    <div class="form-card">
        <form action="/mes/bom2/insert" method="post">
            <!-- ✅ 완제품 선택 영역 -->
            <table class="info-table">
                <tr>
                    <th>완제품 선택</th>
                    <td>
                        <select name="productCode" required>
                            <option value="">-- 선택 --</option>
                            <c:forEach var="p" items="${productList}">
                                <c:if test="${not registeredProducts.contains(p.itemCode)}">
                                    <option value="${p.itemCode}">${p.itemName} (${p.itemCode})</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>등록자</th>
                    <td><input type="text" name="createdBy" value="admin" readonly /></td>
                </tr>
            </table>

            <!-- ✅ 자재 구성 -->
            <h3 class="section-title">자재 구성</h3>

            <table id="materialTable" class="material-table">
                <thead>
                    <tr>
                        <th>자재 선택</th>
                        <th>단위</th>
                        <th>수량</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <select name="materialCode" class="materialSelect" required>
                                <option value="">-- 선택 --</option>
                                <c:forEach var="m" items="${materialList}">
                                    <option value="${m.itemCode}" data-unit="${m.unit}">
                                        ${m.itemName} (${m.itemCode})
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td><input type="text" name="unit" class="unitInput" placeholder="EA" readonly required /></td>
                        <td><input type="number" step="0.01" name="quantity" required /></td>
                        <td><button type="button" class="btn btn-danger removeBtn">삭제</button></td>
                    </tr>
                </tbody>
            </table>

            <div class="btn-row">
                <button type="button" id="addMaterialBtn" class="btn btn-add">+ 자재 추가</button>
            </div>

            <div class="btn-row" style="margin-top:25px;">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <a href="/mes/bom2/list" class="btn btn-cancel">취소</a>
            </div>
        </form>
    </div>
</div>

<style>
/* ✅ 공통 레이아웃 */
.content {
    margin-left: 220px;
    margin-top: 70px;
    padding: 40px 70px;
    background: #f4f6f9;
    min-height: 100vh;
    font-family: 'Segoe UI', sans-serif;
}

/* ✅ 제목 영역 */
.page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 25px;
}

.page-header h2 {
    font-size: 22px;
    font-weight: 700;
    color: #2c3e50;
    margin: 0;
}

/* ✅ 카드형 폼 */
.form-card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
    padding: 30px 40px;
}

/* 상단 입력 테이블 */
.info-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 25px;
}

.info-table th, .info-table td {
    border: 1px solid #e0e0e0;
    padding: 12px 15px;
    font-size: 15px;
}

.info-table th {
    background-color: #f8f9fa;
    width: 180px;
    text-align: left;
    color: #2c3e50;
}

.info-table select,
.info-table input {
    width: 250px;
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
}

/* ✅ 자재 구성 테이블 */
.section-title {
    font-size: 18px;
    font-weight: 600;
    color: #2c3e50;
    margin: 15px 0 10px;
}

.material-table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}

.material-table th, .material-table td {
    border: 1px solid #e0e0e0;
    padding: 12px 14px;
    text-align: center;
}

.material-table th {
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: #fff;
    font-weight: 600;
}

.material-table tr:nth-child(even) {
    background-color: #fafafa;
}

.material-table tr:hover {
    background-color: #eef4ff;
    transition: background 0.2s;
}

.material-table select,
.material-table input {
    width: 90%;
    padding: 7px 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* ✅ 버튼 스타일 */
.btn-row {
    display: flex;
    justify-content: flex-start;
    gap: 10px;
}

.btn {
    display: inline-block;
    padding: 8px 16px;
    border-radius: 6px;
    text-decoration: none;
    color: #fff;
    font-weight: 600;
    cursor: pointer;
    border: none;
    transition: all 0.2s ease;
    font-size: 14px;
}

.btn-primary {
    background: #2c3e50;
}
.btn-primary:hover {
    background: #34495e;
}

.btn-cancel {
    background: #7f8c8d;
}
.btn-cancel:hover {
    background: #707b7c;
}

.btn-add {
    background: linear-gradient(135deg, #4a90e2, #357abd);
}
.btn-add:hover {
    background: linear-gradient(135deg, #357abd, #2c3e50);
    transform: translateY(-1px);
}

.btn-danger {
    background-color: #c0392b;
}
.btn-danger:hover {
    background-color: #a93226;
}
</style>


<script>
// ✅ 자재 선택 시 단위 자동 반영
document.addEventListener("change", function(e) {
    if (e.target.classList.contains("materialSelect")) {
        const selectedOption = e.target.options[e.target.selectedIndex];
        const unit = selectedOption.getAttribute("data-unit") || "";
        const row = e.target.closest("tr");
        const unitInput = row.querySelector(".unitInput");
        unitInput.value = unit;
    }
});

// ✅ 자재 행 추가
document.getElementById("addMaterialBtn").addEventListener("click", function() {
    const tbody = document.querySelector("#materialTable tbody");
    const newRow = tbody.rows[0].cloneNode(true);

    newRow.querySelectorAll("input, select").forEach(el => {
        if (el.tagName === "SELECT") el.selectedIndex = 0;
        else el.value = "";
    });

    tbody.appendChild(newRow);
});

// ✅ 자재 행 삭제
document.addEventListener("click", function(e) {
    if (e.target.classList.contains("removeBtn")) {
        const row = e.target.closest("tr");
        const tbody = row.parentNode;
        if (tbody.rows.length > 1) row.remove();
    }
});
</script>




