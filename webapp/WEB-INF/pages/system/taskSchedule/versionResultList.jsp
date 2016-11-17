<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<title>上海大众汽车</title>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link type="text/css" rel="stylesheet" href="css/layout.css" />
<link rel="stylesheet" href="js/selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/selectyze/selectyze.jquery.min.js"></script>
 <script type="text/javascript" src="<%=basePath%>/other/laydate-master/laydate.dev.js"></script>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/validity/jquery.validity.js"></script>
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/ext-theme-classic-all.css" />
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/all2.css" />
<link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
<script type="text/javascript">
//下拉框选中的值显示在条件区域中
function makeQuery(inputId,inputValue,gridIndex) {
		var versionNum =  $("#versionNum").val();
		var _pul = $("#div\\."+inputId);
		_pul.html("<div class=\"error\"></div>"+
		                    "<div class=\"left_top\"></div>"+
		                    "<div class=\"right_top\"></div>"+
		                    "<div class=\"left_bottom\"></div>"+
		                    "<div class=\"right_bottom\"></div>");
        $("#div\\."+inputId).css("display","none"); //将其悬浮框隐藏
        $(".span_" + inputId).remove();
       if(versionNum.length > 0){ //表名版本号之前有值
	        var versionNum =  $("#versionNum").val();
	        var versionIndex =  $("#versionIndex").val();
			var arr = versionNum.split(",");
			var arrIndex = versionIndex.split(",");
			$("#div\\."+inputId).children('span').remove(); //删除悬浮框下的所有span 元素
			var data = "";
			var i=0;
	        for(;i<arr.length;i++){
	        	var _pli = $('<span></span>');//创建一个span
		       	  _pli.attr("class", "span_" + inputId);
			      _pli.append('版本号：<label>'+arr[i]+'</label><font class="font" onclick="closeXunfuXl(this,\'plant\','+arr[i].substring(0,4)+','+arrIndex[i]+')" >×</font>');
			      _pul.append(_pli); //将其添加到悬浮框中
			      data = data + "," + arr[i].substring(0,4);
	        }
	        
	       if(!checkIsCunZai(inputId, inputValue)){
	       	var _pli = $('<span></span>');//创建一个span
	       	  _pli.attr("class", "span_" + inputId);
		      _pli.append('版本号：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'plant\','+inputValue.substring(0,4)+','+gridIndex+')" >×</font>');
		      _pul.append(_pli); //将其添加到悬浮框中
		      versionNum = versionNum + "," + inputValue;
		      versionIndex = versionIndex + "," +gridIndex;
		      data = data + ","+ inputValue.substring(0,4);
	       } 
	       $("#"+inputId+"_value").text(data.substring(1,data.length)); //重新赋值
       } else { //没有值表示是第一次进行赋值
	       var _pli = $('<span></span>');//创建一个span
	        _pli.attr("class", "span_" + inputId);
	        _pli.append('版本号：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'plant\','+inputValue.substring(0,4)+','+gridIndex+')" >×</font>');
	        _pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue.substring(0,4));
			versionNum = inputValue;
			versionIndex = gridIndex;
       }
      $("#versionIndex").val(versionIndex);
      $("#versionNum").val(versionNum);
      $("#"+inputId+"_query").css("display","block");
}

	//悬浮框中点击X执行的函数   下拉框函数执行的
function closeXunfuXl(font,_id,indexNum,gridIndex){
	if($(font).parent().parent().children().length == 6) {
		$(font).parent().remove();
		$(font).parent().parent().css("display","none");
	} else {
		$(font).parent().remove();
	}
	var array = [];
	var arrayIndex = [];
	var arrayVersionNum = [];
	var array1 = $("#"+_id+"_value").text().split(",");//重新赋值给输入框
	var versionIndex =  $("#versionIndex").val().split(",");
	var versionNum =  $("#versionNum").val().split(",");
	var j = 0;
	for(var i = 0; i < array1.length; i++) {
		if($.trim(indexNum) != "" && $.trim(array1[i])!= "") {
			if(array1[i] == indexNum){
			  continue;
			} else {
			  array[j] = $.trim(array1[i]);
			  arrayIndex[j] = $.trim(versionIndex[i]);
			  arrayVersionNum[j] = $.trim(versionNum[i]);
			}
			j++;
		}
	}
	if(store.currentPage != 1){
		if(((store.currentPage) * 10) <= gridIndex && gridIndex < Number(((store.currentPage) * 10) +10)) {
		   var index = gridIndex % 10;
		   checkboxMel.deselect(index,true);
		}
	} else {
		if(((store.currentPage-1) * 10) <= gridIndex && gridIndex < Number(((store.currentPage-1) * 10) +10)) {
		   var index = gridIndex % 10;
		   checkboxMel.deselect(index,true);
		}
	}
	
	 // 设定显示域
	if(array.length > 0) {
	  var data = array.join(",");
	  $("#"+_id+"_value").text(data + ",");//重新赋值给输入框
	  $("#versionNum").val(arrayVersionNum.join(","));
	  $("#versionIndex").val(arrayIndex.join(","));
    } else {
      $("#versionIndex").val("");
      $("#versionNum").val("");
  	  $("#"+_id+"_value").text("");//条件区域赋值
	  $("#"+_id+"_query").css("display","none");//隐藏
    }
}

