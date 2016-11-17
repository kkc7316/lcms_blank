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
 <script>
   $(function(){
   $(window.parent.document).find("#userList_kcpd").css("height",$(".main_right").height()+ 20 )
   })
   </script>
     <style type="text/css">
        .ul_form_seach li{
            width: 45%;
            float: left;
        }
        .ul_form_seach li .seach_input{
            width: 100%;
        }
        .lbtable1_content_tan{
  -width: 700px;
}
   .lbtable1_content_tan .ul_form{
  -width: 700px;
}
  .lbtable1_content_tan .ul_form .span_form_label{
   -width: 100px;
  }
  .tan_table{
    -width: 100%;
    -margin-left: 10px;
   }
   </style>
</head>
<body style="background: rgb(249,249,249)">
 <iframe name="hiddenIframe" style="display:none;"></iframe>
	<div class="main_right">
		<div class="lbtable1 lbtable1_tan" >
			<div class="biaoti_title biaoti_title_tan">
				<span><spring:message code="SET_ROLE_OPT_LAB"></spring:message></span>
			</div>
			<div class="lbtable1_content lbtable1_content_tan">
				<ul class="ul_form_col3">
					<li><span class="span_form_label"><font class="xh">*</font><spring:message code="USER_EMPLOYEE_NUM_LAB"></spring:message>：</span>
						<div class="div_form_content">
							<span class="div_form_content_span" >${sysUser.employeeNum}</span>
						</div></li>
					<li><span class="span_form_label"><font class="xh">*</font><spring:message code="USER_EMPLOYEE_NAME_LAB"></spring:message>：</span>
						<div class="div_form_content">
							<span class="div_form_content_span" >${sysUser.employeeName}</span>
						</div>
						</li>
					
						<li><span class="span_form_label"><font class="xh"></font><spring:message code="SUPPLIER_SAP_NUM_LAB"></spring:message>：</span>
							<div class="div_form_content">
								<span class="div_form_content_span" >${sysUser.svwCode}</span>
							</div>
						</li>
						<div style="clear:both;"></div>
						</ul>
					</div>
					
					<div class="lbtable1_content lbtable1_content_tan">
                        <ul class="ul_form_seach" style="width: 700px;">
                          <li>
                               <div class="seach_input" >
                               <input id='add_left_sel_input' style="width:70%;"/>
                               <button  class="button2" style="float: right; margin-top: 2px;" onclick="conditionValueQuery('unAllocateRoleList',$('#add_left_sel_input').val())">查 询</button>
                               </div>
                          </li>
	                      <li style="margin-left: 9.2%; -margin-left: 8%">
	                          <div class="seach_input">
	                          <input id='add_right_sel_input'  style="width:70%;"/> 
	                          <button  class="button2" style="float: right; margin-top: 2px;" onclick="conditionValueQuery('allocateRoleList',$('#add_right_sel_input').val())">查 询</button>
	                          </div>
	                      </li>
                     	 <div style="clear:both;"></div>
                        </ul>
                    <div class="add_kj" style="width: 700px;">
                        <div class="add_left">
                            <div class="add_title">
                                <span style="font-weight: bold;"><spring:message code="UNASSIGNED_ROLES_LAB"></spring:message></span>
                            </div>
                            <div class="add_kj_tab">
                            <table>
                            	<thead>
									<tr>
										<td><spring:message code="ROLE_NAME_LAB"></spring:message></td>
										<td><spring:message code="ROLE_DESCRIBE_LAB"></spring:message></td>
									</tr>
								</thead>
								<tbody id="unAllocateRoleListTbody">
								<c:forEach items="${unAllocateRoleList}" var="var">
									<tr>
										<td>${var.ROLENAME}</td>
										<td>${var.ROLEDESC}</td>
										<td style="display: none;">${var.ROLEID}</td>
									</tr>
									<tr style="display: none;" id="hiddenFlagLeft">
		                                  <td>hidden_td</td>
                              		</tr>
								</c:forEach>
								</tbody>
                            </table>
                            </div>
                        </div>
		                   <div class="add_center">
		                      <div class="yidong" id='btn_right_go_left'>
		                          <span id="remove" class="yidong_right"><img
		                      src="image/left.png" title="移动到左边">
		                          </span>
		                      </div>
		                      <div class="yidong" id='btn_left_go_right'>
		                          <span id="add" class="yidong_left"><img
		                      src="image/right.png" title="移动到右边">
		                          </span>
		                      </div>
		                      <div class="yidong" id='btn_all_right_go_left'>
		                          <span id="removeAll" class="yidong_right"><img
		                      src="image/all_left.png" title="全部移动到左边">
		                          </span> 
		                      </div>
		                      <div class="yidong" id='btn_all_left_go_right'>
		                          <span id="addAll" class="yidong_left"><img
		                      src="image/all_right.png" title="全部移动到右边">
		                          </span>
		                      </div>
		                  </div>
                        <div class="add_right">
                            <div class="add_title_right">
                                <span style="font-weight: bold;"><spring:message code="EXISTED_ROLES_LAB"></spring:message></span>
                            </div>
                            <div class="add_kj_tab">
                            <table id="selected_list" style="*border-bottom:1px solid rgb(217,217,217)">
	                            <thead>
										<tr>
											<td><spring:message code="ROLE_NAME_LAB"></spring:message></td>
										     <td><spring:message code="ROLE_DESCRIBE_LAB"></spring:message></td>
										</tr>
									</thead>
									<tbody id="allocateRoleListTbody">
										<tr style="display: none;" id="hiddenFlagRight">
		                                  <td>hidden_td</td>
		                                </tr>
		                              <c:forEach items="${allocateRoleList}" var="var">
									 <tr>
										<td>${var.ROLENAME}</td>
										<td>${var.ROLEDESC}</td>
										<td style="display: none;">${var.ROLEID}</td>
									 </tr>
								</c:forEach>
                                   </tbody>
                            </table>
                            </div>
                        </div>
                        <div style="clear:both;"></div>
                    </div>
            </div>
			<div class="srnr box_btn" style="text-align:center;width: 100%;">
			<form action="user/doSetUserRole.do" id="setRoleForm" method="post" target="hiddenIframe">
				<input id="sysUserId" value="${sysUser.id}" type="hidden" name="id"/>
				<input type="hidden" id="roleIds" name="roleIds"/>
				<button id="submitBtn" class="button2" type="button" onclick="submit_setRoleForm()"><spring:message code="SUBMIT_OPT"></spring:message></button>
				<a class="button3 close_chuan"><spring:message code="CANCEL"></spring:message></a>
			</form>
			</div>
		</div>
	</div>
	<!---->     
