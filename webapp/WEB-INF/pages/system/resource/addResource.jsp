<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath%>"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
	<link type="text/css" rel="stylesheet" href="css/style.css" />
	<link type="text/css" rel="stylesheet" href="css/global.css" />
	<link type="text/css" rel="stylesheet" href="css/layout.css" />

	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script language="javascript" type="text/javascript" src="js/jquery-ui-1.9.2.custom.min.js"></script>
	<script type="text/javascript" src="js/selectyze/selectyze.jquery.min.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
	<script type="text/javascript" src="js/validity/jquery.validity.js"></script>
    <link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
    	
    <script type="text/javascript" src="js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.excheck-3.5.js"></script>
    <link type="text/css" rel="stylesheet" href="zTree/zTreeStyle.css" />
    
   
 </head>
<body style="background: rgb(249,249,249)">
<iframe name="hiddenIframe" style="display:none;"></iframe>
<!-- main s -->
<div class="main_right" id="resourcesAddOrUpdateFormId">
    <!-- lb1 s-->
    <div class="lbtable1 lbtable1_tan">
    <!-- form s -->
    <form name="resourceAddForm" id="resourceAddForm"  method="post" action="resource/doAddResource.do" target="hiddenIframe">
    <input type="hidden" name="token" value="${token}"/>
        <input type="hidden" id="hidden_id" value="${resource.id}" name="id"/>
        <input type="hidden" id="hidden_delFlag" value="${resource.delFlag}" name="delFlag"/>
        <input type="hidden" id="parentId" value="${resource.parentResource.id}" name="parentId"/>
        <input type="hidden" id="hidden_remark" value="${resource.remark}" name="hidden_remark"/>
        
        
        <div class="biaoti_title biaoti_title_tan">
           	<span>
           		<c:if test="${empty resource.id}">新增</c:if>
				<c:if test="${not empty resource.id}">修改</c:if>
			</span>
        </div>
        <div class="lbtable1_content lbtable1_content_tan" style="margin-top: 10px;">
           	<ul class="ul_form">
           			<li><span class="span_form_label"><font class="xh">*</font>资源名称：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="resourceName" name="resourceName"
								value="${resource.resourceName}" maxlength="20" />
						</div>
					</li>
					<li><span class="span_form_label"><font class="xh">*</font>资源代码：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="resourceCode" name="resourceCode"
								value="${resource.resourceCode}" maxlength="20"/>
						</div>
					</li>
					<li style="position: relative;"><span class="span_form_label"><font class="xh">*</font>父资源：</span>
						<div class="div_form_content">
							<input class="file_fixed_150px" id="parentName" name="parentSourceName"
							value="${resource.parentResource.resourceName}" readOnly="true"/>
							
						</div>
						<button  class="choose" onclick="showMenu()" type="button"></button>
						<!-- zTree hidden -->
						<div class="choose_content_div">
		                    <ul id="tree" class="ztree"></ul>
	                    </div>
					</li>
				
					<li><span class="span_form_label"><font class="xh">*</font>资源类别：</span>
						<div class="div_form_content">
<%--							<label><input name="resourceType" type="radio" value="0" <c:if test="${resource.resourceType == '0'}">checked="checked"</c:if> />权限</label> --%>
<%--							<label><input name="resourceType" type="radio" value="1" <c:if test="${resource.resourceType == '1'}">checked="checked"</c:if> />菜单</label>--%>
<%--							 <label><input name="Fruit" type="radio" value="" />权限1</label> --%>
<%--                            <label><input name="Fruit" type="radio" value="" />菜单1</label>--%>
						<!-- js默认选中 -->
						<c:forEach items="${resourceTypeMap}" var = "map">
							<input type="radio" name="resourceType" value="${map.dictKey}" />${map.dictValue}
						</c:forEach>
						
						</div>
					</li>
					
       		 	 	<li style="width: 100%"><span class="span_form_label">备注：</span>
                        <div class="div_form_content" style="width: 470px; height: auto;">
                            <textarea style="width: 475px; height: 80px;" 
                            	id="remark" name="remark" maxlength="200"></textarea>
                        </div>
                    </li>
					<div style="clear:both;"></div>
				</ul>
			<div class="srnr box_btn"  style="text-align:center; margin-top: 10px;">
                 <button  class="button2" type="submit" id="submit_role_btn" ><spring:message code="SUBMIT_OPT"></spring:message></button>
                 <a  class="button3 close_chuan" onclick="close_chuan()"><spring:message code="CANCEL"></spring:message></a>
            </div>
        </div>
    </form>
    <!-- form e -->
    </div>
    <!-- lb1 e-->
