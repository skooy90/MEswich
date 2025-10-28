<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/WEB-INF/views/basic/header.jsp" />
<jsp:include page="/WEB-INF/views/basic/sidebar.jsp" />

<div class="content">
    <h2>공정 등록</h2>

    <div class="actions">
        <button type="button" id="addCardBtn" class="btn-add">+ 공정 카드 추가</button>
    </div>

    <form action="#" method="post" id="routingForm" class="card-form">
        <div id="cardContainer">
            <!-- 첫 번째 카드 -->
            <div class="card process-card">
                <div class="card-header">
                    <h3>공정 #1</h3>
                    <button type="button" class="btn-remove" onclick="removeCard(this)">×</button>
                </div>
                <div class="card-body">
                    <label>제품 코드</label>
                    <input type="text" name="productCode" placeholder="예: FG0002" />

                    <label>공정 순서</label>
                    <input type="number" name="operationSeq" />

                    <label>공정 코드</label>
                    <input type="text" name="operationCode" />

                    <label>공정명</label>
                    <input type="text" name="operationName" />

                    <label>표준 시간</label>
                    <input type="number" name="standardTime" />

                    <label>공정 설명</label>
                    <textarea name="operationDesc"></textarea>

                    <label>등록자</label>
                    <input type="text" name="createdBy" value="admin" readonly />
                </div>
            </div>
        </div>

        <div class="actions-bottom">
            <button type="button" class="btn-submit" onclick="submitDemo()">등록</button>
            <a href="/mes/processRouting2/list" class="btn-cancel">취소</a>
        </div>
    </form>
</div>

<style>
.content {
    margin-left: 220px;
    padding: 30px;
    background: #fff;
    min-height: 100vh;
}

h2 {
    text-align: center;
    margin-bottom: 20px;
}

.actions {
    text-align: right;
    margin-bottom: 20px;
}

.btn-add {
    background-color: #2c3e50;
    color: #fff;
    padding: 10px 14px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}
.btn-add:hover { background-color: #34495e; }

.card-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.card {
    width: 600px;
    background: #fafafa;
    margin: 0 auto 20px;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    position: relative;
    transition: transform 0.2s ease;
}
.card:hover { transform: translateY(-4px); }

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}
.card-header h3 { margin: 0; }
.btn-remove {
    background: #e74c3c;
    border: none;
    color: white;
    font-weight: bold;
    width: 28px;
    height: 28px;
    border-radius: 50%;
    cursor: pointer;
}
.btn-remove:hover { background: #c0392b; }

.card label {
    display: block;
    margin-top: 8px;
    font-weight: bold;
}

.card input, .card textarea {
    width: 100%;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.actions-bottom {
    text-align: center;
    margin-top: 20px;
}

.btn-submit {
    background-color: #3498db;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}
.btn-submit:hover { background-color: #2980b9; }

.btn-cancel {
    margin-left: 10px;
    text-decoration: none;
    color: #333;
    font-weight: bold;
}
</style>

<script>
// 카드 추가
document.getElementById("addCardBtn").addEventListener("click", function() {
    const container = document.getElementById("cardContainer");
    const cardCount = container.querySelectorAll(".process-card").length + 1;

    const newCard = document.createElement("div");
    newCard.classList.add("card", "process-card");
    newCard.innerHTML = `
        <div class="card-header">
            <h3>공정 #${cardCount}</h3>
            <button type="button" class="btn-remove" onclick="removeCard(this)">×</button>
        </div>
        <div class="card-body">
            <label>제품 코드</label>
            <input type="text" name="productCode" placeholder="예: FG0002" />
            <label>공정 순서</label>
            <input type="number" name="operationSeq" />
            <label>공정 코드</label>
            <input type="text" name="operationCode" />
            <label>공정명</label>
            <input type="text" name="operationName" />
            <label>표준 시간</label>
            <input type="number" name="standardTime" />
            <label>공정 설명</label>
            <textarea name="operationDesc"></textarea>
            <label>등록자</label>
            <input type="text" name="createdBy" value="admin" readonly />
        </div>`;
    container.appendChild(newCard);
});

// 카드 삭제
function removeCard(btn) {
    const card = btn.closest(".process-card");
    card.remove();
}

// 시연용 등록 버튼
function submitDemo() {

}
</script>