$(function(){
//条件区域中点击X号执行的函数
	$('.condition_content_font_span .font2').click(function(){
	    var input_id = $(this).parent().parent().attr("id");
		var qType = input_id.substring(0, input_id.indexOf("_"));
		$("#div\\."+qType).children('span').remove(); //删除悬浮框下的所有span 元素
		$("#"+qType+"_query").css("display","none");
		$("#"+qType+"_value").text("");//条件区域赋值
		checkboxMel.deselectAll(true);
		$("#versionNum").val("");
	});
})

	//判断值是否存在
	function checkIsCunZai(qType, str){
		var result = false;
		//var versionNum =  $("#versionNum").val();
		var versionNum = $("#plant_value").text();
		var arr = versionNum.split(",");
        for(var i=0;i<arr.length;i++){
		 if(jQuery.trim(arr[i])==jQuery.trim(str.substring(0,4))) {
		      result = true;
		 }
		}
        return result;
	}
	
		//悬浮框中点击X执行的函数   下拉框函数执行的
function closeDeSelect(_id,indexNum){
	var array = [];
	var arrayIndex = [];
	var arrayVersionNum = [];
	var array1 = $("#"+_id+"_value").text().split(",");//重新赋值给输入框
	var versionIndex =  $("#versionIndex").val().split(",");
	var versionNum =  $("#versionNum").val().split(",");
	var j = 0;
	for(var i = 0; i < array1.length; i++) {
		if($.trim(indexNum) != "" && $.trim(array1[i])!= "") {
			if(array1[i] == indexNum){
			  continue;
			} else {
			  array[j] = $.trim(array1[i]);
			  arrayIndex[j] = $.trim(versionIndex[i]);
			  arrayVersionNum[j] = $.trim(versionNum[i]);
			}
			j++;
		}
	}
	// 设定显示域
	if(array.length > 0) {
	  var data = array.join(",");
	  $("#"+_id+"_value").text(data + ",");//重新赋值给输入框
	  $("#versionNum").val(arrayVersionNum.join(","));
	  $("#versionIndex").val(arrayIndex.join(","));
    } else {
      $("#versionIndex").val("");
      $("#versionNum").val("");
  	  $("#"+_id+"_value").text("");//条件区域赋值
	  $("#"+_id+"_query").css("display","none");//隐藏
    }
}
</script>
</head>
<body style="background-color: rgb(249,249,249);" onload="this.focus()">
<div class="main_right" style="border:none;">
    <!-- 零件周预测 历史结果 -->
    <input type="hidden" id = "versionId" name = "versionId" value = "${versionId}"/>
    <input type="hidden" id ="versionNum" name = "versionNum"/>
    <input type="hidden" id ="versionIndex" name = "versionIndex"/>
    <input type="hidden" id ="plant_id" name = "plant" value="${plant}"/>
    <div class="lbtable1" style="border:none;">
        <div class="biaoti_title"><span></span>版本号
        </div>
        <div class="box_btn_seach">
              <button  class="button2" type = 'button' id="searchBtn">查 询</button>
         </div>
         <div class="condition">
         	<div class="condition_content">
         	   <a class="condition_content_font" id="plant_query" style="display:none;position: relative;">
	        	      <span class="condition_content_font_span">工厂：<font id="plant_value"></font><font class="font2">X</font></span> 
	        	        <div class="seach_xunfu" id="div.plant">
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
        <div class="lbtable1_content">
            <ul class="ul_form_col3">