</div>
<!-- main e -->

<div id="bgDiv"></div>
<script type="text/javascript">

	$(function(){
		
		$(window.parent.document).find("#relay").css("height",$(".main_right").height()+ 20 )
		$(window.parent.document).find("#add_ifa").css("height",$(".main_right").height() + 20);
		
		/* 验证空 */
		$("#resourceAddForm").validity(function() {
			debug:true;
			$("#resourceName").require("不能为空");
			$("#resourceCode").require("不能为空");
			$("#parentName").require("不能为空");
		});
		
	})
	
	function initRadio(rName,rValue){
        var rObj = document.getElementsByName(rName);

        for(var i = 0;i < rObj.length;i++){
            if(rObj[i].value == rValue){
                rObj[i].checked =  'checked';
            }
        }
    }
	
	function close_chuan() {
        $(window.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
        $(window.parent.document).find("#relay").attr("src","about:blank");
    }
    function showMenu(){
    	// $(window.parent.document).find("#add_ifa").css("display",'none')
    	// $(window.parent.document).find('#update_ifa').css('display','block');
    	// $(window.parent.document).find('#relay2').attr('src','source_add_v1.html')
    	$('.choose_content_div').css('display','block');
	}
	
    //zTree加载
    var zTree;
	var setting = {
		view: {
			selectedMulti: false,
			expandSpeed: ""
		},
		check: {
			enable: false
		},
		//异步加载
		async: {
			enable: true,//设置是否异步加载
			dataType: "json",//设置预期服务器返回的数据类型
			url:"<%=path%>/resource/getAllResourcesList.do",//设置异步获取节点的 URL 地址
			//otherParam: [ "parentId", '${resource.id}']//总是一个所有列表
			
		},
		data: {
			simpleData: {
				enable: true,
				pIdKey: "PARENTID",
				idKey: "ID"
			},
			key: {
				id:"ID",
				title:"RESOURCENAME",
				name:"RESOURCENAME"
			}
		},
		callback: {
			//回调
			beforeClick: beforeClick,
			onClick: onClick
		}
	};
	
	function beforeClick(treeId, treeNode, clickFlag) {
		//alert(treeNode.name);
		return (treeNode.click != false);
	}
		
	function onClick(e, treeId, treeNode,clickFlag) {
		
		//为父资源赋值
		$("#parentName").val(treeNode.RESOURCENAME);
		$("#parentId").val(treeNode.ID);
		
		//单击后隐藏menu
		hideMenu();
	}
	function hideMenu() {
		//$("#menuContent").hide();
		//$("body").unbind("mousedown", bodyMousedownHandler);
		$('.choose_content_div').css('display','none');
	}
	
	//创建zTree
	function createTree() {
		zTree = $.fn.zTree.init($("#tree"), setting);
		//$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	}

	function keyUpper(){
		$("#resourceCode").keyup(function(event) {
			//键入英文字符自动转大写
			if (event.keyCode >= 65 && event.keyCode <= 90) {
				$(this).val($(this).val().toUpperCase());
			}
		});
	}
	
	$(document).ready(function(){
		
		initValue();
		createTree();
		keyUpper();
		$("#init").bind("change", createTree);
		$("#last").bind("change", createTree);
	});

	function initValue(){
		//初始赋值
		//var hidden_remark = document.getElementById("hidden_remark").value;
		//alert($("#hidden_remark").val());
		//alert(hidden_remark);
		$("#remark").text($("#hidden_remark").val());
		//设置radio默认值
		var resType = '${resource.resourceType}';
		//alert(resType);
		if(resType == null || resType =='') {
			initRadio("resourceType", '1');
		}
		else {
			initRadio("resourceType", resType);
		}
		
		
		
	}
</script>
</body>
</html>
