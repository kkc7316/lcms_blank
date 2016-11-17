<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/layout.css" />
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link rel="stylesheet" href="selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="selectyze/selectyze.jquery.min.js"></script>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/ext-theme-classic-all.css" />
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/all2.css" />
<script type="text/javascript" src="js/validity/jquery.validity.js"></script>
<link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
<script type="text/javascript">
var parentKey = "${parentKey}";
	$(function() {
		/* 关闭页面及修改弹窗高度的方法 */
	            $('.close_chuan').click(function(){
	                $(window.parent.document).find('#add_ifa,#bgDiv').css('display','block');
		    		$(window.parent.document).find('#dictIdx_kcpd').attr('src',"<%=path%>/detailDictIdx.do?dictKey="+ parentKey);
	            })
    	$(window.parent.document).find("#dictIdx_kcpd").css("height",$(".main_right").height()+ 20 );
	});	
</script>
</head>
<body style="background-color: rgb(249,249,249);">
	<iframe name="hiddenIframe" style="display:none;"></iframe>
    <div class="main_right">
	    <form id="myForm" name="myForm">
	    <div class="lbtable1 lbtable1_tan">
	        <div class="biaoti_title biaoti_title_tan">
	        	<span>编辑</span>
	        </div>
	        <div class="lbtable1_content lbtable1_content_tan">
					<ul class="ul_form">
						<li>
		                    <span class="span_form_label"><font class="xh"></font>字典名称：</span>
		                    <div class="div_form_content">
		                       <span class="div_form_content_span">${model.dictName}</span>
		                </li>
		                <li>
		                    <span class="span_form_label"><font class="xh"></font>字典代码：</span>
		                    <div class="div_form_content">
		                       <span class="div_form_content_span">${model.dictKey}</span>
		                </li>
					</ul>
	        		<div style="clear: both;"></div>
			</div>
				<div class="tan_table">
	            <ul class="ul_form_col3" style="">
					<li><span class="span_form_label"><font class="xh">*</font>字典代码：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="dictKey" name="dictKey" value="${dict.dictKey}" disabled="true" readonly="true"/>
						</div>
					</li>
					<li><span class="span_form_label"><font class="xh">*</font>字典显示值：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="dictValue" name="dictValue" value="${dict.dictValue}"/>
						</div>
					</li>
					<li><span class="span_form_label"><font class="xh">*</font>排序：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="orderNum" name="orderNum" value="${dict.orderNum}"/>
						</div>
					</li>
	             	<li style="width: 100%;"><span class="span_form_label"><font class="xh"></font>字典描述：</span>
						<div class="div_form_content div_form_content2">
							<textarea class="div_text" style="width: 605px;" id="remark" name="remark">${dict.remark}</textarea>
						</div>
					</li>
					<input class="file_fixed_150px" id="id" name="id" value="${dict.id}" type="hidden"/>
					<div style="clear: both"></div>
				</ul>
				</div>
	            <div class="tan_table_btn">
					 <button class="button2 btn_save3" type="button" id="submit_btn" onclick="validationSubmit()"><spring:message code="SUBMIT_OPT"></spring:message></button>
	                 <a class="button3 close_chuan" type="button"><spring:message code="CANCEL"></spring:message></a>
	            </div>
	     	</div>
	     </form>
     </div>
 
<script type="text/javascript">    
//表单验证
function validationSubmit(){
    var dictValue =  document.getElementById("dictValue").value;
    var orderNum = document.getElementById("orderNum").value;
	/* if(dictValue=="" || dictValue==undefined || dictValue==null){
		showMsg("字典显示值不能为空");
		return;
	}else if(orderNum=="" || orderNum==undefined || orderNum==null) {
		showMsg("排序不能为空");
		return;
	} else if(validationNum(orderNum)){
	  	showMsg("排序类型不匹配，请输入数字");
	  	return;
	} */
	$(".validity-tooltip").remove();
    $("#dictKey").require("不能为空");
	$("#dictValue").require("不能为空");
	$("#orderNum").require("不能为空").assert(validationNum(orderNum), "必须为数字");
    if ($(".validity-tooltip").length!=0) {
    	return false;
    }
    $(".btn_save3").attr("disabled","disabled");
    $(".btn_save3").addClass('btn_active');
	submitForm();
}

function validationNum(val){
   var reg = new RegExp("^[0-9]*$");
   /* if(!reg.test(val)){
       return true;
   } */
   return reg.test(val);
}
function submitForm(){
	$.ajax({
		type: "POST",
		url: "saveOrUpdateDict.do", 
		data: $('#myForm').serialize(),
		success:function(data){
			if (data.success){
				showMsg("保存成功");
				$(window.parent.document).find('#add_ifa,#bgDiv').css('display','block');
		    	$(window.parent.document).find('#dictIdx_kcpd').attr('src',"<%=path%>/detailDictIdx.do?dictKey="+ parentKey);
			}else{
				showMsg2("保存失败");
				$(".btn_save3").removeClass('btn_active');
				$(".btn_save3").removeAttr("disabled");
			}
		} ,
		error:function(data) {
			showMsg2("保存失败");
			$(".btn_save3").removeClass('btn_active');
			$(".btn_save3").removeAttr("disabled");
		}
	});
}

function clearWord3(){ 
	setTimeout(function(){
		$('#submit_btn').removeClass('btn_active');
		$("#submit_btn").removeAttr("disabled");
	},2000)
}

function getKey()  
{  
   if(event.keyCode==13){ 
	  $("#submit_btn").click(); 
	}     
}  
</script>       
</body>
</html>
