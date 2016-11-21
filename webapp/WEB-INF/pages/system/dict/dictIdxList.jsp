<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<html>
<head>
<base href="<%=basePath%>"></base>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />

<link rel="icon" href="image/favicon.ico">
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="css/global.css" />
<link type="text/css" rel="stylesheet" href="css/layout.css" />
<link rel="stylesheet" href="selectyze/selectyze.jquery.css" type="text/css" />
<script language="javascript" type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="selectyze/selectyze.jquery.min.js"></script>
<script type="text/javascript" src="js/other/laydate-master/laydate.js"></script>

<link rel="stylesheet" href="css/jquery.validity.css" type="text/css"></link>
<script type="text/javascript" src="js/other/autoMultiple/autoMultiple.js"></script> 
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript" src="js/jquery.blockUI.js"></script>
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/ext-theme-classic-all.css" />
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/all2.css" />

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
		} else if(inputId == "dictName"){
			_pli.append('字典名称：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'dictName\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} else if(inputId == "dictKey"){
        	_pli.append('字典代码：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'dictKey\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		}else if(inputId == "isSystemConfig"){
			_pli.append('是否系统配置：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'isSystemConfig\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		}
	}
	//悬浮框中点击X执行的函数   下拉框函数执行的
function closeXunfuXl(font,_id){
	if(_id == "isSystemConfig"){
		var options = $("#filter\\.isSystemConfig option[value='alls']");
		$("#filter\\.isSystemConfig").val(options[0].value);
		$("#isSystemConfig").val(options[0].text);
   		$("#isSystemConfig").next().find(".selectyzeValue").html(options[0].value);
	}
	$(font).parent().remove();
	$("#"+_id+"_query").css("display","none");//隐藏
	$("#filter\\."+_id).val("");//输入框数值清空
	
}
$(function(){
//条件区域中点击X号执行的函数
	$('.condition_content_font_span .font2').click(function(){
	
	   //将其父类进行隐藏
	   //$(this).parent().parent().css('display','none');
	   var input_id = $(this).parent().parent().attr("id");
		var qType = input_id.substring(0, input_id.indexOf("_"));
	   if(qType == "isSystemConfig"){
			var options = $("#filter\\.isSystemConfig option[value='alls']");
			$("#filter\\.isSystemConfig").val(options[0].value);
			$("#isSystemConfig").val(options[0].text);
	   		$("#isSystemConfig").next().find(".selectyzeValue").html(options[0].value);
		}else{
			$("#filter\\."+qType).val(""); //将其输入框中的内容设置为空
			$("#div\\."+qType).children('span').remove(); //删除悬浮框下的所有span 元素
		}
		$("#"+qType+"_query").css("display","none");
		$("#"+qType+"_value").text("");//条件区域赋值
	});
})
function colseCancel(){
   $("#dictIdx_kcpd").attr("src","about:blank");
}
</script>
</head>
<body>
	<div class="main_right">
		<div class="lbtable1">
			<div class="biaoti_title">
				<span class="font_style"><spring:message code="DICT_MANAGE"></spring:message>
				</span>
			</div>
			<form>
				<shiro:hasPermission name="DICT_QUERY">
				<div class="box_btn_seach">
					<button class="button2" type="button" id="dictIdx_btn_query">
						<spring:message code="QUERY_OPT"></spring:message>
					</button>
					
					<%-- <button class="button2" type="button" type="reset"><spring:message code="RESET_OPT"></spring:message></button> --%>
			
				</div>
				</shiro:hasPermission>
				<div class="condition">
	         	<div class="condition_content">
	         	  <a class="condition_content_font" id="dictName_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span">字典名称：<font id="dictName_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.dictName">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="dictKey_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span">字典代码：<font id="dictKey_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.dictKey">
	                    <div class="error"></div>
	                    <div class="left_top"></div>
	                    <div class="right_top"></div>
	                    <div class="left_bottom"></div>
	                    <div class="right_bottom"></div>
	                </div>
	              </a>
	               <a class="condition_content_font" id="isSystemConfig_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span">是否系统配置：<font id="isSystemConfig_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.isSystemConfig">
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
					<ul class="ul_form">
						<li><span class="span_form_label"><spring:message code="DICT_NAME_LAB"></spring:message>：</span>
							<div class="div_form_content">
								<input class="file_fixed_150px" id="filter.dictName" onblur="makeQuery('dictName',this.value,this.value)"/>
							</div>
						</li>
						<li><span class="span_form_label"><spring:message code="DICT_CODE_LAB"></spring:message>：</span>
							<div class="div_form_content">
								<input class="file_fixed_150px" id="filter.dictKey" onblur="makeQuery('dictKey',this.value,this.value)"/>
							</div>
						</li>
						<li><span class="span_form_label"><spring:message code="DICT_CODE_IFSYS"></spring:message>：</span>
							<div class="div_form_content">
							<div style="float:left;" class="xllba">
<!--								<input class="file_fixed_150px" id="filter.dictKey" onblur="makeQuery('dictKey',this.value,this.value)"/>-->
									<select class="select_fixed_145px" id="filter.isSystemConfig" title="isSystemConfig" onchange="makeQuery('isSystemConfig',this.value,this.options[this.selectedIndex].text)">
                                <option value="alls">全部</option>
                                	<option value="0">否</option>
								    <option value="1">是</option>
                            </select>
                            </div>
							</div>
						</li>
						<div style="clear:both;"></div>
					</ul>
				</div>
				<div id="grid"></div>
			</form>
		</div>
	</div>
	<div id="bgDiv2"></div>
	<div id="bgDiv"></div>
	<!-- delete_win -->
    <!-- 删除弹框开始 -->
		<div class="confim" id="delete_win">
			<p>确认删除选中记录？</p>
			<div class="confim_btn">
				<button class="button2" onclick="doDeleteConfirm()"><spring:message code="SURE_OPT"></spring:message></button>
				<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
			</div>
		</div>
	<!-- 删除弹框结束 -->
	<div class="confim" id="select_win">
		<p>请选择一条记录</p>
		<div class="confim_btn">
			<button class="button2 re_btn">
				<spring:message code="SURE_OPT"></spring:message>
			</button>
		</div>
	</div>
	<div class="confim" id="select_win2">
		<p>选择较多，请选择一条记录</p>
		<div class="confim_btn">
			<button class="button2 re_btn">
				<spring:message code="SURE_OPT"></spring:message>
			</button>
		</div>
	</div>
	<!-- 新增弹窗 -->
	<div id="add_ifa" style='position: fixed;'>
		<iframe id="dictIdx_kcpd" src="" width="100%" height="100%" border="0"
			frameborder="0" framespacing=0></iframe>
	</div>
</body>

<script type="text/javascript">

function close_div(){
	$('#bgDiv,#add_ifa').css('display','none');
}

var store;
var grid;
//-----------------------------------------------------------------------
//页面渲染后执行
 Ext.onReady(function(){
 		Ext.tip.QuickTipManager.init();
		function change(val) {
			if (val > 0) {
				return '<span style="color:green;">' + val + '</span>';
			} else if (val < 0) {
				return '<span style="color:red;">' + val + '</span>';
			}
			return val;
		}
		function pctChange(val) {
			if (val > 0) {
				return '<span style="color:green;">' + val + '%</span>';
			} else if (val < 0) {
				return '<span style="color:red;">' + val + '%</span>';
			}
			return val;
		}
		var itemsPerPage = 10;
		var height = null;
		var loadFlag = false;
		//每一行的高度
		var rowHeight = 27;
		
		//创建一个数据 store
		store = new Ext.data.Store({
			autoLoad : true, //自动读取设成false 是否自动加载数据
			autoDestroy : true, //store的自动销毁，一定要设置成true
			fields : ['id', 'dictName', 'dictKey','isSystemConfig', 'remark' ], //要显示哪些字段
			pageSize : itemsPerPage, //每页显示条数
			remoteSort : false, //是不是服务端排序
			//sorters : sorters, //服务端排序的条件
			//sorters:[{property:"containerNum",direction:"ASC"}],
			proxy : {
				type : 'ajax',
				url : 'dictIdxList.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
				actionMethods : {
					read : 'POST'
				},
				reader : {
					type : 'json',
					totalProperty : 'totalCount',
					root : 'root'
				}
			},
			listeners:{
				load:function(records, options, success){
					var counts = records.getCount();
					if (counts < 10) {
						grid.setHeight(height+rowHeight*10);
					}
					else {
						grid.setHeight(height+rowHeight*counts);
					}
				}
			}
		});
		
		store.on('beforeload', function(store, options) {
			if (!loadFlag) {
				height = grid.getHeight()+1;
				loadFlag = true;
			}
		     $("#relay").attr("src","about:blank");
			var name = document.getElementById("filter.dictName").value;
			var key = document.getElementById("filter.dictKey").value;
			var isSystemConfig = document.getElementById("filter.isSystemConfig").value;
			if(isSystemConfig == 'alls'){
				isSystemConfig = null;
			}
			Ext.apply(store.proxy.extraParams, { "filter.dictName" : name
			,"filter.dictKey" : key,"filter.isSystemConfig" : isSystemConfig
			});
		});
		<shiro:hasPermission name="DICT_QUERY">
		$('#dictIdx_btn_query').click(function(){
			store.loadPage(1);
		});
		</shiro:hasPermission>
		var tbar = new Ext.Toolbar({
			//renderTo : Ext.ux.maximgb.tg.GridPanel.tbar,// 其中grid是上边创建的grid容器
			items : [
//			<shiro:hasPermission name="DICT_ADD">
//			 {
//				text : '新 增',
//				cls:'button4',
//				id:'dictIdx_addBtn'
//				
//			 },
//			 </shiro:hasPermission>
			 <shiro:hasPermission name="DICT_EDIT">
			 {
				text : '<font color="silver"><spring:message code="EDIT_OPT"></spring:message></font>',
				cls:'button4_disable',
				id : 'dictIdx_editBtn'
			 }
			 </shiro:hasPermission>
//			  <shiro:hasPermission name="DICT_DEL">
//			 {
//				//text : '<font color="silver">删除</font>',
//				text : '<font color="silver"><spring:message code="DELETE_OPT"></spring:message></font>',
//				cls:'button4_disable',
//				id : 'dictIdx_deleteBtn'
//			 }
//			  </shiro:hasPermission>
			]
		});

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
		//创建grid表格
		grid = Ext.create('Ext.grid.Panel', {
			//title:'EXT表格测试',//标题 
			id:'dictIdxListPanel',
			store : store,//store数据源
			border : false,
			bodyBorder : false,
			columnLines:true,
			tbar : tbar,
			//bbar:{xtype:"pagingtoolbar",store: store,displayInfo:true}, //可以取代 dockedItems
			frame : false,
			viewConfig: { enableTextSelection:true },
			forceFit : true,//自动填充
			//此代码是设置选择checkBox才能选择该条记录
			selModel : Ext.create('Ext.selection.CheckboxModel', {
	 			//checkOnly : true
	 			listeners:{
				      'selectionchange':function(sm,selections){
				    	  if(selections.length > 1){
				    		  $('#dictIdx_deleteBtn-btnInnerEl font').attr('color','#545351');
				    		  $('#dictIdx_editBtn-btnInnerEl font').attr('color','silver');
				    		  $("#dictIdx_editBtn").attr("disabled","disabled");
				    		  $("#dictIdx_editBtn").removeClass("button4_disable_hover");
				    		  $("#dictIdx_deleteBtn").removeAttr("disabled");
				    		  $("#dictIdx_deleteBtn").addClass("button4_disable_hover");
				    	  } else if (selections.length == 1){
								var demoListSelection = grid.getSelectionModel().getSelection();
								if(demoListSelection[0].data.isSystemConfig!=1){
					    	  		$('#dictIdx_deleteBtn-btnInnerEl font,#dictIdx_editBtn-btnInnerEl font').attr('color','#545351');
					    		  	$("#dictIdx_deleteBtn,#dictIdx_editBtn").removeAttr("disabled");
					    		  	$("#dictIdx_deleteBtn,#dictIdx_editBtn").addClass("button4_disable_hover");
				    		  	}
				    	  } else {
				    	  		$('#dictIdx_deleteBtn-btnInnerEl font,#dictIdx_editBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#dictIdx_deleteBtn,#dictIdx_editBtn").attr("disabled","disabled");
				    	  		$("#dictIdx_deleteBtn,#dictIdx_editBtn").removeClass("button4_disable_hover");
				    	  }
				      }
				}
	 		}),
			columns : [ 
			{
				dataIndex : 'id',
				hidden:true
			},{
				header : "字典名称",
				sortable : true,
				dataIndex : 'dictName',
				align: 'center',
				 renderer:function(value,metaData,record){
				 
				var dictKey=record.get("dictKey");
//				alert(dictKey);
				var dictId=record.get("id");
//				alert(dictKey);
				return '<a href="javascript:void(0)" onClick = "details(\''+dictKey+'\')" style="text-decoration:underline;color: blue;">'+value+'</a>';
//				return "<a href=\"detailDictIdx.do?dictId="+dictId+"\" target=\"content\" style=\"text-decoration:underline;color: blue;\">"+value+"</a>";
				} 
			},
			{
				header : "字典代码",
				sortable : true,
				dataIndex : 'dictKey',
				align: 'center'
			}, 
			{
				header : "是否系统配置",
				sortable : true,
				dataIndex : 'isSystemConfig',
				align: 'center',
				renderer: function(value){
                			if (value==1) {
                				return "是";
                			}
							return "否";
        			   }
			}, 
			{
				header : "字典描述",
				sortable : true,
				dataIndex : 'remark',
				align: 'center',
				renderer: function(value, metaData){
                			if (value) {
                				if(value.length>100){
                					metaData.tdAttr='data-qtip="'+value.substring(0,100)+'...(更多内容点击明细查看)"';
                				}else{
                					metaData.tdAttr='data-qtip="'+value+'"';
                				}
                			}
							return value;
        			   }
			} ],
			dockedItems : [ {
				id : 'pagingbar',
				xtype : 'pagingtoolbar',
				dock : 'bottom',
				store : store,
				pageSize : 10,
				displayInfo : true,
				beforePageText : '第',
				afterPageText : '/{0}页',
				firstText : '首页',
				prevText : '上一页',
				nextText : '下一页',
				lastText : '尾页',
				displayMsg : '显示 第 {0} 条 到 第 {1} 条 记录，共 {2} 条记录',
				emptyMsg : '无记录',
				items : [ '-', '每页显示', combo, '条' ]
			} ],
			renderTo : 'grid'
		});
	<shiro:hasPermission name="DICT_ADD">
	//新增按钮
	$('#dictIdx_addBtn').click(function(){
			$('#add_ifa,#bgDiv').css('display','block');
		    $('#dictIdx_kcpd').attr('src',"<%=path%>/addDictIdx.do");
	});
	</shiro:hasPermission>
	<shiro:hasPermission name="DICT_EDIT">
	//编辑按钮
	$('#dictIdx_editBtn').click(function(){
		var demoListSelection = grid.getSelectionModel().getSelection();
		if(demoListSelection.length == 0||demoListSelection.length > 1 ){
			return;
		}else if(demoListSelection.length == 1 && demoListSelection[0].data.isSystemConfig==1){
			return;
		}else{
			$('#add_ifa,#bgDiv').css('display','block');
		    $('#dictIdx_kcpd').attr('src',"<%=path%>/detailDictIdx.do?dictKey="+ demoListSelection[0].data.dictKey);
		}
		});
		 </shiro:hasPermission>
	<shiro:hasPermission name="DICT_DEL">
		//删除按钮
	    $('#dictIdx_deleteBtn').click(function(){
	         var demoListSelection = grid.getSelectionModel().getSelection();
	    if (demoListSelection.length == 0) {
	    	//$('#select_win,#bgDiv').css('display','block');
	    	return;
	    } else {
	    	var _list = "";
	        var long = demoListSelection.length;
	        for (var i = 0; i < long; i++) {
		        if(_list==""){
		        	_list="{ "+demoListSelection[i].data.id ;//将id赋值到list中
		        }else{
		        	_list+=","+demoListSelection[i].data.id;
		        }
	        }
	         _list=_list+" }";
	        deleteComfirm(_list);
	      return false;
	    }  
	    });
	    </shiro:hasPermission>
	 });   
	 
	 //显示弹框函数
	function deleteComfirm(val){
		deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
		$('#delete_win,#bgDiv').css('display','block');
		
	}
	 //执行删除的函数
	     function doDeleteConfirm(){
	     	 Ext.Ajax.request({
	              url: 'doDelDictIdx.do',
	              params: {dictIdxIds: deleteId },
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
	     function details(dictKey){
	 		$('#add_ifa,#bgDiv2').css('display','block');
		    $('#dictIdx_kcpd').attr('src',"<%=path%>/dictIdxDetail.do?dictKey="+ dictKey);
	     }
		//刷新函数
	     function refresh(){
	     	store.load();
	     }
	//点击ENTER执行导入函数
	function getKey() {
		if (event.keyCode == 13) {
			store.loadPage(1);
		}
	}
</script>
</html>
