<%@ page contentType="text/html; charset=EUC-KR"%>

<html>
<head>
<title>��� ��ǰ ����</title>
</head>

<body>
����� ��� ��ǰ�� �˰� �ִ�
<br>
<br>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	
	String history = null;
	
	Cookie[] cookies = request.getCookies();
	
	if (cookies!=null && cookies.length > 0) {
		//System.out.println("==============================");
		//System.out.println("1 ��Ű�� �����մϴ�");
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			//System.out.println("2 ���Ű�� �ֳ���? "+cookie.getName()+"�� "+cookie.getValue()+"���� �ֳ׿�!" );
			if (cookie.getName().equals("history")) {
				//System.out.println("3 �����丮 ��Ű�� �����ϳ׿�! "+cookie.getValue());
				history = cookie.getValue();
			}
		}
		if (history != null) {
			//System.out.println("4 ���� �����丮�� null�� �ƴմϴ�");
			String[] h = history.split(",");
			for (int i = 0; i < h.length; i++) {
				if (!h[i].equals("null")) {
					//System.out.println("5 �ɰ� �����丮�� ���� �� null�� �ƴѰ� �ֽ��ϴ�. ����ҰԿ�~");
%>
	<a href="/product/getProduct?prodNo=<%=h[i]%>&menu=search" target="rightFrame"><%=h[i]%></a>
	<br>
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