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
		} else if(inputId == "roleName"){
			_pli.append('角色名称：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'roleName\')" >×</font>');
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
}
$(function(){
//条件区域中点击X号执行的函数
	$('.condition_content_font_span .font2').click(function(){
	   //将其父类进行隐藏
	   //$(this).parent().parent().css('display','none');
	    var input_id = $(this).parent().parent().attr("id");
		var qType = input_id.substring(0, input_id.indexOf("_"));
		$("#"+qType+"_query").css("display","none");
		$("#"+qType+"_value").text("");//条件区域赋值
		$("#filter\\."+qType).val(""); //将其输入框中的内容设置为空
		$("#div\\."+qType).children('span').remove(); //删除悬浮框下的所有span 元素
		
	});
})

</script>
</head>
<body>
<form name="loginForm" action="<%=request.getContextPath() %>/role/roleListPage.do" method="post" onreset="resetFunction()">
    <div class="main_right">
    	 <div class="lbtable1">   
         	<div class="biaoti_title"><span><spring:message code="ROLE_MANAGE"></spring:message></span></div>  
         	<shiro:hasPermission name="ROLE_QUERY">
         	<div class="box_btn_seach">
                <button  class="button2" type="button" id="roleList_button2"><spring:message code="QUERY_OPT"></spring:message></button> 
                <!-- <button  class="button2" type="reset"><img src="image/icon_reset_16_16.png">重置</button>  -->
            </div>  
             </shiro:hasPermission>
            <div class="condition">
	         	<div class="condition_content">
	         	  <a class="condition_content_font" id="roleName_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="ROLE_NAME_LAB"></spring:message>：<font id="roleName_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.roleName">
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
                    <li>
                        <span class="span_form_label"><spring:message code="ROLE_NAME_LAB"></spring:message>：</span>
                        <div class="div_form_content"><input class="file_fixed_150px" id="filter.roleName" onblur="makeQuery('roleName',this.value,this.value)"/></div>
                   </li>
                   <div style="clear:both;"></div>
                </ul>
            </div>
                <div id="grid" ></div>
            </div>
        </div>
        <!---->
   </form>
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
		<div class="confim" id="select_zero_win">
			<p>请选择一条角色数据</p>
			<div class="confim_btn">
				<button class="button2 re_btn"><spring:message code="SURE_OPT"></spring:message></button>
			</div>
		</div>
		<div class="confim" id="select_more_win">
			<p>选择较多，请选择一条数据</p>
			<div class="confim_btn">
				<button class="button2 re_btn"><spring:message code="SURE_OPT"></spring:message></button>
			</div>
		</div>
         <div id="add_ifa">
			<iframe id="roleList_kcpd" src="" width="100%" height="100%" border="0" frameborder="0" framespacing=0 ></iframe> 
		</div>
