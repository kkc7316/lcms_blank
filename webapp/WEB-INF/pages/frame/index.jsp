<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<link rel="icon" href="image/favicon.ico">
<title><spring:message code="GLOBAL_TITLE"></spring:message></title>
<script>

	function clearRAM() {

		var frame = document.getElementById("ifr_content");
		frame.src = 'about:blank';
		frame.contentWindow.document.write('');//清空frame的内容
		frame.contentWindow.document.clear();
		frame.contentWindow.close();//避免frame内存泄漏

		if (navigator.userAgent.indexOf('MSIE') >= 0) {
			if (CollectGarbage) {

				CollectGarbage(); //IE 特有 释放内存

				//删除原有标记
				var tags = document.getElementById("ifrSet");
				tags.removeChild(frame);

				//添加frameset框架
				var _frame = document.createElement('frame');
				_frame.src = '';
				_frame.name = 'content';
				_frame.id = 'ifr_content';
				tags.appendChild(_frame);

			}
		}

	}

	//主动释放 5秒一次
	setInterval(function() {
		if (navigator.userAgent.indexOf('MSIE') >= 0) {
			if (CollectGarbage) {
				//alert(1)
				CollectGarbage(); //IE 特有 释放内存
			}
		}
	}, 5000)
</script>
</head>
<frameset id="index-frame" rows="75,*,25"  scrolling="auto"  frameborder="0" framespacing="0">
    <frame id="top-frame" src="head.do" scrolling="no">
    <frameset cols="210px,*" id="ifrSet" scrolling="auto">
      <frame src="navigation.do" id="nav">
      <frame src="content.do" name="content" id="ifr_content" scrolling="auto">
    </frameset>
    <frame src="bottom.do" scrolling="0"></frame>
</frameset><noframes></noframes>
<body></body>
</html> 