<!--            	<li>-->
<!--                    <span class="span_form_label"><font class="xh">*</font>工厂：</span>-->
<!--                    <div class="div_form_content">-->
<!--                        <div style="float:left;" class="xllba xllba_width">-->
<!--	                       	 <select class="select_fixed_145px" name="taskPlant" id="filter.factoryNum" title="factoryNum">-->
<!--	                                <option value=''>请选择</option>-->
<!--	                              <c:forEach items="${dictPlant}" var="map">-->
<!--								    <option value="${map.key}">${map.key}</option>-->
<!--								  </c:forEach>-->
<!--	                         </select>-->
<!--	                     </div>-->
<!--                    </div>-->
<!---->
<!--                </li>-->
                <li>
                    <span class="span_form_label">
                                                                                             导入日期：
                    </span>
                    <div class="div_form_content">
                        <input class="file_fixed_150px riqi" id="versionDate"/>
                    </div>

                </li>
                <li>
                    <span class="span_form_label">
                                                                                               零件预测版本号：
                    </span>
                    <div class="div_form_content">
                        <input class="file_fixed_150px" id="partVersion"/>
                    </div>
                </li>
                 
                <div style="clear:both;"></div>
            </ul>
         </div>
        <div id="grid" style="margin-top:10px;"></div>
        <div class="srnr" style="text-align:center;">
        	<!-- 选择 -->
            <button  class=" button2" type="button" onclick="setVersion()"><spring:message code="CHOOSE_OPT"></spring:message></button>
            <!-- 取消 -->
            <a  class=" button3"   onclick="cancelVersion()" > <spring:message code="CANCEL"></spring:message></a>
        </div>
    </div>
    	<div id="bgDiv"></div>
        <div class="confim" id="select_win">
        	<p>请选择一条记录！</p>
	        <div class="confim_btn">
	            <button  class="button2 re_btn" ><spring:message code="SURE_OPT"></spring:message></button>
	        </div>
    	</div>
    	<div class="confim" id="must_one">
        	<p>选择较多，请选择一条数据！</p>
	        <div class="confim_btn">
	            <button  class="button2 re_btn" ><spring:message code="SURE_OPT"></spring:message></button>
	        </div>
    	</div>
</div>

