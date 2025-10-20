<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 라우팅 등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <div class="page-header">
        <h2>공정 라우팅 등록</h2>
        <div class="actions">
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/processRouting2/list">목록으로</a>
        </div>
    </div>

    <div class="form-card">
        <form id="routingForm" action="${pageContext.request.contextPath}/processRouting2/insert" method="post">
            
            <!-- ✅ 완제품 선택 -->
            <div class="form-group">
                <label>완제품 선택</label>
                <select name="productCode" required>
                    <option value="">-- 완제품 선택 --</option>
                    <c:forEach var="p" items="${productList}">
                        <option value="${p.itemCode}">${p.itemCode} - ${p.itemName}</option>
                    </c:forEach>
                </select>
            </div>

            <div id="processContainer">
                <!-- ✅ 첫 공정 블록 -->
                <div class="process-block" data-step="1">
                    <h4>공정 1</h4>

                    <div class="form-row">
                        <label>공정순서</label>
                        <input type="number" name="operationSeq" value="1" readonly />
                    </div>

                    <div class="form-row">
                        <label>공정코드</label>
                        <input type="text" name="operationCode" class="op-code" readonly placeholder="자동 생성" />
                    </div>

                    <div class="form-row">
                        <label>공정명</label>
                        <input type="text" name="operationName" placeholder="예: 혼합" required />
                    </div>

                    <div class="form-row">
                        <label>공정내용</label>
                        <textarea name="operationDesc" rows="3" placeholder="예: 재료 혼합 비율 1:2로 설정"></textarea>
                    </div>

                    <div class="form-row">
                        <label>원자재</label>
                        <div class="material-container">
                            <div class="material-row">
                                <select name="materialCode_1" class="material-select" required>
                                    <option value="">-- 원자재 선택 --</option>
                                    <c:forEach var="m" items="${materialList}">
                                        <option value="${m.itemCode}">${m.itemCode} - ${m.itemName}</option>
                                    </c:forEach>
                                </select>
                                <button type="button" class="btn btn-sm btn-outline add-material">+ 추가</button>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">
                        <label>표준시간(분)</label>
                        <input type="number" name="standardTime" min="1" required placeholder="예: 30" />
                    </div>
                </div>
            </div>

            <div class="actions">
                <button type="button" id="addProcess" class="btn btn-outline">+ 공정 추가</button>
                <button type="submit" class="btn btn-primary">등록 완료</button>
            </div>

        </form>
    </div>
</div>

<!-- ✅ 숨겨진 원자재 select 템플릿 -->
<select id="materialTemplate" style="display:none;">
    <option value="">-- 원자재 선택 --</option>
    <c:forEach var="m" items="${materialList}">
        <option value="${m.itemCode}">${m.itemCode} - ${m.itemName}</option>
    </c:forEach>
</select>

<script>
let step = 1;
const materialOptions = $("#materialTemplate").html();

// ✅ 공정 코드 자동 채번
function loadOperationCode(inputField) {
    $.ajax({
        url: "${pageContext.request.contextPath}/processRouting2/nextOperationCode",
        type: "GET",
        success: function(code) {
            inputField.val(code);
        },
        error: function() {
            inputField.val("ERR");
        }
    });
}

// 첫번째 공정코드 자동 로드
loadOperationCode($(".op-code:first"));

// ✅ 공정 추가 버튼
$("#addProcess").click(function() {
    if (step >= 10) {
        alert("공정은 최대 10단계까지만 등록 가능합니다.");
        return;
    }
    step++;

    const newBlock = `
        <div class="process-block" data-step="${step}">
            <h4>공정 ${step}</h4>

            <div class="form-row">
                <label>공정순서</label>
                <input type="number" name="operationSeq" value="${step}" readonly />
            </div>

            <div class="form-row">
                <label>공정코드</label>
                <input type="text" name="operationCode" class="op-code" readonly placeholder="자동 생성" />
            </div>

            <div class="form-row">
                <label>공정명</label>
                <input type="text" name="operationName" placeholder="예: 조립" required />
            </div>

            <div class="form-row">
                <label>공정내용</label>
                <textarea name="operationDesc" rows="3" placeholder="예: 혼합 완료 후 10분간 숙성"></textarea>
            </div>

            <div class="form-row">
                <label>원자재</label>
                <div class="material-container">
                    <div class="material-row">
                        <select name="materialCode_${step}" class="material-select" required>
                            ${materialOptions}
                        </select>
                        <button type="button" class="btn btn-sm btn-outline add-material">+ 추가</button>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <label>표준시간(분)</label>
                <input type="number" name="standardTime" min="1" required placeholder="예: 20" />
            </div>
        </div>`;
    
    $("#processContainer").append(newBlock);
    loadOperationCode($(`#processContainer .process-block:last .op-code`)); // 새 공정에 코드 자동발급
});

// ✅ 원자재 추가 버튼
$(document).on('click', '.add-material', function() {
    const step = $(this).closest('.process-block').data('step');
    const container = $(this).closest('.material-container');
    const newRow = `
        <div class="material-row">
            <select name="materialCode_${step}" class="material-select" required>
                ${materialOptions}
            </select>
            <button type="button" class="btn btn-sm btn-danger remove-material">삭제</button>
        </div>`;
    container.append(newRow);
});

// ✅ 원자재 삭제
$(document).on('click', '.remove-material', function() {
    $(this).closest('.material-row').remove();
});
</script>

<style>
.content { margin-left: 220px; margin-top: 80px; padding: 20px; min-height: 85vh; background: #f5f6fa; }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.form-card { background: #fff; border: 1px solid #e9ecef; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.06); }
.form-group, .form-row { margin-bottom: 12px; display: flex; flex-direction: column; }
.form-group label, .form-row label { font-weight: 600; margin-bottom: 4px; }
input, select, textarea { padding: 8px; border: 1px solid #ced4da; border-radius: 6px; resize: none; }
.process-block { border-left: 5px solid #0b5ed7; padding: 12px 16px; margin-bottom: 16px; background: #f8f9fa; border-radius: 6px; }
.btn { padding: 6px 10px; border-radius: 6px; font-weight: 600; cursor: pointer; border: none; }
.btn-primary { background-color: #2c3e50; color: #fff; }
.btn-outline { background-color: #fff; border: 1px solid #2c3e50; color: #2c3e50; }
.btn-secondary { background-color: #6c757d; color: #fff; }
.btn-danger { background-color: #dc3545; color: #fff; border: none; }
.actions { display: flex; gap: 10px; margin-top: 20px; }
.material-row { display: flex; align-items: center; gap: 8px; margin-bottom: 6px; }
.material-select { flex: 1; }
</style>

</body>
</html>

