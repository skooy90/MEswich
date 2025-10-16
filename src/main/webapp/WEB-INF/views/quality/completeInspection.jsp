<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검사 완료</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-container { max-width: 500px; margin: 0 auto; }
        .form-group { margin: 15px 0; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { padding: 10px 20px; margin: 5px; border: none; border-radius: 4px; cursor: pointer; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-secondary { background-color: #6c757d; color: white; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>🔍 검사 완료</h2>
    
    <c:if test="${not empty quality}">
        <div class="form-group">
            <label>검사번호:</label>
            <input type="text" value="${quality.inspectionNo}" readonly>
        </div>
        
        <div class="form-group">
            <label>제품명:</label>
            <input type="text" value="${quality.productName}" readonly>
        </div>
        
        <form method="post" action="/mes/quality/completeInspection">
            <input type="hidden" name="inspectionNo" value="${quality.inspectionNo}">
            
            <div class="form-group">
                <label for="goodQty">완품수량 *</label>
                <input type="number" id="goodQty" name="goodQty" required min="0">
            </div>
            
            <div class="form-group">
                <label for="defectQty">불량수량 *</label>
                <input type="number" id="defectQty" name="defectQty" required min="0" value="0">
            </div>
            
            <div class="form-group">
                <label for="defectReason">불량사유</label>
                <textarea id="defectReason" name="defectReason" rows="3" placeholder="불량이 있는 경우 사유를 입력하세요"></textarea>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">검사 완료</button>
                <a href="/mes/quality" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </c:if>
</div>

</body>
</html>
