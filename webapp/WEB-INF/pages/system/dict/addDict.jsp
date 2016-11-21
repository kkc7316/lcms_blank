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
<style>
#remarkrequire{
	width:590px;
	height:60px;
	left:139px!important;
}
</style>
</head>
<body style="background-color: rgb(249,249,249);">
	<iframe name="hiddenIframe" style="display:none;"></iframe>
    <div class="main_right">
	    <form id="myForm" name="myForm">
	    <div class="lbtable1 lbtable1_tan">
	        <div class="biaoti_title biaoti_title_tan">
	        	<span>新增</span>
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
					<li><span class="span_form_label"><font class="xh">*</font>字典Key：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="dictKey" name="dictKey"/>
						</div>
					</li>
					<li><span class="span_form_label"><font class="xh">*</font>字典值：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="dictValue" name="dictValue"/>
						</div>
					</li>
					<li><span class="span_form_label"><font class="xh">*</font>排序：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="orderNum" name="orderNum"/>
						</div>
					</li>
	             	<li style="width: 100%;"><span class="span_form_label"><font class="xh"></font>字典描述：</span>
						<div class="div_form_content div_form_content2">
							<textarea class="div_text" style="width: 605px;" id="remark" name="remark"></textarea>
						</div>
					</li>
					<div style="clear: both"></div>
				</ul>
				</div>
				<input type="hidden" name="token" value="${token}"/>
	            <div class="tan_table_btn">
					 <button class="button2 btn_save3" type="button" id="submit_btn" onclick="validationSubmit()"><spring:message code="SUBMIT_OPT"></spring:message></button>
	                 <a class="button3 close_chuan" type="button"><spring:message code="CANCEL"></spring:message></a>
	            </div>
	     	</div>
	     </form>
     </div>
 
<script type="text/javascript">    
//刷新函数
function refresh(){
	store.load();
}

function clear_submit_div(){
    $('.btn_save3').removeClass('btn_active');
    $(".btn_save3").removeAttr("disabled");
    document.getElementById("dictKey").value ='';
    document.getElementById("dictValue").value ='';
    document.getElementById("orderNum").value ='';
    document.getElementById("remark").value ='';
} 
       //表单验证
function validationSubmit(){
	var dictKey = document.getElementById("dictKey").value;
    var dictValue =  document.getElementById("dictValue").value;
    var orderNum = document.getElementById("orderNum").value;
    var remark = document.getElementById("remark").value;
    
    $(".validity-tooltip").remove();
    $("#dictKey").require("不能为空");
	$("#dictValue").require("不能为空");
	$("#orderNum").require("不能为空").assert(validationNum(orderNum), "必须为数字");
	$("#remark").assert(validationRemark(remark), "描述不能超过2000个字符");
    if ($(".validity-tooltip").length!=0) {
    	return false;
    }
	/* if(dictKey=="" || dictKey==undefined || dictKey==null) {
		showMsg("字典代码不能为空");
	} else if(dictValue=="" || dictValue==undefined || dictValue==null){
		showMsg("字典显示值不能为空");
	}else if(orderNum=="" || orderNum==undefined || orderNum==null) {
		showMsg("排序不能为空");
	} else if(validationNum(orderNum)){
	  	showMsg("排序类型不匹配，请输入数字"); */
	else{
		$(".btn_save3").attr("disabled","disabled");  // 不能点击的按钮变灰
		$(".btn_save3").addClass('btn_active');
	//此时验证字典代码是否重复
	    $.ajax({
			type: "POST",
			url: "dictValidation.do", 
			data: {'key':dictKey,'dictValue':dictValue},
			success:function(data){
				if(data.msg == 'true') {
					submitForm();
					clear_submit_div();
				}else {
					showMsg2(data.msg);
					$(".btn_save3").removeAttr("disabled","disabled");  // 不能点击的按钮变灰
					$(".btn_save3").removeClass('btn_active');
				}
			}
		});
	} 
}

function validationNum(val){
   var reg = new RegExp("^[0-9]*$");
   return reg.test(val);
   /* if(!reg.test(val)){
       return true;
   }
   return false; */
}
function validationRemark(val){
	if(val.length>2000){
		return false;
	}
	return true;
}
function submitForm(){
	$.ajax({
		type: "POST",
		url: "saveOrUpdateDict.do", 
		data: $('#myForm').serialize(),
		success:function(data){
			if(data.success){
				showMsg("保存成功");
		    	$(window.parent.document).find('#add_ifa,#bgDiv').css('display','block');
		    	$(window.parent.document).find('#dictIdx_kcpd').attr('src',"<%=path%>/detailDictIdx.do?dictKey="+ parentKey);
			}else{
				showMsg2("保存失败");
			}
		} 
	});
}

function clearWord3(){ 
	setTimeout(function(){
		$('#submit_btn').removeClass('btn_active');
		$("#submit_btn").removeAttr("disabled");
	},2000)
}
</script>       
</body>
</html>
