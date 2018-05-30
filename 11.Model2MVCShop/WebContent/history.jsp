<%@ page contentType="text/html; charset=EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<title>최근 본 상품</title>
</head>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<style>
	body{
		position: fixed;
		z-index: 999;
	}
</style>


<body>
	<br><br>
	<h4>최근 본 상품</h4>
	<br><br>
	<%
		String history = null;
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			if (history != null) {
				String[] h = history.split(",");
				for (int i = 0; i < h.length; i++) {
					if (!h[i].equals("null")) {
	%>
		<script>
			$.ajax({
				url : "/product/json/getProduct/"+<%=h[i]%>,
				success : function(Data){
					$("#historyProdName"+<%=h[i]%>).text(Data.prodName);
					if(Data.fileName==null){
						$("#historyImg"+<%=h[i]%>).attr("src","http://placehold.it/100X100");
					}else{
						$("#historyImg"+<%=h[i]%>).attr("src","/images/uploadFiles/"+Data.fileName);
					}
				}
			})
		</script>
		<div id="historyProdName<%=h[i]%>"></div>
		<a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search">
			<img src="" height="100" width="100" id="historyImg<%=h[i]%>">
		</a><br>
	<%
					}
				}
			}
		}
	%>
<!-- ${cookie.history.value} -->
<!-- ${cookie.JSESSIONID.value} -->

</body>
</html>