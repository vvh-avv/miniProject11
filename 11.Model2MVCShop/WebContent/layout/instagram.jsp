<%@ page language="java" contentType="text/html; charset=EUC-KR"  pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<script type="text/javascript" src="/javascript/instafeed.min.js"></script>
	
	<script>
		//popWin = window.open( "https://api.instagram.com/oauth/authorize/?client_id=be13cdcb5b6d42f9b06fd01ef6bb7c56&redirect_uri=http://localhost:8080&response_type=token",
		//								"popWin", "width=500,height=500,scrollbars=no,scrolling=no,resizable=no");
		//accessToken = 6200182633.be13cdc.39a95ed82d8348f59c320394d67f005c;
		var userFeed = new Instafeed({
		    get: 'user',
		    userId: 6200182633, //accessToken 의 앞자리
		    sortBy: "most-recent",
		    limit: 5,
		    template: '<a href="{{link}}" target="_blank"><img src="{{image}}" /></a>&nbsp;', 
		    // {{link}} : 게시물 링크, {{image}} : 사진 url, {{caption}} : 게시물 텍스트
		    accessToken: '6200182633.be13cdc.39a95ed82d8348f59c320394d67f005c'
		});
		userFeed.run();
	</script>
</head>

<body>
	<div id="instagram" align="center">
		<img src="/images/sns/instagram.PNG" width="30" height="30"> @vvh_avv
	<div id="instafeed"></div>
	</div>
</body>

</html>