</body>
<script type="text/javascript">
//-----------------------------------------------------------------------
//页面渲染后执行
 var store;
 var deleteId = {};
 Ext.onReady(function(){
    Ext.tip.QuickTipManager.init();
 	var itemsPerPage = 10;
 	var height = null;
	var loadFlag = false;
	//每一行的高度
	var rowHeight = 27;
 
    //创建一个数据 store
    store = new Ext.data.Store({
         	autoLoad: true, //自动读取设成false 是否自动加载数据
		    autoDestroy:true, //store的自动销毁，一定要设置成true
			fields:['id','roleName','createDatetime','roleDesc','resourcesName'], //要显示哪些字段
			pageSize: itemsPerPage, //每页显示条数
			remoteSort: false, //是不是服务端排序
			//sorters : sorters, //服务端排序的条件
			sorters:[{property:"roleCode",direction:"ASC"}],
			 proxy: {
						type: 'ajax',
				        url:'role/roleList.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
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
						roleGrid.setHeight(height+rowHeight*10);
					}
					else {
						roleGrid.setHeight(height+rowHeight*counts);
					}
				}
			}
    });
    /*------------- query condition-------------- */
   	store.on('beforeload', function(store,options){ 
   		if (!loadFlag) {
			height = roleGrid.getHeight()+1;
			loadFlag = true;
		}
	  	var x=document.getElementById("filter.roleName").value;
	  	var new_params = { "filter.roleName": x };
        Ext.apply(store.proxy.extraParams, {"filter.roleName":x});
   	});
   	<shiro:hasPermission name="ROLE_QUERY">
	$('#roleList_button2').click(function(){
		store.loadPage(1);
	}); 
	</shiro:hasPermission>
    var tbar = new Ext.Toolbar({  
   //renderTo : Ext.ux.maximgb.tg.GridPanel.tbar,// 其中grid是上边创建的grid容器
     items : [
    		 	<shiro:hasPermission name="ROLE_ADD">
				{  
					  text : '新 增',
					  cls:'button4',
					  id:'roleList_addBtn'
				 }, 
				 </shiro:hasPermission>
				 <shiro:hasPermission name="ROLE_EDIT">
				 {  
					  text : '<font color="silver"><spring:message code="EDIT_OPT"></spring:message></font>',
					  cls:'button4_disable',
					  id:'roleList_editBtn'   
				 }, 
				  </shiro:hasPermission>
				  <shiro:hasPermission name="ROLE_DEL">
				 {  
					  text : '<font color="silver"><spring:message code="DELETE_OPT"></spring:message></font>',
					  cls:'button4_disable',
					  id:'roleList_deleteBtn'
				}
				</shiro:hasPermission>
			]  
		
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
			var roleGrid = Ext.create('Ext.grid.Panel', {
			store: store,//store数据源
			border:true,
			bodyBorder:false,
			tbar:tbar,  
			columnLines:true,
			frame :false,
			forceFit: true,//自动填充
			viewConfig: { enableTextSelection:true },
			//此代码是设置选择checkBox才能选择该条记录
			selModel : Ext.create('Ext.selection.CheckboxModel', {
	 			//checkOnly : true
	 			listeners:{
				      'selectionchange':function(sm, selections){
				    	  if(selections.length > 1){
				    		  $('#roleList_deleteBtn-btnInnerEl font').attr('color','#545351');
				    		  $('#roleList_editBtn-btnInnerEl font').attr('color','silver');
				    		  $("#roleList_editBtn").attr("disabled","disabled");
				    		  $("#roleList_editBtn").removeClass("button4_disable_hover");
				    		  $("#roleList_deleteBtn").removeAttr("disabled");
				    		  $("#roleList_deleteBtn").addClass("button4_disable_hover");
				    	  } else if (selections.length == 1){
				    	  		$('#roleList_deleteBtn-btnInnerEl font,#roleList_editBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#roleList_deleteBtn,#roleList_editBtn").removeAttr("disabled");
				    		  	$("#roleList_deleteBtn,#roleList_editBtn").addClass("button4_disable_hover");
				    	  } else {
				    	  		$('#roleList_deleteBtn-btnInnerEl font,#roleList_editBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#roleList_deleteBtn,#roleList_editBtn").attr("disabled","disabled");
				    	  		$("#roleList_deleteBtn,#roleList_editBtn").removeClass("button4_disable_hover");
				    	  }
				      }
				}
	 		}),
			columns: [
						{
							id:'company',
							header: "<spring:message code="ROLE_NAME_LAB"></spring:message> ", 
							sortable: true ,
							 align: 'center',
							dataIndex: 'roleName'
						},
			             {
				             header: "<spring:message code="ROLE_DESCRIBE_LAB"></spring:message>", 
				             sortable: true , 
				              align: 'center',
				             dataIndex: 'roleDesc',
				             renderer: function(value, meta) {
				                  if(value){
				                  var max = 10;  //显示多少个字符
			                       meta.tdAttr = 'data-qtip="' + value + '"';
			                       return value.length < max ? value :value.substring(0, max) + '...';
				                  }else{
				                   return value;
				                  }
			                       
		                       }
			             },
			              {
				             header: "<spring:message code="FUNCITON_LAB"></spring:message>", 
				             sortable: true , 
				              align: 'center',
				             dataIndex: 'resourcesName',
				             renderer: function(value, meta) {
				            	  if(value){
				            	  var max = 20;  //显示多少个字符
			                       meta.tdAttr = 'data-qtip="' + value + '"';
			                       return value.length < max ? value :value.substring(0, max) + '...';
				            	  }else{
				            	  	return value;
				            	  }
			                       
		                       }
			             }
			           
			                    ],

			 dockedItems: [
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
			renderTo: 'grid'
			});
	<shiro:hasPermission name="ROLE_EDIT">
/*---------------editBtn-------------*/		
	$('#roleList_editBtn').click(function(){
		var demoListSelection = roleGrid.getSelectionModel().getSelection();
		if(demoListSelection.length == 0||demoListSelection.length > 1){
			return;
		}else{
		    $('#add_ifa,#bgDiv').css('display','block');
		    $('#roleList_kcpd').attr('src',"<%=path%>/role/addRoleInit.do?id="+demoListSelection[0].data.id);
		}
	})
	</shiro:hasPermission>
	<shiro:hasPermission name="ROLE_ADD">
/* 	------------addBtn------------- */
	$('#roleList_addBtn').click(function(){
		$('#add_ifa,#bgDiv').css('display','block');
		$('#roleList_kcpd').attr('src',"<%=path%>/role/addRoleInit.do?id="+'');
	});
	</shiro:hasPermission>
	 <shiro:hasPermission name="ROLE_DEL">
/* --------------deleteBtn------------*/
	$('#roleList_deleteBtn').click(function(){
    var demoListSelection = roleGrid.getSelectionModel().getSelection();
    if (demoListSelection.length == 0) {
    	//$('#select_zero_win,#bgDiv').css('display','block');
    	return;
    } else {
    	var _list = {};
        var long = demoListSelection.length;
        for (var i = 0; i < long; i++) {
          _list[i] = demoListSelection[i].data.id;//将id赋值到list中
        }
        deleteComfirm(_list);
      return false;
    }  
	});
	</shiro:hasPermission>
	//显示弹框函数
	function deleteComfirm(val){
		deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
		$('#delete_win,#bgDiv').css('display','block');
		
	}
}); 
//执行删除的函数
	function doDeleteConfirm(){
		 Ext.Ajax.request({
	         url: 'role/deleteRole.do',
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
/*--------------refresh--------------------------  */
function refresh(){
	store.load();
}
/* --------------click enter auto query------------ */
function getKey()  
{  
    if(event.keyCode==13){  
    	store.loadPage(1);  
    }     
}  
/* ---------------resetBtn--------------------- */
function resetFunction(){
 	$(".select_fixed_145px").next().find(".selectyzeValue").html("全部");
}

//--------------------------------------------------------------------------------------------------------------------
</script>
</html>
