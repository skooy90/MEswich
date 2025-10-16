<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<div class="container">
		<table>
			<thead>
				<tr>
					<th>LOT번호</th>
					<th>제품코드</th>
					<th>제품명</th>
					<th>계획수량</th>
					<th>실제수량</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="produc" items="${list}">
					<tr>
						<td>${produc.lotNumber}</td>
						<td>${produc.productCode}</td>
						<td>${produc.productName}</td>
						<td>${produc.plannedQty}</td>
						<td>${produc.actualQty}</td>
						<td>${produc.status}</td>
					</tr>
					</c:forEach>
			</tbody>

		</table>
	</div>

</body>
</html>