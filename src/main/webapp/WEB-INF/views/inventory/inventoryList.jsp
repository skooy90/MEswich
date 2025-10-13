<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Inventory List</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
        }

        .main-content {
            margin-left: 200px; /* 사이드바 공간 확보 */
            padding: 100px 30px 30px; /* 헤더 높이 + 내부 여백 */
            min-height: 100vh;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        th {
            background-color: #2c3e50;
            color: white;
        }

        h2 {
            margin-top: 0;
            color: #2c3e50;
        }
    </style>
</head>

<body>
    <%@ include file="../basic/header.jsp" %>
    <%@ include file="../basic/sidebar.jsp" %>

    <main class="main-content">
        <h2>Inventory2 목록</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Item Code</th>
                <th>Lot Number</th>
                <th>Quantity</th>
                <th>Location</th>
            </tr>
            <c:forEach var="row" items="${list}">
                <tr>
                    <td>${row.inventoryId}</td>
                    <td>${row.itemCode}</td>
                    <td>${row.lotNumber}</td>
                    <td>${row.currentQty}</td>
                    <td>${row.location}</td>
                </tr>
            </c:forEach>
        </table>
    </main>
</body>
</html>