<script>
     $(function(){
            $('.close_chuan').click(function(){
                ////找到父页面的弹窗div
                $(window.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
                $(window.parent.document).find("#userList_kcpd").attr("src","about:blank");
            })
        })
        
 $(document).ready(function(){

$(".main_right tr").width($(".main_right .add_left").width())	
	/* $(".main_right tr").each(function(){		
		widthArr = $(".main_right thead td");		
		$(this).find("td").eq(0).width(widthArr.eq(0).width());
		$(this).find("td").eq(1).width(widthArr.eq(1).width());
	}) */

	initDraggable();
	//往右托
	$(".main_right .add_left .add_kj_tab").droppable({
		//accept: "#availablePart .tbborder:[data-attr!=nodata]",
		accept: ".main_right .add_right .add_kj_tab tbody tr",
		drop: function( event, ui ) {
				
			//console.log(ui.draggable.parent().find('.onChange').length)
			
			if(ui.draggable.parent().find('.onChange').length > 0 ){
				ui.draggable.parent().find('.onChange').clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.parent().find('.onChange').remove();
			}else{				
				ui.draggable.clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.remove();
			}



			initDraggable();
			changeType();
			clearClass();
		}
	});

	//往左拖
	$(".main_right .add_right .add_kj_tab").droppable({
		//accept: "#availablePart .tbborder:[data-attr!=nodata]",
		accept: ".main_right .add_left .add_kj_tab tbody tr",
		drop: function( event, ui ) {		
			
			if(ui.draggable.parent().find('.onChange').length > 0 ){
				ui.draggable.parent().find('.onChange').clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.parent().find('.onChange').remove();
			}else{				
				ui.draggable.clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.remove();
			}


			initDraggable();
			changeType();
			clearClass();
		}
	});


	changeType();

	$("#btn_right_go_left").click(function(){
		$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody .onChange"));
		$(".main_right .add_right tbody .onChange").remove();
		clearClass();
	})

	$("#btn_left_go_right").click(function(){
		$('.main_right .add_right tbody').prepend($(".main_right .add_left tbody .onChange"));
		$(".main_right .add_left tbody .onChange").remove();
		clearClass();
	})

	$("#btn_all_right_go_left").click(function(){
		//$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody tr"));
		//$(".main_right .add_right tbody tr").remove();
		$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody tr:not(#hiddenFlagRight)"));
		$(".main_right .add_right tbody  tr:not(#hiddenFlagRight)").remove();
		clearClass();
	})

	$("#btn_all_left_go_right").click(function(){
		$('.main_right .add_right tbody').prepend($(".main_right .add_left tbody tr:not(#hiddenFlagLeft)"));
		$(".main_right .add_left tbody tr:not(#hiddenFlagLeft)").remove();
		clearClass()
	})
	//左部筛选
	$("#add_left_sel_input").keyup(function(){

		var _val = $(this).val();

		$(".main_right .add_left tbody tr").each(function(){
			$(this).hide();
			if(($(this).find("td").eq(0).text().indexOf(_val) != -1)||($(this).find("td").eq(1).text().indexOf(_val) != -1)){
				$(this).show();
			}
		})
	})

	//右部部筛选
	$("#add_right_sel_input").keyup(function(){
		var _val = $(this).val();

		$(".main_right .add_right tbody tr").each(function(){
			$(this).hide();
			
			if(($(this).find("td").eq(0).text().indexOf(_val) != -1)||($(this).find("td").eq(1).text().indexOf(_val) != -1)){
				$(this).show();
			}
		})
	})

})

//初始化能拖动的DOM
function initDraggable(){
	//拖动
	$(".main_right .add_left tbody tr").unbind('draggable').draggable({
		appendTo: "body",
		helper: "clone",
		zIndex:15000
	})

	//拖动
	$(".main_right .add_right tbody tr").unbind('draggable').draggable({
		appendTo: "body",
		helper: "clone",
		zIndex:15000
	})

}
//清楚选中样式
function clearClass(){
	$(".main_right .add_left tbody tr,.main_right .add_right tbody tr").removeClass('onChange').css('background','none');	

}

//绑定每行的click 和  dblclick 事件
function changeType(){
	 $(".main_right .add_left tbody tr,.main_right .add_right tbody tr").unbind('click').click(function(){
		if($(this).hasClass('onChange')){	
			$(this).removeClass('onChange').css('background','none');			
		}else{
			$(this).addClass('onChange').css('background','#eee');
		}
	}).unbind('dblclick').dblclick(function(evn){
		if($(this).hasClass('onChange')){	
		}else{
			$(this).addClass('onChange').css('background','#eee');
		}
		//左侧
		if($(this).parent().parent().parent().parent().attr('class')=='add_left'){
			$('.main_right .add_right tbody').prepend($(".main_right .add_left tbody .onChange"));
			$(".main_right .add_left tbody .onChange").remove();
			clearClass(); 
		//右侧
		}else if($(this).parent().parent().parent().parent().attr('class')=='add_right'){
			$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody .onChange"));
			$(".main_right .add_right tbody .onChange").remove();
			clearClass(); 
		}
	}) 
	
}

/* 提交表单 */
	function submit_setRoleForm() {
		var ids=[];
		$("#selected_list").find("tbody tr:not(#hiddenFlagRight)").each(function() {
			var tdArr = $(this).children();
			ids.push(tdArr.eq(2).text());
		});
		$("#roleIds").val(ids);
    	$("#setRoleForm").submit();
    	if ($(".validity-tooltip").length==0) {
    		$("#submitBtn").attr("disabled","disabled");
    		$("#submitBtn").addClass('btn_active');
    	}
	}

function conditionValueQuery(_type,_conditionValue) {
   var _id = $("#sysUserId").val();
   var allocateRoleListHtml = "";
	$.post(
         "user/conditionValueQuery.do",
         {type:_type,conditionValue:_conditionValue,id:_id},
         function(data){
             if (_type=="allocateRoleList") {
                for(var key in data.allocateRoleList){
                allocateRoleListHtml += "<tr>"
                                     + "<td>"    
                                     + data.allocateRoleList[key].ROLENAME
                                     + "</td>"                                   
                                     + "<td>"    
                                     + data.allocateRoleList[key].ROLEDESC
                                     + "</td>"
                                     + "<td style='display: none;'>"
                                     + data.allocateRoleList[key].ROLEID
                                     +"</td>";
                }
                $("#allocateRoleListTbody").html(allocateRoleListHtml);
             } else {
                for(var key in data.unAllocateRoleList){
                 allocateRoleListHtml += "<tr>"
                                     + "<td>"    
                                     + data.unAllocateRoleList[key].ROLENAME
                                     + "</td>"                                   
                                     + "<td>"    
                                     + data.unAllocateRoleList[key].ROLEDESC
                                     + "</td>"
                                     + "<td style='display: none;'>"
                                     + data.unAllocateRoleList[key].ROLEID
                                     +"</td>";
                }
                $("#unAllocateRoleListTbody").html(allocateRoleListHtml);
             }
             $(".main_right tr").width($(".main_right .add_left").width())	
	/* $(".main_right tr").each(function(){		
		widthArr = $(".main_right thead td");		
		$(this).find("td").eq(0).width(widthArr.eq(0).width());
		$(this).find("td").eq(1).width(widthArr.eq(1).width());
	}) */

	initDraggable();
	//往右托
	$(".main_right .add_left .add_kj_tab").droppable({
		//accept: "#availablePart .tbborder:[data-attr!=nodata]",
		accept: ".main_right .add_right .add_kj_tab tbody tr",
		drop: function( event, ui ) {
				
			//console.log(ui.draggable.parent().find('.onChange').length)
			
			if(ui.draggable.parent().find('.onChange').length > 0 ){
				ui.draggable.parent().find('.onChange').clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.parent().find('.onChange').remove();
			}else{				
				ui.draggable.clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.remove();
			}



			initDraggable();
			changeType();
			clearClass();
		}
	});

	//往左拖
	$(".main_right .add_right .add_kj_tab").droppable({
		//accept: "#availablePart .tbborder:[data-attr!=nodata]",
		accept: ".main_right .add_left .add_kj_tab tbody tr",
		drop: function( event, ui ) {		
			
			if(ui.draggable.parent().find('.onChange').length > 0 ){
				ui.draggable.parent().find('.onChange').clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.parent().find('.onChange').remove();
			}else{				
				ui.draggable.clone().insertBefore($(this).find('tbody tr:first'))
				ui.draggable.remove();
			}


			initDraggable();
			changeType();
			clearClass();
		}
	});


	changeType();

	$("#btn_right_go_left").click(function(){
		$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody .onChange"));
		$(".main_right .add_right tbody .onChange").remove();
		clearClass();
	})

	$("#btn_left_go_right").click(function(){
		$('.main_right .add_right tbody').prepend($(".main_right .add_left tbody .onChange"));
		$(".main_right .add_left tbody .onChange").remove();
		clearClass();
	})

	$("#btn_all_right_go_left").click(function(){
		//$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody tr"));
		//$(".main_right .add_right tbody tr").remove();
		$('.main_right .add_left tbody').prepend($(".main_right .add_right tbody tr:not(#hiddenFlagRight)"));
		$(".main_right .add_right tbody  tr:not(#hiddenFlagRight)").remove();
		clearClass();
	})

	$("#btn_all_left_go_right").click(function(){
		$('.main_right .add_right tbody').prepend($(".main_right .add_left tbody tr:not(#hiddenFlagLeft)"));
		$(".main_right .add_left tbody tr:not(#hiddenFlagLeft)").remove();
		clearClass()
	})
	//左部筛选
	$("#add_left_sel_input").keyup(function(){

		var _val = $(this).val();

		$(".main_right .add_left tbody tr").each(function(){
			$(this).hide();
			if(($(this).find("td").eq(0).text().indexOf(_val) != -1)||($(this).find("td").eq(1).text().indexOf(_val) != -1)){
				$(this).show();
			}
		})
	})

	//右部部筛选
	$("#add_right_sel_input").keyup(function(){
		var _val = $(this).val();

		$(".main_right .add_right tbody tr").each(function(){
			$(this).hide();
			
			if(($(this).find("td").eq(0).text().indexOf(_val) != -1)||($(this).find("td").eq(1).text().indexOf(_val) != -1)){
				$(this).show();
			}
		})
	})

         },
        "json"
        );
};
</script>
</body>
</html>
