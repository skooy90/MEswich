<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    min-height: 100vh;
    background-color: #fff;
}
.content h2 { margin-bottom: 20px; }
table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}
th, td { border: 1px solid #ddd; padding: 10px; }
th { background-color: #f4f6f8; }
tr:hover { background-color: #f9f9f9; }
.btn {
    background-color: #2c3e50; color: #fff;
    padding: 6px 12px; border: none; border-radius: 4px;
    text-decoration: none; cursor: pointer;
}
.btn:hover { background-color: #1a252f; }
</style>

<div class="content">
    <h2>BOM 등록</h2>

    <form action="/mes/bom2/insert" method="post">
        <table>
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

        <h3 style="margin:20px 0 10px;">자재 구성</h3>
        <table id="materialTable">
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
                    <td>
                        <input type="text" name="unit" class="unitInput" placeholder="EA" readonly required />
                    </td>
                    <td><input type="number" step="0.01" name="quantity" required /></td>
                    <td><button type="button" class="btn removeBtn" style="background-color:#c0392b;">삭제</button></td>
                </tr>
            </tbody>
        </table>

        <div style="margin-top:15px;">
            <button type="button" id="addMaterialBtn" class="btn">+ 자재 추가</button>
        </div>

        <div style="margin-top:20px;">
            <button type="submit" class="btn">등록하기</button>
            <a href="/mes/bom2/list" class="btn" style="background-color:#7f8c8d;">취소</a>
        </div>
    </form>
</div>

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




