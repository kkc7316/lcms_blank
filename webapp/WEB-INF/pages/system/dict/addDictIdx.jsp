<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/layout.css" />
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link type="text/css" rel="stylesheet" href="zTree/zTreeStyle.css" />
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/selectyze/selectyze.jquery.min.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="js/validity/jquery.validity.js"></script>
<link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
<script type="text/javascript">
	$(function() {
		/* 关闭页面及修改弹窗高度的方法 */
	            $('.close_chuan').click(function(){
	                $(window.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
	                $(window.parent.document).find("#dictIdx_kcpd").attr("src","about:blank");
	            })
             	$(window.parent.document).find("#dictIdx_kcpd").css("height",$(".main_right").height()+ 20 );
		$("#dictIdxform").validity(function() {
				$("#dictName")
				.require("不能为空");
				$("#dictKey")
				.require("不能为空");
		});
	});	
	
	function addSubmit() {
		$("#dictIdxform").submit();
		if ($(".validity-tooltip").length==0){
			$("#addSubmitBtn").attr("disabled","disabled");
			$("#addSubmitBtn").addClass('btn_active');	
		}
	}
	
	
	function getKey(){
	 	if(event.keyCode==13){
	 		$("#addSubmitBtn").click();
	 	}
	}
	
</script>
</head>
<body>
<iframe name="hiddenIframe" style="display:none;"></iframe>
<div class="main_right">
	<!---->
	<form target="hiddenIframe" action="saveOrUpdateDictIdx.do" method="post" name="dictIdxform" id="dictIdxform" target="hiddenIframe">
	<input type="hidden"  name="token" value="${token}">
    <div class="lbtable1 lbtable1_tan">
         	<div class="biaoti_title biaoti_title_tan">
         		<span>新增</span>
         	</div>
         	<div class="lbtable1_content lbtable1_content_tan">
            <ul class="ul_form">
                <li>
                    <span class="span_form_label"><font class="xh">*</font><spring:message code="DICT_NAME_LAB"></spring:message>：</span>
                    <div class="div_form_content"><input class="file_fixed_150px" name="dictName" id="dictName"/></div>
                </li>
                <li>
                    <span class="span_form_label"><font class="xh">*</font><spring:message code="DICT_CODE_LAB"></spring:message>：</span>
                    <div class="div_form_content"><input class="file_fixed_150px" name="dictKey" id="dictKey"/></div>
               </li>
                <li style="width: 100%;">
                    <span class="span_form_label"><spring:message code="DICT_DES_LAB"></spring:message>：</span>
                    <div class="div_form_content div_form_content2"><textarea class="div_text" name="remark"></textarea></div>                 
                </li>
                <div style="clear:both;"></div>
           </ul>
           </div>     
               <div class="srnr" style="text-align:center;">
                    <button id="addSubmitBtn" class="button2" type="button"  onclick="addSubmit()"><spring:message code="SUBMIT_OPT"></spring:message></button> 
                    <a  class="button3 close_chuan" type="button" ><spring:message code="CANCEL"></spring:message></a>
                </div>
        </div>
        </div>
   </form>
</div>
</body>
</html>
