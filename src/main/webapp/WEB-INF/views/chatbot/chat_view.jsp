<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEswich AI 챗봇</title>
</head>
<body>
    <h2>MEswich 챗봇</h2>
    <textarea id="question" rows="3" cols="50" placeholder="질문을 입력하세요"></textarea><br>
    <button onclick="sendQuestion()">질문하기</button>
    <h3>응답:</h3>
    <div id="response" style="white-space: pre-wrap; background:#f4f4f4; padding:10px;"></div>

    <!-- ✅ JSP에서 미리 URL 생성 -->
    <c:url var="chatUrl" value="/chatbot/ask"/>

<script>
function sendQuestion() {
    const q = document.getElementById("question").value;

    // ✅ JSP에서 만든 변수 chatUrl 사용
    const url = "${chatUrl}";

    fetch(url, {
        method: "POST",
        headers: {"Content-Type": "application/json"},
        body: JSON.stringify({question: q})
    })
    .then(res => {
        if (!res.ok) throw new Error(`HTTP Error! Status: ${res.status}`);
        return res.json();
    })
    .then(data => {
        document.getElementById("response").innerText = data.answer;
    })
    .catch(error => {
        document.getElementById("response").innerText = `❌ 오류 발생: ${error.message}`;
        console.error('Fetch Error:', error);
    });
}
</script>
</body>
</html>

