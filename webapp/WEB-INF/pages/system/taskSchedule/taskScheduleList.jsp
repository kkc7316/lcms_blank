<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<html>
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/validity/jquery.validity_div.js"></script>
<style>
.xllba_width{
  width: 240px;
}

 .xllba_width .skype li a{
    width:240px;
}

.xllba_width .skype .UlSelectize {
  width:240px;
}

.xllba_width .skype .selectyzeValue {
  width:240px;
}
.lbtable1_content_tan .ul_form li{
  width:100%;
}
.lbtable1_content_tan .ul_form li .span_form_label{
  width:240px;
}
.UlSelectizeG {
	overflow:scroll; height:120px;overflow-x:hidden;
}
</style>
<script>
//主动释放 5秒一次
setInterval(function() {
	if (navigator.userAgent.indexOf('MSIE') >= 0) {
		if (CollectGarbage) {
			CollectGarbage(); //IE 特有 释放内存
		}
	}
}, 5000);
//下拉框选中的值显示在条件区域中
function makeQuery(inputId,val,inputValue) {
	var _pul = $("#div\\."+inputId);
        	$("#div\\."+inputId).css("display","none"); //将其悬浮框隐藏
        	$(".span_" + inputId).remove();
        	var _pli = $('<span></span>');//创建一个span
        	_pli.attr("class", "span_" + inputId);
		if(val == "") {
			$("#"+inputId+"_query").css("display","none");
			$("#"+inputId+"_value").text("");
		} else if(inputId == "taskId"){
			_pli.append('<spring:message code="TASK_NAME_LAB"></spring:message>：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'taskId\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} else if(inputId == "cycleType"){
        	_pli.append('<spring:message code="TASK_TYPE_LAB"></spring:message>：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'cycleType\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} else if(inputId == "state"){
        	_pli.append('<spring:message code="RUN_STATUS_LAB"></spring:message>：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'state\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} else if(inputId == "enable"){
        	_pli.append('<spring:message code="ENABLE_STATUS_LAB"></spring:message>：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'enable\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} 
	}
	//悬浮框中点击X执行的函数   下拉框函数执行的
function closeXunfuXl(font,_id){
	$(font).parent().remove();
	$("#"+_id+"_query").css("display","none");//隐藏
	$("#filter\\."+_id).val("");//输入框数值清空
	if(_id == "state"){
		var options = $("#filter\\.state option[value='']");
		$("#filter\\.state").val(options[0].value);
		$("#state").val(options[0].text);
   		$("#state").next().find(".selectyzeValue").html(options[0].value);
	}else if(_id == "taskId"){
		var options = $("#filter\\.taskId option[value='']");
			$("#filter\\.taskId").val(options[0].value);
			$("#taskId").val(options[0].text);
	   		$("#taskId").next().find(".selectyzeValue").html(options[0].value);
	}else if(_id == "cycleType"){
		var options = $("#filter\\.cycleType option[value='']");
			$("#filter\\.cycleType").val(options[0].value);
			$("#cycleType").val(options[0].text);
	   		$("#cycleType").next().find(".selectyzeValue").html(options[0].value);
	}else if(_id == "enable"){
		var options = $("#filter\\.enable option[value='']");
			$("#filter\\.enable").val(options[0].value);
			$("#enable").val(options[0].text);
	   		$("#enable").next().find(".selectyzeValue").html(options[0].value);
	}
}
$(function(){
	$('.xllba').find('input').change(function(){
		if ($(this).attr("id") == "taskId") {
		   makeQuery("taskId",$(this).val(),$(this).val());
	   	}
		if ($(this).attr("id") == "cycleType") {
			makeQuery("cycleType",$(this).val(),$(this).val());
		}
		if ($(this).attr("id") == "state") {
			makeQuery("state",$(this).val(),$(this).val());
		}enable
		if ($(this).attr("id") == "enable") {
			makeQuery("enable",$(this).val(),$(this).val());
		}
	})
//条件区域中点击X号执行的函数
	$('.condition_content_font_span .font2').click(function(){
	   //将其父类进行隐藏
	   //$(this).parent().parent().css('display','none');
	    var input_id = $(this).parent().parent().attr("id");
		var qType = input_id.substring(0, input_id.indexOf("_"));
		if(qType == "taskId"){
			var options = $("#filter\\.taskId option[value='']");
			$("#filter\\.taskId").val(options[0].value);
			$("#taskId").val(options[0].text);
	   		$("#taskId").next().find(".selectyzeValue").html(options[0].value);
		} else if(qType == "state"){
			var options = $("#filter\\.state option[value='']");
			$("#filter\\.state").val(options[0].value);
			$("#state").val(options[0].text);
	   		$("#state").next().find(".selectyzeValue").html(options[0].value);
		}else if(qType == "enable"){
			var options = $("#filter\\.enable option[value='']");
			$("#filter\\.enable").val(options[0].value);
			$("#enable").val(options[0].text);
	   		$("#enable").next().find(".selectyzeValue").html(options[0].value);
		}else if(qType == "cycleType"){
			var options = $("#filter\\.cycleType option[value='']");
			$("#filter\\.cycleType").val(options[0].value);
			$("#cycleType").val(options[0].text);
	   		$("#cycleType").next().find(".selectyzeValue").html(options[0].value);
		} else {
			$("#filter\\."+qType).val(""); //将其输入框中的内容设置为空
			$("#div\\."+qType).children('span').remove(); //删除悬浮框下的所有span 元素
		}
		$("#"+qType+"_query").css("display","none");
		$("#"+qType+"_value").text("");//条件区域赋值
		
	});
})

</script>
</head>
  
 <body>
    <div class="main_right">
    <!------ 查询区------------>
         <div class="lbtable1">
             <div class="biaoti_title"><span><spring:message code="TASK_MANAGE_TITLE"></spring:message></span></div>
             <shiro:hasPermission name="TASK_QUERY">
             <input type="hidden" id="addorupdate" name="addorupdate"/>
       		 <div class="box_btn_seach">
                  <button  class="button2 " id="taskSchedule_chaxun" type="button">
                      <spring:message code="QUERY_OPT"></spring:message>
                   </button>
               	  <!-- <button  class="button2" type="button" type="reset">
               		<img src="image/icon_reset_16_16.png">重置
               	  </button> -->
            </div>
            </shiro:hasPermission>
            <div class="condition">
	         	<div class="condition_content">
	         	  <a class="condition_content_font" id="taskId_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="TASK_NAME_LAB"></spring:message>：<font id="taskId_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.taskId">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="cycleType_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="TASK_TYPE_LAB"></spring:message>：<font id="cycleType_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.cycleType">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="state_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="RUN_STATUS_LAB"></spring:message>：<font id="state_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.state">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="enable_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="ENABLE_STATUS_LAB"></spring:message>：<font id="enable_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.enable">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	            </div>
            </div>
            <div class="clear"></div>
        <form>
            <div class="lbtable1_content">
                <ul class="ul_form">
                    <li >
                        <span class="span_form_label"><spring:message code="TASK_NAME_LAB"></spring:message>：</span>
                        <div class="div_form_content" style = "width:200px;">
                            <div style="float:left;" class="xllba xllba_width">
                               <select class="select_fixed_145px"  id="filter.taskId" title="taskId" onchange="makeQuery('taskId',this.value,this.options[this.selectedIndex].text)">
                                	<option value= "">全部</option>
                                    <c:forEach items="${dictTaskName}" var="map">
								    <option value="${map.value}">${map.value}</option>
								    </c:forEach>
                             </select>
                            </div>
                        </div>
                       
                   </li>
                    <li>
                        <span class="span_form_label"><font class="xh"></font><spring:message code="TASK_TYPE_LAB"></spring:message>：</span>
                        <div class="div_form_content">
                            <div style="float:left;" class="xllba xllba_width">
                               <select class="select_fixed_145px" id="filter.cycleType" title="cycleType" onchange="makeQuery('cycleType',this.value,this.options[this.selectedIndex].text)">
                                    <option value="">全部</option>
                                    <c:forEach items="${dictTaskType}" var="map">
								    <option value="${map.key}">${map.value}</option>
								    </c:forEach>
                             </select>
                            </div>
                        </div>
                   </li>
                    <li>
                        <span class="span_form_label"><font class="xh"></font><spring:message code="RUN_STATUS_LAB"></spring:message>：</span>
                       <div class="div_form_content">
                            <div style="float:left;" class="xllba xllba_width">
                               <select class="select_fixed_145px" id="filter.state" title="state" onchange="makeQuery('state',this.value,this.options[this.selectedIndex].text)">
                                    <option value="">全部</option>
                                    <c:forEach items="${dictTaskState}" var="map">
                                    	<option value="${map.key}">${map.value}</option>
								    </c:forEach>
                             </select>
                            </div>
                        </div>
                   </li>
                   <li>
                        <span class="span_form_label"><font class="xh"></font><spring:message code="ENABLE_STATUS_LAB"></spring:message>：</span>
                       <div class="div_form_content">
                            <div style="float:left;" class="xllba xllba_width">
                               <select class="select_fixed_145px" id="filter.enable" title="enable" onchange="makeQuery('enable',this.value,this.options[this.selectedIndex].text)">
                                    <option  value="">全部</option>
                                    <c:forEach items="${dictAvailable}" var="map">
								    <option value="${map.key}">${map.value}</option>
								    </c:forEach>
                             </select>
                            </div>
                        </div>
                   </li>
                     <div style="clear:both;"></div>
                </ul>
           </div>   
        </form>
		<div id="grid"></div>
        </div>
           

        <div id="bgDiv"></div>
        <!-- 新增任务 -->
        <div class="addDiv" id="addDivId">
        	
            <div class="addDiv_title"> <span id="addDiv_Title_Name">任务新增 </span></div>
            <div class="lbtable1_content lbtable1_content_tan" >
            <ul class="ul_form">
						<input class = "file_fixed_150px" type="hidden" id="token" name = "token" value="" />
	                    <li>
	                        <span class="span_form_label"><font class="xh">*</font><spring:message code="TASK_NAME_LAB"></spring:message>：</span>
	                        <div class="div_form_content">
	                        	
	                        	<div style="float:left;" class="xllba xllba_width">
	                       		 <select class="select_fixed_145px" name="taskName" title="a_taskId" id="a_taskId_Id"> 
	                                	<option value=''>请选择</option>
	                                    <c:forEach items="${dictTaskName}" var="map">
								        <option value="${map.key}">${map.value}</option>
								        </c:forEach>
	                             </select>
	                             </div>
								</div>
	                    </li>
	                    <li> 
	                        <span class="span_form_label"><font class="xh">*</font><spring:message code="TASK_TYPE_LAB"></spring:message>：</span>
	                        <div class="div_form_content">
	                        <div style="float:left;" class="xllba xllba_width">
	                       	 <select class="select_fixed_145px" name="taskType" title="a_cycleType" id="a_cycleType_Id">
	                                    <option value=''>请选择</option>
	                                    <c:forEach items="${dictTaskType}" var="map">
								        	<c:if test="${map.key!='2'}">
								        	<option value="${map.key}">${map.value}</option>
								            </c:if>
								        </c:forEach>
	                                </select>
	                                </div>
	                        </div>
	                        <div style = "display:none" id="ScycleNum_div"><input class="file_fixed_50px" id="ScycleNum" ></input><div class="text_time">分</div></div>
	                    </li>
	                    <li> 
	                        <span class="span_form_label"><font class="xh">*</font>计划时间：</span>
	                        <div class="div_form_content">
	                       	<input class="file_fixed_150px riqi" name="a_excuteTime"  id="a_excuteTime"  style="width: 235px;"/>
	                       	 	<input class="file_fixed_50px" id="HTime" ></input><div class="text_time">时</div>
                            	<input class="file_fixed_50px" id="MTime" ></input><div class="text_time">分</div>
                            	<input class="file_fixed_50px" id="STime" ></input><div class="text_time">秒</div>
                            	<input type="hidden" id="taskScheduleId" ></input>
	                        </div>
	                    </li>
	                    <li id="verTr" style="display: none;">
	                        <span class="span_form_label">版本号：</span>
	                        <div class="div_form_content">
	                        <input id="a_versionNum" name="a_versionNum" class="file_fixed_150px" style="width:235px;"/>
	                        <button class="choose"  onclick="message2('add')"></button>
                       </li>
                       <li id="a_conversionPlantLi" style="display: none;" >
	                        <span class="span_form_label">转换工厂：</span>
	                        <div class="div_form_content">
	                         <div style="float:left;" class="xllba xllba_width">
	                       	 	<select class="select_fixed_145px" name="taskPlant" id="filter.factoryNum" title="factoryNum">
	                                  	<option value=''>请选择</option>
	                                  <c:forEach items="${dictPlant}" var="map">
								       	<option value="${map.key}">${map.key}</option>
								      </c:forEach>
	                            </select>
	                         </div>
                       </li>
                       <li id="a_conversionLi" style="display: none;" >
	                        <span class="span_form_label">转换日期：</span>
	                        <div class="div_form_content">
	                        <input class="file_fixed_150px riqi"  id="a_coversionTime"  style="width: 235px;" />
                       </li>
                       <%--
                       <li id="a_conversionYearLi" style="display: none;" >
                       		<div class="div_form_content" style='width:125px; text-align:right; '>
                       		<input class="file_fixed_150px" style=''  id="a_coversionYearTime" value="${archiveMonth}" style="width: 20px;" readonly="readonly" />
	                        	</div>
	                        <span>
	                        	月之前的数据归档
	                        </span>
	                        
                       </li>
                       --%>
                       <li id="a_conversionYearLi" style="display: none;"> 
	                        <span class="span_form_label"><font class="xh">*</font>备注：</span>
	                        <div class="div_form_content" style='width:300px;'>
                            	<label id="a_coversionYearTime" style='width:40px; display:inline;' >${archiveMonth}</label>月之前的数据归档
                            	
	                        </div>
	                    </li>
	                    <div style="clear:both;"></div>
	                </ul>  
         </div>
          <div class="srnr" style="text-align:center;">
					<button class="button2 btn_save3" onclick="javascript:close_submit_div();"><spring:message code="SUBMIT_OPT"></spring:message></button>
					<a class=" button3" onclick="clear_submit_div();"><spring:message code="CANCEL"></spring:message></a>
	         </div>
	</div>
	<!-- 修改任务弹窗 -->
	<div class="updateDiv" id="updateDivId">
            <div class="addDiv_title"> <span id="addDiv_Title_Name">任务修改 </span></div>
            <div class="lbtable1_content lbtable1_content_tan" >
            <ul class="ul_form">
	                    <li>
	                        <span class="span_form_label"><spring:message code="TASK_NAME_LAB"></spring:message>：</span>
	                        <div class="div_form_content">
	                       		 <label class="file_fixed_label_150px" id="u_taskName"></label>
	                       		 <!-- 任务class -->
	                       		 <input type="hidden" id="u_task_class"></input>
								</div>
	                    </li>
	                    <li> 
	                        <span class="span_form_label"><font class="xh">*</font><spring:message code="TASK_TYPE_LAB"></spring:message>：</span>
	                        <div class="div_form_content">
	                        <div style="float:left;" class="xllba xllba4">
	                       	 <select class="select_fixed_145px" title="u_cycleType" id="u_cycleType_Id">
	                                    <c:forEach items="${dictTaskType}" var="map">
								        	<c:if test="${map.key!='2'}">
								        	<option value="${map.key}">${map.value}</option>
								            </c:if>
								        </c:forEach>
	                                </select>
	                                </div>
	                        </div>
	                        <div style = "display:none" id="u_ScycleNum_div"><input class="file_fixed_50px" id="u_ScycleNum" ></input><div class="text_time">分</div></div>
	                    </li>
	                    <li> 
	                        <span class="span_form_label"><font class="xh">*</font>计划时间：</span>
	                        <div class="div_form_content">
	                       	<input class="file_fixed_150px riqi"  id="u_excuteTime"  style="width: 145px;" />
	                       	 	<input class="file_fixed_50px" id="u_HTime" ></input><div class="text_time">时</div>
                            	<input class="file_fixed_50px" id="u_MTime" ></input><div class="text_time">分</div>
                            	<input class="file_fixed_50px" id="u_STime" ></input><div class="text_time">秒</div>
                            	<input type="hidden" id="u_taskScheduleId" ></input>
                            	<input type = "hidden" id="u_runAvailable"/>
	                        </div>
	                    </li>
	                    <li id="u_verTr" style="display: none;">
	                        <span class="span_form_label">版本号：</span>
	                        <div class="div_form_content">
	                        <input id="u_versionNum" name="u_versionNum" class="file_fixed_150px" style="width: 145px;" />
	                        <!-- 选择版本号 -->
<!--	                        <button class="choose"  onclick="chooseVersion('edit')"></button>-->
							<button class="choose"  onclick="message2('edit')"></button>
                       </li>
                       <li id="u_conversionPlantLi" style="display: none;" >
	                        <span class="span_form_label">转换工厂：</span>
	                        <div class="div_form_content">
	                         <div style="float:left;" class="xllba xllba_width">
	                       	 	<select class="select_fixed_145px" name="taskPlant" id="filter.ufactoryNum" title="ufactoryNum">
	                                  	<option value=''>请选择</option>
	                                  <c:forEach items="${dictPlant}" var="map">
								       	<option value="${map.key}">${map.key}</option>
								      </c:forEach>
	                            </select>
	                         </div>
                       </li>
                       <li id="u_conversionLi" style="display: none;" >
	                        <span class="span_form_label">转换日期：</span>
	                        <div class="div_form_content">
	                        <input class="file_fixed_150px riqi"  id="u_coversionTime"  style="width: 235px;" />
                       </li>
                       <li id="u_conversionYearLi" style="display: none;" >
	                        <span class="span_form_label"><font class="xh">*</font>备注：</span>
	                        <div class="div_form_content" style='width:300px;'>
                            	<label id="u_coversionYearTime" style='width:40px; display:inline;' ></label>月之前的数据归档
                            	
	                        </div>
                       </li>
	                    <div style="clear:both;"></div>
	                </ul>  
         </div>
          <div class="srnr" style="text-align:center;">
					<button class="button2 btn_save3" onclick="javascript:close_update_submit_div();"><spring:message code="SUBMIT_OPT"></spring:message></button>
					<a class=" button3" onclick="clear_update_div()"><spring:message code="CANCEL"></spring:message></a>
	         </div>
	</div>
        <!-- 删除弹框开始 -->
				<div class="confim" id="delete_win">
					<p>确认删除选中记录？</p>
					<div class="confim_btn">
						<button class="button2" onclick="doDeleteConfirm()"><spring:message code="SURE_OPT"></spring:message></button>
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>
		<!-- 删除弹框结束 -->
		<!-- 禁用弹框开始 -->
		<div class="confim" id="endBtn_win">
					<p>请选择您要停用的数据</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="endBtn1_win">
					<p>您选择的数据已经处于停用状态！</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="endBtn2_win">
					<p>确定要停用吗？</p>
					<div class="confim_btn">
						<button class="button2" onclick="doEndConfirm()"><spring:message code="SURE_OPT"></spring:message></button>
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="endBtn3_win">
					<p>停用成功</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="endBtn4_win">
					<p>停用失败</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>		
		<!-- 禁用弹框结束 -->
		<!-- 启用弹框开始 -->
		<div class="confim" id="startBtn_win">
					<p>请选择您要启用的数据</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="startBtn1_win">
					<p>确定要启用吗？</p>
					<div class="confim_btn">
						<button class="button2" onclick="doStartConfirm()"><spring:message code="SURE_OPT"></spring:message></button>
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>		
		<div class="confim" id="startBtn2_win">
					<p>启用成功</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="startBtn3_win">
					<p>启用失败</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>		
		<!-- 启用弹框结束 -->
	<!-- 删除弹框开始 -->
		<div class="confim" id="deleteBtn_win">
					<p>请选择您要删除的数据</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="deleteBtn1_win">
					<p>正在执行的数据，不能删除!</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<!-- 删除弹框结束 -->
		<!-- 执行弹框开始 -->
		<div class="confim" id="resultBtn_win">
					<p>请选择一条任务数据</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		
		<!-- 执行弹框结束 -->
		<!-- 修改弹框开始 -->
		<div class="confim" id="updateBtn_win">
					<p>请选择一行数据进行修改！</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<div class="confim" id="updateBtn1_win">
					<p>处于启用状态的数据不可修改！</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="SURE_OPT"></spring:message></a>
					</div>
				</div>
		<!-- 修改弹框结束 -->
 <!----------------------弹窗 --------------------->
        <!-- 执行结果明细 -->
         <div id="bgDiv2" onclick="close_detail_win()"></div>
         
         <div id="add_ifa">
         <iframe id="taskSchedule_kcpd" src="" width="100%" scrolling="no" border="0" frameborder="0" framespacing=0 ></iframe> 
         </div>
         <!-- -------- 版本号选择弹窗-->
         <div id="add_div" style="width: 520px; margin-left:-260px; margin-top:-250px; ">
    <div class="addDiv_title"><span>版本号选择</span></div>
        <div class="lbtable1_content lbtable1_content_tan">
               <ul class="ul_form_col3" id="add_plant_div">
                
                
            </ul>
            <div style="clear:both;"></div>
        </div>
        <div class="tan_table_btn">
            <button class="button2" onclick="save_v()">保 存</button>
            <a class="button3" onclick="close_div_choose()">取 消</a>
        </div>
    </div>
    </div>
  </body>      
 <!----------------ext表格-------------->
<script type="text/javascript">

/* -------close_detail_win()-------- */
function close_detail_win(){
	$("#add_ifa,#bgDiv2").css("display",'none');
}
/* ---------submit_updateform---------- */
function close_update_submit_div(){
    $(".validity-tooltip").remove();
    $("#u_cycleType").requireSelect("请选择");
	$("#u_excuteTime").require("不能为空");
	//当任务存在时
	var u_taskClass = $("#u_task_class").val();
	//alert(u_taskClass);
	//if(u_taskClass == "com.svw.lcms.utils.job.ReForecastWeekConvertJob") {
		 //$("#u_versionNum").require("不能为空");
	//}
	//单独判断分钟类型任务是否设置了分钟周期
		 var _u_cycleType = $("#u_cycleType_Id").val();
		 if(_u_cycleType == "3"){
		 	$("#u_ScycleNum").require("不能为空").match(/^[0-9]*$/,"请输入有效数字");;
		 }
    
	$("#u_HTime").require("不能为空").match(/^(([0-1]\d)|(2[0-4]))$/,"请输入有效数字");
	$("#u_MTime").require("不能为空").match(/^((([0-1]\d)|[0-5]\d))$/,"请输入有效数字");
	$("#u_STime").require("不能为空").match(/^((([0-1]\d)|[0-5]\d))$/,"请输入有效数字");
	
		var _u_ScycleNum = $("#u_ScycleNum").val();
	    var  excuteTime = document.getElementById("u_excuteTime").value;
		var  HTime = document.getElementById("u_HTime").value;
		var  MTime = document.getElementById("u_MTime").value;
		var  STime = document.getElementById("u_STime").value;
		var u_nextExcuteTime = excuteTime+" "+HTime+":"+MTime+":"+STime;
		var _a_cycleType = $("#u_cycleType_Id").val();
		var _a_taskId = $("#u_taskName").text();
		var _u_taskScheduleId = $("#u_taskScheduleId").val();
		var _u_versionNum;
		if(u_taskClass == "com.svw.lcms.utils.job.QualityReportJob"){
			_u_versionNum = $("#u_coversionTime").val();
			 var factoryNum=document.getElementById("ufactoryNum").value;
			factoryNum = getSelectValueFromText("ufactoryNum", factoryNum);
			_u_versionNum = _u_versionNum + "@"+factoryNum;
		} else if(u_taskClass == "com.svw.lcms.utils.job.ContainerArchiveTableConvertJob"){
			//_u_versionNum = $("#u_coversionYearTime").val();
			_u_versionNum = $("#u_coversionYearTime").html();
			
		} else {
			_u_versionNum = $("#u_versionNum").val();
		}
		var _u_runAvailable = $("#u_runAvailable").val();
			if($(".validity-tooltip").length==0){
				$(".btn_save3").addClass('btn_active');
				$(".btn_save3").attr("disabled");
	     		 $.ajax({
	 				type: "POST",
	 				url: "taskSchedule/taskScheduleAdd.do", 
	 				data: {
	 				"taskName":_a_taskId,
	 				"taskType":_a_cycleType,
	 				"a_nextExcuteTime":u_nextExcuteTime,
	 				"id":_u_taskScheduleId,
	 				"remark":_u_ScycleNum,
	 				"versionNum":_u_versionNum,
	 				"available":_u_runAvailable
	 				},
	 				success:function(data){
		 				if(data.closeFlag=="true"){
		 				     clear_update_div();
		 					 showMsg(data.resultMsg);
		 					 refresh();
		 				}else{
		 				   showMsg2(data.resultMsg);
		 				} 
		 				$(".btn_save3").removeClass('btn_active');
						$(".btn_save3").removeAttr("disabled");
	 				},
	 				failure:function(data){
	 				  showMsg2(data.resultMsg);
	 				  $(".btn_save3").removeClass('btn_active');
						$(".btn_save3").removeAttr("disabled");
	 				}
	 			});
			}
};

 var store;
 var taskSchedule;
 var deleteId = {};
 var ieFlag;
if($.browser.msie && $.browser.version <= 7.0){
	ieFlag=true;
}
 
 //---------------------------页面渲染后执行------------------------------//
   	Ext.onReady(function(){
   		var pretendDate = [ [], [], [], [], [], [], [], [], [], [] ];
    	var pretendDate1 = [];
   	Ext.tip.QuickTipManager.init();
	var itemsPerPage = 10;
	var height = null;
	var loadFlag = true;
	/*------- create store---------*/
	store = new Ext.data.Store({
			autoLoad:true,//自动读取设成true,自动加载数据
			autoDestroy:true,//store的自动销毁
			fields:['id','taskName','taskType','preTime','nextTime','status','result','available','createUser','createDate','taskTypeStr','statusStr','availableStr','resultStr'],//页面显示字段
			pageSize:itemsPerPage,//每页显示的条数
			/* remoteSort:false,//是不是服务端排序
			sorters:[{property:"assetSideNum",direction:"ASC"}],//服务端排序 */
			proxy: {
				type: 'ajax',
		        url:'taskSchedule/taskScheduleList.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
		        actionMethods: {
		      			read: 'POST'
		        },
		        reader: {
		            type: 'json',
		            totalProperty: 'totalCount',
		            root: 'root'
		        }
		  	} ,
		  	listeners:{
				load:function(records, options, success){
					var counts = records.getCount();
					if (counts < 10) {
						taskSchedule.setHeight(height);
					}
					else {
						taskSchedule.setHeight(null);
					}
					var width = 0;
					for(var column  in taskSchedule.columns){
						width += taskSchedule.columns[column].getWidth();
					}
					if (width > taskSchedule.getWidth()) {
						//有滚动条
						taskSchedule.setHeight(taskSchedule.getHeight()+18);
					}
				}
			}
		  	 
    });
    /*----------- 查询条件 -------------*/
 		
	 store.on('beforeload', function(store,options){
	 	 if (loadFlag) {
	 	 	store.loadData(pretendDate);
    		height = taskSchedule.getHeight();
    		store.loadData(pretendDate1);
    		taskSchedule.setHeight(height);
			loadFlag = false;
			store.load();
			return false;
		}
			 
			  	/* ----query condition----- */
 		var x = $("#cycleType").val();
 		x = getSelectValueFromText("cycleType",x);
	  	var y = $("#taskId").val();
	  	y = getSelectValueFromText("taskId",y);
	   	var z= $("#state").val();
	   	z = getSelectValueFromText("state",z);
	    var w = $("#enable").val();
	    w = getSelectValueFromText("enable",w);
		Ext.apply(store.proxy.extraParams, {
								"taskType":x,
								"taskName":y,
								"status":z,
								"available":w		
		});
  	}); 
  	<shiro:hasPermission name="TASK_QUERY">
	/* -------------query_btn-------------- */
		$('#taskSchedule_chaxun').click(function(){
			var taskId = $("#taskId").val();
			taskId = getSelectValueFromText("taskId",taskId);
			if(taskId==null) {
				showMsg2("任务名称不存在，请重新填写");
 				return;
			}
			var cycleType = $("#cycleType").val();
			cycleType = getSelectValueFromText("cycleType",cycleType);
			if(cycleType==null) {
				showMsg2("任务类型不存在，请重新填写");
 				return;
			}
		   	var state= $("#state").val();
		   	state = getSelectValueFromText("state",state);
			if(state==null) {
				showMsg2("运行状态不存在，请重新填写");
 				return;
			}
		    var enable = $("#enable").val();
		    enable = getSelectValueFromText("enable",enable);
			if(enable==null) {
				showMsg2("启用状态不存在，请重新填写");
 				return;
			}
		    
			store.loadPage(1);
		}); 
	</shiro:hasPermission>	
   /* ------------ create tbar------------- */
    var tbar = new Ext.Toolbar({  
     items : [
     			<shiro:hasPermission name="TASK_ADD">
                {  
                text : '新增任务',
                cls:'button6',
                id:'taskSchedule_addBtn'
                 }, 
                 </shiro:hasPermission>	
                 <shiro:hasPermission name="TASK_RESULT">
                 {  
                  text : '<font color="silver">执行结果</font>',  
                  cls:'button4_disable',   //图片样式, 需要自己寫css樣式,引入手寫的css,如果用自带会因为浏览器不兼容而不显示图片 
                  id:'taskSchedule_resultBtn'
                 }, 
                 </shiro:hasPermission>
                 <shiro:hasPermission name="TASK_DEL">
                 {  
	                 text : '<font color="silver">删除任务</font>',  
	                 cls:'button4_disable',
	                 id:'taskSchedule_deleteBtn' 
	                
                },
                  </shiro:hasPermission>
                   <shiro:hasPermission name="TASK_EDIT">
                {  
	                text : '<font color="silver">修改任务</font>',
	                cls:'button4_disable',
	                id:'taskSchedule_editBtn'
                 },
                 </shiro:hasPermission>
                  <shiro:hasPermission name="TASK_STOP">
                 {  
	                 text : '<font color="silver"><spring:message code="DISABLE_OPT"></spring:message></font>',  
	                 cls:'button4_disable', 
	                 id:'taskSchedule_endBtn'   
                },
                </shiro:hasPermission>
                <shiro:hasPermission name="TASK_AVAILABLE">
                 {  
	                 text : '<font color="silver"><spring:message code="ENABLE_OPT"></spring:message></font>',  
	                 cls:'button4_disable',   
	                 id:'taskSchedule_startBtn' 
                }
                 </shiro:hasPermission>
            ]  
        
      });  
/*---------------------分页选择combox-----------------------*/
	  var combo = Ext.create('Ext.form.ComboBox', {
			name : 'pagesize',
			hiddenName : 'pagesize',
			store : new Ext.data.ArrayStore({
				fields : [ 'text', 'value' ],
				data : [ [ '10', 10 ], [ '50', 50 ], [ '100', 100 ] ]
			}),
			valueField : 'value',
			displayField : 'text',
			emptyText : 10,
			width : 50
		});

		combo.on("select", function(comboBox) {
			var pagingToolbar = Ext.getCmp('pagingbar');
			pagingToolbar.pagesize = parseInt(comboBox.getValue());
			itemsPerPage = parseInt(comboBox.getValue());
			store.pageSize = itemsPerPage;
			store.load({
				params : {
					start : 0,
					limit : itemsPerPage
				}
			});
			store.loadPage(1);
		});
/* ----------------------- create grid ----------------------- */
    taskSchedule = new Ext.grid.GridPanel({
       	store:store,
		border:true,
		bodyBorder:false,
		tbar:tbar,  
		frame :false,
		columnLines:true,
		viewConfig: { enableTextSelection:true },
		//forceFit: true,//自动填充 
		//此代码是设置选择checkBox才能选择该条记录
		selModel : Ext.create('Ext.selection.CheckboxModel', {
 		//	checkOnly : true
 			listeners:{
				      'selectionchange':function(sm, selections){
				    	  if(selections.length > 1){
				    		  $('#taskSchedule_deleteBtn-btnInnerEl font,#taskSchedule_endBtn-btnInnerEl font,#taskSchedule_startBtn-btnInnerEl font').attr('color','#545351');
				    		  $('#taskSchedule_editBtn-btnInnerEl font,#taskSchedule_resultBtn-btnInnerEl font').attr('color','silver');
				    		  $("#taskSchedule_editBtn,#taskSchedule_resultBtn").attr("disabled","disabled");
				    		  $("#taskSchedule_editBtn,#taskSchedule_resultBtn").removeClass("button4_disable_hover");
				    		  $("#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").removeAttr("disabled");
				    		  $("#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").addClass("button4_disable_hover");
				    	  } else if (selections.length == 1){
				    	  		$('#taskSchedule_deleteBtn-btnInnerEl font,#taskSchedule_endBtn-btnInnerEl font,#taskSchedule_startBtn-btnInnerEl font,#taskSchedule_editBtn-btnInnerEl font,#taskSchedule_resultBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#taskSchedule_editBtn,#taskSchedule_resultBtn,#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").removeAttr("disabled");
				    		  	$("#taskSchedule_editBtn,#taskSchedule_resultBtn,#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").addClass("button4_disable_hover");
				    	  } else {
				    	  		$('#taskSchedule_editBtn-btnInnerEl font,#taskSchedule_resultBtn-btnInnerEl font,#taskSchedule_deleteBtn-btnInnerEl font,#taskSchedule_endBtn-btnInnerEl font,#taskSchedule_startBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#taskSchedule_editBtn,#taskSchedule_resultBtn,#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").attr("disabled","disabled");
				    	  		$("#taskSchedule_editBtn,#taskSchedule_resultBtn,#taskSchedule_deleteBtn,#taskSchedule_endBtn,#taskSchedule_startBtn").removeClass("button4_disable_hover");
				    	  }
				      }
				}
 		}),
        columns: [      
            {
                header: "<spring:message code="TASK_NAME_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'taskName',
                width:180,
                align:'center'
            },
             
            {
                header: "<spring:message code="PLANNED_TIME_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'createDate',
                width:150,
                align:'center'
            },
            {
                header: "<spring:message code="LAST_EXCUTE_TIME_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'preTime',
                width:250,
                align:'center'
            },
            {
                header: "<spring:message code="NEXT_EXCUTE_TIME_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'nextTime',
                width:250,
                align:'center'
            },
            {
                header: "<spring:message code="RUN_STATUS_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'statusStr',
                width:120,
                align:'center'
            },
            {
                header: "<spring:message code="LATEST_EXCUTE_RESULTS_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'resultStr',
                width:150,
                align:'center'
            },
            {
                header: "<spring:message code="TASK_TYPE_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'taskTypeStr',
                width:120,
                align:'center'
            },
            {
                header: "<spring:message code="CREATE_USER_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'createUser',
                width:120,
                align:'center',
                renderer : function(value, cellmeta, record, rowIndex, columnIndex, store) {
                				if(value != null && value != ""){
                					return changeUserNumToName(value);
            					}
							
				}
            },
            {
                header: "<spring:message code="DISABLE/ENABLE_LAB"></spring:message>",
                sortable: true,
                dataIndex: 'availableStr',
                width:120,
                align:'center'
            }
            
                    ],  

        dockedItems: [   ////翻页   
        {
       	    id : 'pagingbar',
			xtype: 'pagingtoolbar',
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            store: store,
            pageSize : 10,
            displayInfo: true,
            beforePageText: '第',
            afterPageText: '/{0}页',
            firstText: '首页',
            prevText: '上一页',
            nextText: '下一页',
            lastText: '尾页',
            displayMsg: '显示 第 {0} 条 到 第 {1} 条 记录，共 {2} 条记录',
            emptyMsg: '无记录',
            items : [ '-', '每页显示', combo, '条' ]
            
        }],
        renderTo: 'grid'
    });
    <shiro:hasPermission name="TASK_ADD">
    /*----------------addBtn-----------------------*/
    $('#taskSchedule_addBtn').click(function(){
		$('.addDiv,#bgDiv').css('display','block');
		$("#addDivId").addClass("blank_check_class");
		//由于新增采用当前页面层打开因此  每次打开新增页面需要成功新生成token
		$.ajax({
			type: "POST",
			url: "sys/getToken.do", 
			async: false,
			success:function(data){
				//alert(data);
				$("#token").val(data);
			}
		});
	});
	</shiro:hasPermission>
	<shiro:hasPermission name="TASK_RESULT">
    /*----------------resultBtn---------------------*/
  $('#taskSchedule_resultBtn').click(function(){
 	var demoListSelection = taskSchedule.getSelectionModel().getSelection();
		  if (demoListSelection.length !==1) {
			      	return false;
			    }else{
			    		_id = demoListSelection[0].data.id;
			    		_taskName = demoListSelection[0].data.taskName;
			    		var showVersionFlag;
			    		if(_taskName=="工位器具需求预测任务"){	
			    			showVersionFlag = '0';
			    		}else{
			    			showVersionFlag = '1';
			    		}
			    		//console.log(demoListSelection[0].data.taskName);
			    		$('#add_ifa,#bgDiv2').css('display','block');
					    $('#taskSchedule_kcpd').attr('src','<%=path%>/taskSchedule/excuteResultInit.do?id=' + _id + '&showVersionFlag='+showVersionFlag);
  	 }
  });
  </shiro:hasPermission>
   <shiro:hasPermission name="TASK_DEL">
 /*----------------delete btn---------------- */
$('#taskSchedule_deleteBtn').click(function(){
    var demoListSelection = taskSchedule.getSelectionModel().getSelection();
    if (demoListSelection.length == 0) {
      	return false;
    } else {
    	var _list = {};
        var long = demoListSelection.length;
        for (var i = 0; i < long; i++) {
        	 if(demoListSelection[i].data.available == "1"){
        	    //检查任务是否是已经运行中
		      	var checkFlag = checkTaskType(demoListSelection[0].data.id);
	    		if(checkFlag == true){
	    			showMsg2('运行中，不能删除');
	    			return false;
	    		}else{
	    			_list[i] = demoListSelection[i].data.id;//将id赋值到list中
	    	    }
        	}else{ 
        		_list[i] = demoListSelection[i].data.id;//将id赋值到list中
        	}
        }
        deleteComfirm(_list);
      return false;
    }  
	});
	  </shiro:hasPermission>
	  <shiro:hasPermission name="TASK_AVAILABLE">
	/*---------------start_btn------------------*/
	$('#taskSchedule_startBtn').click(function(){
    var demoListSelection = taskSchedule.getSelectionModel().getSelection();
    if (demoListSelection.length == 0) {
    //$('#startBtn_win,#bgDiv').css('display','block');
      	return false;
    } else {
    var _list = {};
        var long = demoListSelection.length;
        for (var i = 0; i < long; i++) {
	        if(demoListSelection[i].data.available == "1"){
				 	showMsg2("您选择的数据已经处于启用状态");
			      	return false;
	        	}else{
	        		_list[i] = demoListSelection[i].data.id;//将id赋值到list中
	        	}
	        }
	            startComfirm(_list);
        }
        });
        </shiro:hasPermission>
	 <shiro:hasPermission name="TASK_STOP">
	/*---------------end_btn------------------*/
	$('#taskSchedule_endBtn').click(function(){
    var demoListSelection = taskSchedule.getSelectionModel().getSelection();
    if (demoListSelection.length == 0) {
    //$('#endBtn_win,#bgDiv').css('display','block');
      	return false;
    } else {
    	var _list = {};
		var long = demoListSelection.length;
		for (var i = 0; i < long; i++) {
			 if(demoListSelection[i].data.available == "0"){
			 	showMsg2("您选择的数据已经处于停用状态");
		      	return false;
        	}else{
        		_list[i] = demoListSelection[i].data.id;//将id赋值到list中
        	}
        	}
        	   endComfirm(_list);
        	}
        
	});
	 </shiro:hasPermission>
	<shiro:hasPermission name="TASK_EDIT">
	/* --------------update btn---------------- */ 
    $('#taskSchedule_editBtn').click(function(){
	    var demoListSelection = taskSchedule.getSelectionModel().getSelection();
	    if (demoListSelection.length !==1) {
	      	return false;
	    }else{
	    	 if(demoListSelection[0].data.available=="1"){
	    	    // 如果是启用任务，检查任务的运行状态
	    		var checkFlag = checkTaskType(demoListSelection[0].data.id);
	    		if(checkFlag == true){
	    			showMsg2('运行中，不能修改');
	    			return false;
	    		}else{
	    			editInit(demoListSelection[0].data.id);
	    		}
	    	}else{ 
	    		/* ---初始化弹窗内容--- */
		    	editInit(demoListSelection[0].data.id); 
	    	}
	    }
    });
	</shiro:hasPermission>
});
/* -----------获取更新内容，并打开更新弹窗------------- */
function editInit(val){
	$.ajax({
				type: "POST",
				url: "taskSchedule/addTaskInit.do", 
				data: {'id':val},
				success:function(data){
   					//根据任务名判断是否显示版本选择录入匡
   					$("#u_task_class").val(data.updateModel.taskClass);
   					$("#u_taskName").text(data.updateModel.taskName);
   					
   					//if(data.updateModel.taskName=="工位器具需求预测任务"){
   					if(data.updateModel.taskClass == "com.svw.lcms.utils.job.ReForecastWeekConvertJob"){
   						//获取工厂
   						$("#addorupdate").val("edit");
   						$("#add_plant_div").find("li").remove(); 
			        	$.ajax({
							type: "POST",
							url: "plant/allPlantList.do", 
							async:false,
							success:function(data){
								for(j=0;j<data.length;j++){
									var liStart= '<li style="width: 100%"><span class="span_form_label">'+data[j].plantNum+'工厂：</span>';
									var input ='<div class="div_form_content"><input class="file_fixed_150px" readOnly="true" name="plantAndVersion" id = "'+data[j].plantNum+'" style="width: 200px;" /></div><button class="button2" onclick="chooseVersion(\'add\','+data[j].plantNum+')">选择零件版本</button>'
									var liEnd= '</li>';
									$("#add_plant_div").append(liStart+input+liEnd);
								}
			//				$('.addDiv').css('display','none');
			//    			$('#add_div').css('display','block');
							}
						});
						
   					 	$("#u_verTr").show();
   					}else{
   						$("#u_verTr").hide();
   					}
   					//运作质量报表
   					if(data.updateModel.taskClass == "com.svw.lcms.utils.job.QualityReportJob"){
			            $("#u_conversionLi").show();
			            $("#u_conversionPlantLi").show();
			        }else{
			            $("#u_conversionLi").hide();
			            $("#u_conversionPlantLi").hide();
			        }
			        
			        if(data.updateModel.taskClass == "com.svw.lcms.utils.job.ContainerArchiveTableConvertJob"){
			            $("#u_conversionYearLi").show();
			        }else{
			            $("#u_conversionYearLi").hide();
			        }
   					
   					//如果修改时分钟类型的周期任务，显示分钟周期
   					if(data.updateModel.taskType == '3'){
   						$("#u_ScycleNum_div").show();
   						$("#u_ScycleNum").val(data.updateModel.remark);
   					}else{
   						$("#u_ScycleNum_div").hide();
   					}
   					//赋值
   					var taskType =data.updateModel.taskType;
   					var options = $("#u_cycleType_Id option[value="+taskType+"]");
					$("#u_cycleType_Id").val(options[0].value);
					$("#u_cycleType").val(options[0].text);
		   			$("#u_cycleType").next().find(".selectyzeValue").html(options[0].value);
		   			if(data.nextExcuteTime != null && data.nextExcuteTime !='') {
		   				$("#u_excuteTime").val(data.nextExcuteTime.substring(0,10));
			   			$("#u_HTime").val(data.nextExcuteTime.substring(11,13));
			   			$("#u_MTime").val(data.nextExcuteTime.substring(14,16));
			   			$("#u_STime").val(data.nextExcuteTime.substring(17,19));
		   			}
		   			
		   			$("#u_taskScheduleId").val(data.updateModel.id);
		   			$("#u_runAvailable").val(data.updateModel.available);
		   			if(data.updateModel.taskClass == "com.svw.lcms.utils.job.QualityReportJob"){
		   				var versionNum = data.updateModel.versionNum;
		   				var strs= new Array(); //定义一数组 
		   				strs = versionNum.split("@"); //字符分割 
			            $("#u_coversionTime").val(strs[0]);
			            var options = $("#filter\\.ufactoryNum option[value="+ strs[1] +"]");
						$("#filter\\.ufactoryNum").val(options[0].value);
						$("#ufactoryNum").val(options[0].text);
						$("#ufactoryNum").next().find(".selectyzeValue").html(options[0].value);
			        } else if(data.updateModel.taskClass == "com.svw.lcms.utils.job.ContainerArchiveTableConvertJob"){
			            //$("#u_coversionYearTime").val(data.updateModel.versionNum);
			            //归档--月份显示
			            $("#u_coversionYearTime").html(data.updateModel.versionNum);
			            
			        } else{
			            //版本号赋值
		   				$("#u_versionNum").val(data.updateModel.versionNum);
			        }
		   			$("#updateDivId").addClass("blank_check_class");
					$('.updateDiv,#bgDiv').css('display','block'); 
				}
			});
}
function deleteComfirm(val){
	deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
	$('#delete_win,#bgDiv').css('display','block');
	
}

//执行删除的函数
function doDeleteConfirm(){
	 Ext.Ajax.request({
         url: 'taskSchedule/deleteTaskSchedule.do',
         params: {ids: deleteId },
         method: 'post',
         success: function (response, options) {
        	 $('#delete_win,#bgDiv').css('display','none');
			 deleteId = {};//将其全局变量赋值为空
			 showMsg("删除成功");
             refresh();//刷新数据
         },
         failure: function (response, options) { 
             showMsg2("删除失败");
         }
     });
}

function startComfirm(val){
	deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
	 $('#startBtn1_win,#bgDiv').css('display','block');
	}
	
	function doStartConfirm() {
	Ext.Ajax.request({
		                url: 'taskSchedule/taskScheduleStart.do',
		                params: {ids: deleteId },
		                method: 'post',
		                success: function (response, options) {
		                  showMsg("启用成功");
		                  $('#startBtn1_win,#bgDiv').css('display','none');
		                  refresh();
		                },
		                failure: function (response, options) {
		                  showMsg2("启用失败");
		                  $('#startBtn1_win,#bgDiv').css('display','none');
		                }
		            });
	
	}
	
	function endComfirm(val){
		endId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
	    $('#endBtn2_win,#bgDiv').css('display','block');
	}
	function doEndConfirm() {
	 Ext.Ajax.request({
	                url: 'taskSchedule/shutdownTasks.do',
	                params: {ids: endId },
	                method: 'post',
	                success: function (response, options) {
	                    showMsg("停用成功");
	                    $('#endBtn2_win,#bgDiv').css('display','none');
	                    refresh();
	                },
	                failure: function (response, options) {
	                    showMsg2("停用失败");
	                    $('#endBtn2_win,#bgDiv').css('display','none');
	                }
	            });
	}
/*--------------refresh---------------  */
function refresh(){
	store.load();
	taskSchedule.getSelectionModel().clearSelections();
}
/* 关闭新增div */   
function clear_submit_div(){
    $(".validity-tooltip").remove();
    $("#addDivId").removeClass("blank_check_class");
	$('.addDiv,#bgDiv').css('display','none');
	$("#verTr").hide();
	$("#a_conversionLi").hide();
	$("#a_conversionPlantLi").hide();
	$("#a_conversionYearLi").hide();
	$("#ScycleNum_div").hide();
	$("#ScycleNum").val("");
	 var options = $("#a_taskId_Id option[value='']");
					$("#a_taskId_Id").val(options[0].value);
					$("#a_taskId").val(options[0].text);
		   			$("#a_taskId").next().find(".selectyzeValue").html(options[0].value);
		   			
		   			var options = $("#a_cycleType_Id option[value='']");
					$("#a_cycleType_Id").val(options[0].value);
					$("#a_cycleType").val(options[0].text);
		   			$("#a_cycleType").next().find(".selectyzeValue").html(options[0].value);
		   			$("#a_excuteTime").val("");
		   			$("#HTime").val("");
		   			$("#MTime").val("");
		   			$("#STime").val("");
		   			
		   			//关闭新增弹出时，清空版本号
		   			$("#a_versionNum").val("");   
		   			$("#a_coversionTime").val("");
		   			$("#a_coversionYearTime").val("");
		   			var options = $("#filter\\.factoryNum option[value='']");
	$("#filter\\.factoryNum").val(options[0].value);
	$("#factoryNum").val(options[0].text);
	$("#factoryNum").next().find(".selectyzeValue").html(options[0].value);
}
/* 关闭修改弹窗 */
function clear_update_div(){
	$(".validity-tooltip").remove();
	$('.updateDiv,#bgDiv').css('display','none');
	$("#updateDivId").removeClass("blank_check_class");
	$("#u_ScycleNum").val("");
	$("#u_verTr").hide();
	$("#u_conversionLi").hide();
	$("#u_conversionPlantLi").hide();
	$("#u_conversionYearLi").hide();
	$("#u_coversionTime").val("");
	$("#u_coversionYearTime").val("");
	var options = $("#filter\\.ufactoryNum option[value='']");
	$("#filter\\.ufactoryNum").val(options[0].value);
	$("#ufactoryNum").val(options[0].text);
	$("#ufactoryNum").next().find(".selectyzeValue").html(options[0].value);
}
/* 选择版本号*/
function chooseVersion(value,plant) {
//	alert(value);
//alert(plant);
	
	$(".validity-tooltip").remove();
	//新增任务-隐藏
	$('#add_div').css('display','none');
	//任务结果-显示
	$('#add_ifa').css('display','block');
	//显示版本号选择页面
//	$('#taskSchedule_kcpd').attr('src',"<%=path%>/taskSchedule/versionResultListPage.do?versionId=" + value);
    $('#taskSchedule_kcpd').attr('src',"<%=path%>/taskSchedule/versionResultListPage.do?versionId=" + value+"&&plant="+plant);
}
/* 设置版本号 */
function setVersion(versionId,versionValue,plant) {
	//去掉红色
	$("#"+plant).css('color','#525250');
	if(versionId=='add'){
		document.getElementById(plant).value = versionValue;
	}
    else if(versionId=='edit') {
    	document.getElementById("u_versionNum").value = versionValue;
    }
    
    
}
/* change事件，根据选择的任务名称判断是否显示版本号选项 */
$(function(){
	 $('#a_taskId_Id').change(function(){
		
        var _index = $(this).find("option:selected").index();
        var _indexKey = $("#a_taskId_Id").val();
        var _indexValue = $("#a_taskId_Id").find("option:selected").text();
        //alert(_index);
        //alert(_indexValue);
        //alert(_indexKey);
        //第四个显示版本号列表
        //if(_indexValue == '工位器具需求预测任务'){
        	
        if(_indexKey == "com.svw.lcms.utils.job.ReForecastWeekConvertJob"){
        	$("#addorupdate").val("add");
        	$("#add_plant_div").find("li").remove(); 
        	$.ajax({
				type: "POST",
				url: "plant/allPlantList.do", 
				async:false,
				success:function(data){
					for(j=0;j<data.length;j++){
						var liStart= '<li style="width: 100%"><span class="span_form_label">'+data[j].plantNum+'工厂：</span>';
						var input ='<div class="div_form_content"><input class="file_fixed_150px" readOnly="true" name="plantAndVersion" id = "'+data[j].plantNum+'" style="width: 200px;" /></div><button class="button2" onclick="chooseVersion(\'add\','+data[j].plantNum+')">选择零件版本</button>'
						var liEnd= '</li>';
						$("#add_plant_div").append(liStart+input+liEnd);
					}
//				$('.addDiv').css('display','none');
//    			$('#add_div').css('display','block');
				}
			});
            $("#verTr").show();
        }else{
            $("#verTr").hide();
        }
        
        if(_indexKey == "com.svw.lcms.utils.job.QualityReportJob"){
            $("#a_conversionLi").show();
            $("#a_conversionPlantLi").show();
        }else{
            $("#a_conversionLi").hide();
            $("#a_conversionPlantLi").hide();
        }
        if(_indexKey == "com.svw.lcms.utils.job.ContainerArchiveTableConvertJob"){
            $("#a_conversionYearLi").show();
        }else{
            $("#a_conversionYearLi").hide();
        }
     }) 
     //change事件 若为分钟任务则显示分钟输入框
     $("#a_cycleType_Id").change(function(){
     	var _index = $(this).find("option:selected").index();
        var _indexKey = $("#a_cycleType_Id").val();
         if(_indexKey == "3"){
            $("#ScycleNum_div").show();
        }else{
            $("#ScycleNum_div").hide();
            $("#a_ScycleNum").val("");
        }
     })
     //修改 change事件 若为分钟任务则显示分钟输入框
     $("#u_cycleType_Id").change(function(){
     	var _index = $(this).find("option:selected").index();
        var _indexKey = $("#u_cycleType_Id").val();
         if(_indexKey == "3"){
            $("#u_ScycleNum_div").show();
        }else{
            $("#u_ScycleNum_div").hide();
            $("#u_ScycleNum").val("");
        }
     })
})
/* 提交新生任务弹窗 相关验证 */
function close_submit_div(){
	     $(".validity-tooltip").remove();
	     $("#a_cycleType").requireSelect("请选择");
		 $("#a_taskId").requireSelect("请选择");
		 $("#a_excuteTime").require("不能为空");
		 
		 var _token = $("#token").val();
		//selected-value
		 var _a_taskId = $("#a_taskId_Id").val();
		 //alert(_a_taskId);
		 //if(_a_taskId == "com.svw.lcms.utils.job.ReForecastWeekConvertJob") {
			 //$("#a_versionNum").require("不能为空");
		 //}
		 
		 //单独判断分钟类型任务是否设置了分钟周期
		 var _a_cycleType = $("#a_cycleType_Id").val();
		 if(_a_cycleType == "3"){
		 	$("#ScycleNum").require("不能为空").match(/^[0-9]*$/,"请输入有效数字");;
		 }
		 
		 $("#HTime").require("不能为空").match(/^(([0-1]\d)|(2[0-4]))$/,"请输入有效数字");
		 $("#MTime").require("不能为空").match(/^((([0-1]\d)|[0-5]\d))$/,"请输入有效数字");
		 $("#STime").require("不能为空").match(/^((([0-1]\d)|[0-5]\d))$/,"请输入有效数字");
		var  excuteTime = document.getElementById("a_excuteTime").value;
		var  HTime = document.getElementById("HTime").value;
		var  MTime = document.getElementById("MTime").value;
		var  STime = document.getElementById("STime").value;
		var a_nextExcuteTime = excuteTime+" "+HTime+":"+MTime+":"+STime;
		var _a_cycleType = $("#a_cycleType_Id").val();
		//selected-value
		//var _a_taskId = $("#a_taskId_Id").val();
		//selected-text
	 	var _a_taskName = $("#a_taskId_Id").find("option:selected").text();
		//versionNum==remark
		var _a_versionNum;
		if(_a_taskId == "com.svw.lcms.utils.job.QualityReportJob"){
            _a_versionNum = $("#a_coversionTime").val();
            var factoryNum=document.getElementById("factoryNum").value;
			factoryNum = getSelectValueFromText("factoryNum", factoryNum);
			_a_versionNum =_a_versionNum + "@"+factoryNum;
        }else if(_a_taskId == "com.svw.lcms.utils.job.ContainerArchiveTableConvertJob"){
            //_a_versionNum = $("#a_coversionYearTime").val();
            _a_versionNum = $("#a_coversionYearTime").html();
            if(_a_versionNum <= 0) {
            	showMsg2("归档月份不能小于0");
            	return;
            }
            //数值小于10
            if(_a_versionNum < 10){
            	 if(!confirm("归档月份小于10,可能会对收发记录有影响，请再次确认")) {
					return;
            	 }
            }
            if(isNaN(_a_versionNum) || _a_versionNum % 1 != 0) {
            	showMsg2("归档月份必须为正整数");
            	return;
            }
            
        } else{
            _a_versionNum = $("#a_versionNum").val();
        }
		var _a_ScycleNum = $("#ScycleNum").val();
		//alert(_a_versionNum);
		//alert(_a_taskId);
		//alert(_a_taskName);
	 	//	return false;
			if($(".validity-tooltip").length==0){
				$(".btn_save3").attr("disabled","disabled");
				$(".btn_save3").addClass('btn_active');
	     		 $.ajax({
	 				type: "POST",
	 				url: "taskSchedule/taskScheduleAdd.do", 
	 				data: {
	 				"token":_token,
	 				"taskName":_a_taskName,
	 				"taskClass":_a_taskId,
	 				"taskType":_a_cycleType,
	 				"remark":_a_versionNum,
	 				"a_nextExcuteTime":a_nextExcuteTime,
	 				"remark":_a_ScycleNum,
	 				"versionNum":_a_versionNum
	 				},
	 				success:function(data){
		 				if(data.closeFlag=="true"){
		 					 clear_submit_div();
		 					 showMsg(data.resultMsg);
		 					 refresh();
		 				} else if(data.closeFlag=="false") {
		 					showMsg2(data.resultMsg);
		 				}else{
		 					showMsg2(data.resultMsg);
		 				}
		 				$(".btn_save3").removeClass('btn_active');
		 				$(".btn_save3").removeAttr("disabled");
	 				},
	 				failure:function(data){
	 				  showMsg2(data.resultMsg);
	 				  $(".btn_save3").removeClass('btn_active');
	 				  $(".btn_save3").removeAttr("disabled");
	 				}
	 			});
	     	 }
}

/* 任务添加弹窗中使用的时间 */
var a_excuteTime = {
		    elem: '#a_excuteTime',
		    format: 'YYYY-MM-DD',
		    choose:function(datas){
		    	autoSetTime(datas, "HTime", "MTime", "STime");
		    }
		};
	laydate(a_excuteTime);
	
/* 任务更新弹窗中使用的时间 */
var u_excuteTime = {
		    elem: '#u_excuteTime',
		    format: 'YYYY-MM-DD',
		    choose:function(datas){
		    	autoSetTime(datas, "u_HTime", "u_MTime", "u_STime");
		    }
		};
	laydate(u_excuteTime);

/* 任务添加弹窗中使用的时间 */
var a_conversionTime = {
		    elem: '#a_coversionTime',
		    format: 'YYYY-MM',
		    choose:function(datas){
		    	
		    }
		};
	laydate(a_conversionTime);
	
	/* 任务添加弹窗中使用的时间 */
var u_coversionTime = {
		    elem: '#u_coversionTime',
		    format: 'YYYY-MM',
		    choose:function(datas){
		    }
		};
	laydate(u_coversionTime);

	/* 任务添加弹窗中使用的时间 
	var a_conversionYearTime = {
		    elem: '#a_coversionYearTime',
		    format: 'YYYY',
		    choose:function(datas){
		    	
		    }
		};
	laydate(a_conversionYearTime);
	*/	
	/* 任务添加弹窗中使用的时间 
	var u_coversionYearTime = {
		    elem: '#u_coversionYearTime',
		    format: 'YYYY',
		    choose:function(datas){
		    }
		};
	laydate(u_coversionYearTime);
	*/	
	
//根据选定日期判断是否自动设定时间	
function autoSetTime(datas, hour, minute, second){
	var currentDateTime = new Date();
	currentDateTime.setMinutes(currentDateTime.getMinutes() + 1);
	var currentDate = currentDateTime.pattern("yyyy-MM-dd");
	var currentDateTimeToString = currentDateTime.pattern("yyyy-MM-dd HH:mm:ss")
	if(datas==currentDate){
		//console.log("选中了今天");
		$("#" + hour).val(currentDateTimeToString.substring(11, 13));
		$("#" + minute).val(currentDateTimeToString.substring(14, 16));
	    $("#" + second).val(currentDateTimeToString.substring(17, 19));
	}else{
	    $("#" + hour).val("");
		$("#" + minute).val("");
	    $("#" + second).val("");
	}
	
}	
//js日期格式化函数	
Date.prototype.pattern=function(fmt) {           
    var o = {           
    "M+" : this.getMonth()+1, //月份           
    "d+" : this.getDate(), //日           
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
    "H+" : this.getHours(), //小时           
    "m+" : this.getMinutes(), //分           
    "s+" : this.getSeconds(), //秒           
    "q+" : Math.floor((this.getMonth()+3)/3), //季度           
    "S" : this.getMilliseconds() //毫秒           
    };           
    var week = {           
    "0" : "/u65e5",           
    "1" : "/u4e00",           
    "2" : "/u4e8c",           
    "3" : "/u4e09",           
    "4" : "/u56db",           
    "5" : "/u4e94",           
    "6" : "/u516d"          
    };           
    if(/(y+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
    }           
    if(/(E+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
    }           
    for(var k in o){           
        if(new RegExp("("+ k +")").test(fmt)){           
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
        }           
    }           
    return fmt;           
} 	
//单元格渲染，编号转姓名
function changeUserNumToName(userNum){
   var userName;
   $.ajax({
				type: "POST",
				url: "user/changeUserNumtoName.do", 
				data: {'userNum':userNum},
				async:false,
				success:function(data){
   					userName = data.UserName;
				}
			});
			return userName;
}
//检查任务状态是否是运行中
function checkTaskType(val){
   var result;
   $.ajax({
				type: "POST",
				url: "taskSchedule/checkTaskType.do", 
				data: {'id':val},
				async:false,
				success:function(data){
   					result = data.result;
				}
			});
			return result;
}

//根据输入的值 获得select的key
function getSelectValueFromText(filter,textValue){
	var key = null;
	//遍历select option
	$("#filter\\."+filter+" option").each(function(){ //遍历全部option
	        var txt = $(this).text(); //获取option的内容
	        if(txt == textValue) {
	        	key = $(this).val();
	        }
	 });
	return key;
}


//根据输入的值 获得select的key
function getSelectValueFromText(id, textValue){
	var key = null;
	//遍历select option
	$("#filter\\." + id + " option").each(function(){ //遍历全部option
	        var txt = $(this).text(); //获取option的内容
	        if(txt == textValue){
	        	key = $(this).val();
	        }
	 });
	return key;
}
//add by chenping 
function message2(flag){
//	$("#add_plant_div").find("li").remove(); 
//    $.ajax({
//				type: "POST",
//				url: "plant/allPlantList.do", 
//				async:false,
//				success:function(data){
//					for(j=0;j<data.length;j++){
//						var liStart= '<li style="width: 100%"><span class="span_form_label">'+data[j].plantNum+'工厂：</span>';
//						var input ='<div class="div_form_content"><input class="file_fixed_150px" name="plantAndVersion" id = "'+data[j].plantNum+'" style="width: 200px;" /></div><button class="button2" onclick="chooseVersion(\'add\','+data[j].plantNum+')">选择零件版本1</button>'
//						var liEnd= '</li>';
//						$("#add_plant_div").append(liStart+input+liEnd);
//					}
				if(flag == 'add'){
					$('.validity-tooltip').remove();
					$('.addDiv').css('display','none');
	    			$('#add_div').css('display','block');
				}else{
					//初始化工厂对应的编号
//					var versionNum = $("#u_versionNum").val();
//					 $.ajax({
//						type: "POST",
//						url: "forecastWeek/versionLists.do", 
//						data: {"versionNum":versionNum},
//						async:false,
//						success:function(data){
//							for(j=0;j<data.length;j++){
//								var liStart= '<li style="width: 100%"><span class="span_form_label">'+data[j].plantNum+'工厂：</span>';
//								var input ='<div class="div_form_content"><input class="file_fixed_150px" name="plantAndVersion" id = "'+data[j].plantNum+'" style="width: 200px;" /></div><button class="button2" onclick="chooseVersion(\'add\','+data[j].plantNum+')">选择零件版本1</button>'
//								var liEnd= '</li>';
//								$("#add_plant_div").append(liStart+input+liEnd);
//								}
//							}
//						});
					$('.validity-tooltip').remove();
					$('.updateDiv').css('display','none');
	    			$('#add_div').css('display','block');
				}
				
//				}
//			});
}
//保存操作
function save_v(){
var addorupdate = $("#addorupdate").val();
var flag = true;
var versionNum = "";
$("input[name=plantAndVersion]").each(function(){
    var value = $(this).val();
    if(value.length==0){
    	$(this).val("请选择版本号");
    	$(this).css('color','red');
    	//$(this).require("请选择版本号");
		flag = false;
    }else{
    	if(value != '请选择版本号'){
    		versionNum = versionNum + value + ",";
    	}else{
    		flag = false;	
    	}
    }
});
//alert(versionNum);
if(flag){
if(addorupdate == 'add'){
$("#a_versionNum").val(versionNum.substring(0,versionNum.length-1));
$('#add_div').css('display','none');
$('.addDiv').css('display','block');
}else{
$("#u_versionNum").val(versionNum.substring(0,versionNum.length-1));
$('#add_div').css('display','none');
$('.updateDiv').css('display','block');
}

}


}

function close_div_choose(){
	$('.validity-tooltip').remove();
	var value = $("#addorupdate").val();
	if(value == 'add'){
		$('#add_div').css('display','none');
	    $('.addDiv').css('display','block');
	}else{
		$('#add_div').css('display','none');
	    $('.updateDiv').css('display','block');
	}
	
    $("input[name=plantAndVersion]").each(function(){
     var value = $(this).val();
    	if(value != '请选择版本号'){
    	 }else{
    	 	$(this).val("");
    	 }
	});
    
    //alert('sad')
}
//--------------------------------------------------------------------------------------------------------------------
</script>

</html>