<!---->
<script type="text/javascript">
//调节高度
$(window.parent.document).find("#taskSchedule_kcpd").css("height",$(".main_right").height()+ 320 );
var store;
var versionGird;
var checkboxMel;
//-----------------------------------------------------------------------
    Ext.onReady(function(){
        //创建一个数据 store
         store = new Ext.data.Store({
         	autoLoad: true, 
		    autoDestroy:true, 
			fields:['versionDate','partVersion','plant'], 
			pageSize: 10, 
			remoteSort: false, 
			 proxy: {
				type: 'ajax',
		        url:'forecastWeek/versionLists.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
		        actionMethods: {
		      			read: 'POST'
		        },
		        reader: {
		            type: 'json',
		            totalProperty: 'totalCount',
		            root: 'root'
		        }
		  	} 
    });
   	store.on('beforeload', function(store,options){ 
	   	var versionDate=document.getElementById("versionDate").value;
	   	var partVersion=document.getElementById("partVersion").value;
	   	//var plantVersion=document.getElementById("factoryNum").value;
//	   	var plantVersion=document.getElementById("factoryNum").value;
	   	var plant = document.getElementById("plant_id").value;
//	   	alert(plant);
//		plantVersion = getSelectValueFromText("factoryNum", plantVersion);
//		if(plantVersion == '请选择'){
//			plantVersion = null;
//		}
	    Ext.apply(store.proxy.extraParams, {"versionDate":versionDate,"partVersion":partVersion,"packgeVersion":null,"plant":plant});
   	});
    $('#searchBtn').click(function(){
//        $(".validity-tooltip").remove();
//	   	$("#factoryNum").requireSelect("请选择");	
//	   	if($(".validity-tooltip").length==0){
			store.loadPage(1);
//		}
	}); 
        
      /*-------------分页选择combox-------------*/
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
		
	   //grid前面的复选框
	   checkboxMel = Ext.create('Ext.selection.CheckboxModel', {
	   			showHeaderCheckbox:false,
	 			checkOnly : true,
	 			listeners:{
	 				  'beforeselect':function(model,record,index) {
		 				   if(checkIsCunZai('plant', record.data.plant)){
					    	  	showMsg2("选择重复，请重新选择版本号");
					    	  	return false;
					    	} else {
					    	 	return true;
					    	}
	 				  },
		 			  'deselect': function(model,record,index) {//取消选中时产生的事件
						closeDeSelect('plant',record.data.plant);
					  },
				      'selectionchange':function(sm, selections){
				      	  var index = 0;
					      index = parseInt((store.currentPage-1) * 10);
				    	  if (selections.length == 1){ //直接取第一个值
				    	    //$("#versionNum").val(""); //进行重新赋值为空
				    	    $("#versionNum").val(selections[0].data.partVersion);
//				    	  	makeQuery('plant',selections[0].data.partVersion,Number(selections[0].index+index));
				    	  } else if (selections.length > 1){
//				    	  	showMsg2("选择版本号过多");
//				    	  	
//				    	  	return false;
				    	  	$.each(selections, function(i){
				    	  		$("#versionNum").val(selections[i].data.partVersion+",");
//				    	  	  makeQuery('plant',selections[i].data.partVersion,Number(selections[i].index+index));
				    	    });
				    	  }
				      }
				}
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
        // 表格
        versionGird = Ext.create('Ext.grid.Panel', {
            store: store,
            forceFit: true,//自动填充
            viewConfig:{
                autoFill:true
            },
            height:300,
            scroll :'both',
            hscroll:'true',
            columnLines:true,
            //此代码是设置选择checkBox才能选择该条记录
			selModel : checkboxMel,
            columns: [
            	{
                    header: "工厂",
                    sortable: true,
                    dataIndex: 'plant',
                    align:'center'
                },
            	{
                    header: "导入日期",
                    sortable: true,
                    dataIndex: 'versionDate',
                    align:'center'
                },
                {
                    header: "零件预测版本号",
                    sortable: true,
                    dataIndex: 'partVersion',
                    align:'center'
                }
            ],

            dockedItems: [   ////翻页
                {
                    id : 'pagingbar',
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
            renderTo: 'grid',
            stripeRows: true,
            title:''
        });
        //实现双击可选择,暂时隐藏
        //versionGird.addListener('itemdblclick', setVersion, this);
    });

    //--------------------------------------------------------------------------------------------------------------------
function refresh(){
	store.load();
}
function getKey()  
{  
    if(event.keyCode==13){
    	store.loadPage(1);  
    }     
}  

var versionId = $("#versionId").val();
function cancelVersion(){
	//关闭本div
	window.parent.close_div();
	//隐藏relay
	$(window.parent.document).find('#taskSchedule_kcpd').attr('src','about:blank');
	$(window.parent.document).find('#add_div').css('display','none');
	
	if(versionId =='add') {
		//显示add
		$(window.parent.document).find('#add_ifa').css('display','none');
		$(window.parent.document).find('#add_div,#bgDiv').css('display','block');
	}
	else if (versionId == 'edit') {
		//显示edit
		$(window.parent.document).find('.updateDiv,#bgDiv').css('display','block');
	}
	
}

function setVersion(){
//	alert(versionId);
    //var demoListSelection = versionGird.getSelectionModel().getSelection();
    var versionNum =  $("#versionNum").val();
//    alert(versionNum);
    var plant =  $("#plant_id").val();
//    alert(versionNum);
	var arr = versionNum.split(",");
//	alert(arr.length);
    if (versionNum == '') {
        //$('#select_win,#bgDiv').css('display','block');
        showMsg2("请选择一条记录");
      	return false;
    } else if(arr.length > 1){
        showMsg2("选择较多，请选择一条数据");
      	return false;
    } else if(arr.length == 1){
    	//var ver;
    	//ver = demoListSelection[0].data.partVersion;//将id赋值到list中
    	window.parent.setVersion(versionId, versionNum,plant);
    }  
    
	window.parent.close_div();
	$(window.parent.document).find('#relay').attr('src','about:blank');
	
	$(window.parent.document).find('#add_ifa').css('display','none');
	//$(window.parent.document).find('.addDiv,#bgDiv').css('display','block');
	if(versionId =='add') {
		//显示add 
//		$(window.parent.document).find('.addDiv,#bgDiv').css('display','block');
		$(window.parent.document).find('#add_div,#bgDiv').css('display','block');
	}
	else if (versionId == 'edit') {
		//显示edit
		$(window.parent.document).find('.updateDiv,#bgDiv').css('display','block');
	}
	store.removeAll(); 
}
//条件区域的时间配置
var start = {
    elem: '#versionDate',
    format: 'YYYY-MM-DD',
    istoday: true
};
laydate(start);

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
</script>
</body>
</html>
