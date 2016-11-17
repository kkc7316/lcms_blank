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
	<link type="text/css" rel="stylesheet" href="zTree/zTreeStyle.css" />
	<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="js/selectyze/selectyze.jquery.min.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="js/validity/jquery.validity.js"></script>
     <link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
 <style>
	.main_right{min-width:auto;}
    .ul_form li .span_form_label{width:100px;}
	.ul_form{width:auto;}
	.qxlb{margin-left:0;width:100%;float:none;}
	.qxlb_content{overflow-y:scroll;}
	.edit_content{width:97%;}
	.add_title,.qxlb_content{float:none}
	.box_btn{text-align:center;width:auto;}
    </style>
  <SCRIPT type="text/javascript">
    var zTree;
	//创建树型结构
	function createTree() {
		var setting = {
		    check:{
			    enable:true
		    },
			view: {
				dblClickExpand: true,
				expandSpeed: ""
			},
			//异步加载
			async: {
				enable: true,//设置是否异步加载
				url:"<%=path%>/role/getResourcesList.do", //设置异步获取节点的 URL 地址
				otherParam: [ "roleId", '${updateRole.id}']
				
			},
			
			data: {
				simpleData: {
					enable: true,
					pIdKey: "PARENTID",
					idKey: "ID"
				},
					key: {
						checked: "CHECKED",
						name:"NAME"
					}
			},
			callback: {
      		  onAsyncSuccess: zTreeOnAsyncSuccess  
   		}  
		};
			
		zTree = $.fn.zTree.init($("#tree"), setting);	
		zTree.expandAll(true);
	}
/* 异步加载无法展开tree 默认展开一级菜单 */
var firstAsyncSuccessFlag = 0;
function zTreeOnAsyncSuccess(event, treeId, msg) {  
	if (firstAsyncSuccessFlag == 0) {  
	          try {  
	                 //调用默认展开第一个结点  
	                 var selectedNode = zTree.getSelectedNodes();  
	                 var nodes = zTree.getNodes();  
	                 zTree.expandNode(nodes[0], true);  
	                 var childNodes = zTree.transformToArray(nodes[0]);  
	                 zTree.expandNode(childNodes[1], true);  
	                 zTree.selectNode(childNodes[1]);  
	                 var childNodes1 = zTree.transformToArray(childNodes[1]);  
	                 zTree.checkNode(childNodes1[1], true, true);  
	                 firstAsyncSuccessFlag = 1;  
	           } catch (err) {  
	           
	           }  
	     }  
}
	
	$(function(){
		createTree();	
	});
	
	function submitRole(){
		var nodes = zTree.getCheckedNodes();
		var ids = [];
		for(var i=0,l=nodes.length;i<l;i++){
		   ids[ids.length] = nodes[i].ID;
		}
		//var _resourcesIds=ids.join(",");
		document.getElementById("hidden_resourceList").value=ids.join(",");
				
		//$("#resourcesRoleListForm").submit();
	}
	</SCRIPT>
   
</head>
<body >
<iframe name="hiddenIframe" style="display:none;"></iframe>
    <div class="main_right" id="resourcesRoleListFormId">
        <div class="lbtable1 lbtable1_tan" >
        <form name="resourcesRoleListForm" id="resourcesRoleListForm"  method="post" action="role/doAddRole.do" onsubmit="submitRole()" target="hiddenIframe">
        <input type="hidden" name="token" value="${token}"/>
            <div class="biaoti_title biaoti_title_tan">
                <span>
                <c:if test="${empty updateRole.id}">新增</c:if>
				<c:if test="${not empty updateRole.id}"><spring:message code="EDIT_OPT"></spring:message> </c:if>
				</span>
            </div>
            <div class="lbtable1_content lbtable1_content_tan">
                <ul class="ul_form_col3">
                    <li>
                        <span class="span_form_label"><font class="xh">*</font><spring:message code="ROLE_NAME_LAB"></spring:message>：</span>
                        <div class="div_form_content">
                       		 <input class="file_fixed_150px" value="${updateRole.roleName}" maxlength="20" id="add_roleName" name="roleName"/>
                       		 <input type="hidden" id="hidden_id" value="${updateRole.id}" name="id"/>
                       		 <input type="hidden" id="hidden_resourceList" name="resourcesIds"/>
                        </div>
                    </li>
                    <li> 
                        <span class="span_form_label" ><font class="xh">*</font>角色代码：</span>
                        <div class="div_form_content">
                       	 <input class="file_fixed_150px" value="${updateRole.roleCode}" maxlength="50" id="add_roleCode" name="roleCode"/>
                        </div>
                    </li>
                    <li> 
                        <span class="span_form_label" ><spring:message code="ROLE_DESCRIBE_LAB"></spring:message>：</span>
                        <div class="div_form_content">
                       	 <input class="file_fixed_150px" value="${updateRole.roleDesc}" maxlength="100" id="add_roleDes" name="roleDesc"/>
                        </div>
                    </li>
                    <div style="clear:both;"></div>
                </ul> 
            </div>
            <div class="edit_content">
                <div class="qxlb">
                    <div class="add_title"> 
                        <span>权限列表</span>
                    </div>
                    <div class="qxlb_content">
                    <ul id="tree" class="ztree"></ul>
                        
                    </div>
                </div>
            </div>
            
            <div class="srnr box_btn">
                 <button  class="button2" type="button" id="submit_role_btn" onclick="roleSubmit()" ><spring:message code="SUBMIT_OPT"></spring:message></button>
                 <a  class="button3 close_chuan" ><spring:message code="CANCEL"></spring:message></a>
            </div>
        </form>
        </div>
    </div>    
    <!---->     
    
</body>

<script type="text/javascript">
 $(function(){
  				/* 关闭页面及修改弹窗高度的方法 */
	            $('.close_chuan').click(function(){
	                $(window.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
	                $(window.parent.document).find("#roleList_kcpd").attr("src","about:blank");
	            })
             	$(window.parent.document).find("#roleList_kcpd").css("height",$(".main_right").height()+ 20 );
             	/* 验证空 */
             	$("#resourcesRoleListForm").validity(function() {
				$("#add_roleName").require("不能为空");
				$("#add_roleCode").require("不能为空");
			});
})
function getKey(){
	 if(event.keyCode==13){
		 $("#submit_role_btn").click();
	 }
 }
 function roleSubmit(){
 	$("#resourcesRoleListForm").submit();
 	if ($(".validity-tooltip").length==0) {
 		$("#submit_role_btn").attr("disabled","disabled");
 		$("#submit_role_btn").addClass('btn_active');
 	}
 }
</script>
</html>