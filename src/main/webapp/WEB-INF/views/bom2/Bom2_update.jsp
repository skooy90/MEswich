<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<style>
.content {
    margin-left: 220px;
    padding: 40px;
    min-height: 100vh;
    background-color: #fff;
}

h2 {
    margin-bottom: 25px;
    text-align: center;
    font-weight: bold;
    color: #2c3e50;
}

.info-box {
    margin-bottom: 20px;
    padding: 15px 20px;
    border-left: 4px solid #2c3e50;
    background-color: #f9fafb;
    width: 70%;
    margin-left: auto;
    margin-right: auto;
}

table {
    width: 70%;
    margin: 0 auto;
    border-collapse: collapse;
    text-align: center;
    background-color: #fff;
    box-shadow: 0 2px 6px rgba(0,0,0,0.08);
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
}
th {
    background-color: #f4f6f8;
    font-weight: 600;
}
tr:hover {
    background-color: #f9f9f9;
}

.btn {
    display: inline-block;
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    color: #fff;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.2s ease;
}
.btn-primary { background-color: #2c3e50; }
.btn-primary:hover { background-color: #1a252f; }
.btn-danger { background-color: #c0392b; }
.btn-danger:hover { background-color: #922b21; }
.btn-secondary { background-color: #7f8c8d; }
.btn-secondary:hover { background-color: #606e73; }
.btn-add { background-color: #27ae60; }
.btn-add:hover { background-color: #1e8449; }

.btn-area {
    width: 70%;
    margin: 25px auto 0;
    display: flex;
    justify-content: flex-start;
    gap: 10px;
}

select, input[type="number"], input[type="text"] {
    width: 85%;
    padding: 6px 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}
</style>

<div class="content">
    <h2>BOM 수정</h2>

    <div class="info-box">
        <p><strong>제품 코드:</strong> ${bom.productCode}</p>
        <p><strong>등록된 자재 수:</strong> ${fn:length(bom.materialList)}</p>
    </div>

    <!-- 🔹 자재 추가 영역 -->
    <table>
        <thead>
            <tr>
                <th colspan="5" style="text-align:left; padding:10px; background:#ecf0f1;">
                    🔹 자재 추가
                </th>
            </tr>
            <tr>
                <th>자재 선택</th>
                <th>단위</th>
                <th>수량</th>
                <th>추가</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <!-- 자재코드 select -->
                <td>
                    <select id="newMaterialCode">
                        <option value="">-- 원자재 선택 --</option>
                        <c:forEach var="m" items="${materialList}">
                            <option value="${m.itemCode}">${m.itemName} (${m.itemCode})</option>
                        </c:forEach>
                    </select>
                </td>

                <!-- 단위 select -->
                <td>
                    <select id="newUnit">
                        <option value="">-- 선택 --</option>
                        <option value="EA">EA</option>
                        <option value="g">g</option>
                        <option value="ml">ml</option>
                    </select>
                </td>

                <td><input type="number" step="0.01" id="newQuantity" placeholder="예: 10.0" /></td>
                <td><button type="button" id="btnAddMaterial" class="btn btn-add">추가</button></td>
            </tr>
        </tbody>
    </table>

    <!-- 🔹 기존 자재 목록 -->
    <form id="updateForm">
        <table style="margin-top:30px;">
            <thead>
                <tr>
                    <th>자재코드</th>
                    <th>자재명</th>
                    <th>단위</th>
                    <th>수량</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${bom.materialList}">
                    <tr>
                        <td>${m.materialCode}</td>
                        <td>${m.materialName}</td>
                <td>
                    <select id="newUnit">
                        <option value="">-- 선택 --</option>
                        <option value="EA">EA</option>
                        <option value="g">g</option>
                        <option value="ml">ml</option>
                    </select>
                </td>
                        <td>
                            <input type="number" step="0.01" name="quantity" value="${m.quantity}" data-product="${bom.productCode}" data-material="${m.materialCode}">
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary btn-save" data-product="${bom.productCode}" data-material="${m.materialCode}">저장</button>
                            <button type="button" class="btn btn-danger btn-delete" data-product="${bom.productCode}" data-material="${m.materialCode}">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>

<div class="btn-area">
    <a href="/mes/bom2/list" class="btn btn-secondary">← 목록으로</a>
<a href="/mes/bom2/deleteAll/${bom.productCode}"
   class="btn btn-danger"
   onclick="return confirm('이 BOM 전체를 삭제하시겠습니까?\n(모든 자재 내역이 함께 삭제됩니다.)')">
   BOM 전체 삭제
</a>
</div>

	

<script>
// ✅ 수정
document.querySelectorAll('.btn-save').forEach(btn => {
    btn.addEventListener('click', function() {
        const productCode = this.dataset.product;
        const materialCode = this.dataset.material;
        const row = this.closest('tr');
        const unit = row.querySelector('input[name="unit"]').value;
        const quantity = row.querySelector('input[name="quantity"]').value;

        fetch('/mes/bom2/updateInline', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ productCode, materialCode, unit, quantity })
        })
        .then(res => res.text())
        .then(result => {
            alert(result === 'success' ? '수정 완료' : '수정 실패');
            if (result === 'success') location.reload();
        });
    });
});

// ✅ 삭제
// document.querySelectorAll('.btn-delete').forEach(btn => {
//     btn.addEventListener('click', function() {
//         if (!confirm('이 자재를 삭제하시겠습니까?')) return;
//         const productCode = this.dataset.product;
//         const materialCode = this.dataset.material;

//         fetch('/mes/bom2/deleteInline', {
//             method: 'POST',
//             headers: { 'Content-Type': 'application/json' },
//             body: JSON.stringify({ productCode, materialCode })
//         })
//         .then(res => res.text())
//         .then(result => {
//             alert(result === 'success' ? '삭제 완료' : '삭제 실패');
//             if (result === 'success') location.reload();
//         });
//     });
// });

// ✅ 추가 (select형)
document.getElementById('btnAddMaterial').addEventListener('click', function() {
    const productCode = "${bom.productCode}";
    const materialCode = document.getElementById('newMaterialCode').value;
    const unit = document.getElementById('newUnit').value;
    const quantity = document.getElementById('newQuantity').value;

    if (!materialCode || !unit || !quantity) {
        alert('모든 항목을 선택 또는 입력해주세요.');
        return;
    }

    fetch('/mes/bom2/insertInline', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ productCode, materialCode, unit, quantity, createdBy: 'admin' })
    })
    .then(res => res.text())
    .then(result => {
        if (result === 'success') {
            alert('자재가 추가되었습니다.');
            location.reload();
        } else if (result === 'duplicate') {
            alert('이미 등록된 자재입니다.');
        } else {
            alert('추가 실패');
        }
    });
});
//✅ BOM 전체 삭제
document.getElementById('btnDeleteBom').addEventListener('click', function() {
    if (!confirm('이 BOM 전체를 삭제하시겠습니까?\n(모든 자재 내역이 함께 삭제됩니다.)')) return;

    const productCode = "${bom.productCode}";

    fetch('/mes/bom2/deleteBom', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ productCode })
    })
    .then(res => res.text())
    .then(result => {
        if (result === 'success') {
            alert('BOM 전체가 삭제되었습니다.');
            location.href = '/mes/bom2/list';
        } else {
            alert('삭제 실패');
        }
    })
    .catch(err => {
        console.error(err);
        alert('오류가 발생했습니다.');
    });
});
</script>




