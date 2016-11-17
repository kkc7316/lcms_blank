<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../common/taglibs.jsp"%>
<html>
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
		} else if(inputId == "employeeNum"){
			_pli.append('账号：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'employeeNum\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		}else if(inputId == "svwCode"){
			_pli.append('SAP供应商编号：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'svwCode\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		}else if(inputId == "employeeName"){
			_pli.append('姓名：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'employeeName\')" >×</font>');
        	_pul.append(_pli); //将其添加到悬浮框中
			$("#"+inputId+"_value").text(inputValue);
			$("#"+inputId+"_query").css("display","block");
		} else if(inputId == "uerRoles"){
			_pli.append('角色：<label>'+inputValue+'</label><font class="font" onclick="closeXunfuXl(this,\'uerRoles\')" >×</font>');
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
    <div class="main_right">
    	 <div class="lbtable1">   
         	<div class="biaoti_title"><span><spring:message code="USER_MANAGE_TITLE"></spring:message></span><span style="float: right; margin-right: 10px;">${synchronousTime}</span></div>   
         	<shiro:hasPermission name="USER_QUERY">
         	<div class="box_btn_seach">
                     <button  class="button2" type="button" id="userList_button2"><spring:message code="QUERY_OPT"></spring:message></button> 
                     <!-- <button  class="button2" type="reset"><img src="image/icon_reset_16_16.png">重置</button>  -->
            	  </div>  
           	</shiro:hasPermission> 
            <div class="condition">
	         	<div class="condition_content">
	         	  <a class="condition_content_font" id="employeeNum_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="ACCOUNT_LAB"></spring:message>：<font id="employeeNum_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.employeeNum">
	                    <div class="error"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="svwCode_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="SUPPLIER_SAP_NUM_LAB"></spring:message>：<font id="svwCode_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.svwCode">
	                    <div class="error"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="employeeName_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="NAME_LAB"></spring:message>：<font id="employeeName_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.employeeName">
	                    <div class="error"></div>
	                </div>
	              </a>
	              <a class="condition_content_font" id="uerRoles_query" style="display:none;position: relative;">
	                <span class="condition_content_font_span"><spring:message code="ROLE_LAB"></spring:message>：<font id="uerRoles_value"></font><font class="font2">X</font></span> 
	            	<div class="seach_xunfu" id="div.uerRoles">
	                    <div class="error"></div>
	                </div>
	              </a>
	            </div>
            </div>
            <div class="clear"></div>
         	<div class="lbtable1_content">
                <ul class="ul_form_col3"> 
                   <li>
                        <span class="span_form_label"><spring:message code="ACCOUNT_LAB"></spring:message>：</span>
                        <div class="div_form_content">
	                        <input class="file_fixed_150px" id="filter.employeeNum" onblur="makeQuery('employeeNum',this.value,this.value)"/>
                        </div>
                   </li>    
                   <li>
                        <span class="span_form_label"><spring:message code="SUPPLIER_SAP_NUM_LAB"></spring:message>：</span>
                        <div class="div_form_content"><input class="file_fixed_150px" id="filter.svwCode" onblur="makeQuery('svwCode',this.value,this.value)"/></div>
                   </li>                  
                    <li>
                        <span class="span_form_label"><spring:message code="NAME_LAB"></spring:message>：</span>
                        <div class="div_form_content"><input class="file_fixed_150px no_upper_case" id="filter.employeeName" onblur="makeQuery('employeeName',this.value,this.value)"/></div>
                   </li>
                    <li>
                        <span class="span_form_label"><spring:message code="ROLE_LAB"></spring:message>：</span>
                        <div class="div_form_content"><input class="file_fixed_150px" id="filter.uerRoles" onblur="makeQuery('uerRoles',this.value,this.value)"/></div>
                   </li>
                   <div style="clear:both;"></div>
                </ul>
            </div>
            <!-- ExtJs表单 -->
            <div id="grid"></div>
         </div>
            
            <div id="bgDiv"></div>
            <!-- 删除弹框开始 -->
				<div class="confim" id="delete_win">
					<p>确认删除选中记录？</p>
					<div class="confim_btn">
						<button class="button2" onclick="doDeleteConfirm()"><spring:message code="SURE_OPT"></spring:message></button>
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>
				<div class="confim" id="select_zero_win">
					<p>请选择一条用户数据</p>
					<div class="confim_btn">
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>
				<div class="confim" id="delete_login_win" style="width:280px;">
					<p>删除用户中存在当前使用用户，确定删除？</p>
					<div class="confim_btn">
						<button class="button2" onclick="deleteLogin()"><spring:message code="SURE_OPT"></spring:message></button>
						<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
					</div>
				</div>
			<!-- 删除弹框结束 -->
			<div id="add_ifa">
	          	 <iframe id="userList_kcpd" src="" width="100%" height="100%" border="0" frameborder="0" framespacing=0></iframe>
	        </div>
        </div>
        <!---->
</body>
<script type="text/javascript">
/* --------------click enter auto query------------ */
function getKey()  
{  
    if(event.keyCode==13){  
    	store.loadPage(1);  
    }     
}  
//页面渲染后执行
var store;
var deleteId = {};
var containerLoginUserFlag = false;
 Ext.onReady(function(){
 	 Ext.tip.QuickTipManager.init();
    //创建一个数据 store
     var itemsPerPage = 10;
     var height = null;
	var loadFlag = false;
	//每一行的高度
	var rowHeight = 27;
    store = new Ext.data.Store({
         	autoLoad: true, //自动读取设成false 是否自动加载数据
		    autoDestroy:true, //store的自动销毁，一定要设置成true
			fields:['id','employeeNum','employeeName','employeeEmail','uerRoles','svwCode','updateStringDate'], //要显示哪些字段
			pageSize: itemsPerPage, //每页显示条数
			remoteSort: false, //是不是服务端排序
			//sorters:[{property:"updateStringDate",direction:"DESC"}],
			 proxy: {
				type: 'ajax',
		        url:'user/userList.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
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
						userGrid.setHeight(height+rowHeight*10);
					}
					else {
						userGrid.setHeight(height+rowHeight*counts);
					}
				}
			}
    });
   	store.on('beforeload', function(store,options){ 
   		if (!loadFlag) {
			height = userGrid.getHeight() + 1;
			loadFlag = true;
		}
   	var employeeNum=document.getElementById("filter.employeeNum").value;
   	var employeeName=document.getElementById("filter.employeeName").value;
   	var svwCode=document.getElementById("filter.svwCode").value;
   	var uerRoles=document.getElementById("filter.uerRoles").value;
   	//var new_params = { "filter.employeeNum": employeeNum};
   	    //命名规范:filter.这样才能解析
        Ext.apply(store.proxy.extraParams, {
		        "filter.employeeNum":employeeNum,
		        "filter.employeeName":employeeName,
		        "filter.svwCode":svwCode,
		        "uerRoles":uerRoles
        });
   	});
   	<shiro:hasPermission name="USER_QUERY">
	$('#userList_button2').click(function(){store.loadPage(1);}); 
	</shiro:hasPermission>
    var tbar = new Ext.Toolbar({  
     items : [
     			<shiro:hasPermission name="USER_ROLE">
				{  
					text : '<font color="silver"><spring:message code="SET_ROLE_OPT"></spring:message></font>',
					cls:'button4_disable',
					id:'userList_setRoleBtn'
				 }, 
				 </shiro:hasPermission>
				 <shiro:hasPermission name="USER_DEL">
				 {  
					 text : '<font color="silver"><spring:message code="DELETE_OPT"></spring:message></font>',  
					 cls:'button4_disable',
					 id:'userList_deleteBtn'
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
		var userGrid=Ext.create('Ext.grid.Panel', {
		store: store,//store数据源
		border:true,
		bodyBorder:false,
		columnLines:true,
		tbar:tbar,  
		frame :false,
		 forceFit: true,//自动填充
		 viewConfig: { enableTextSelection:true },
		 //此代码是设置选择checkBox才能选择该条记录
		 selModel : Ext.create('Ext.selection.CheckboxModel', {
 			 //checkOnly : true
 			 listeners:{
				      'selectionchange':function(sm, selections){
				    	  if(selections.length > 1){
				    		  $('#userList_deleteBtn-btnInnerEl font').attr('color','#545351');
				    		  $('#userList_setRoleBtn-btnInnerEl font').attr('color','silver');
				    		  $("#userList_setRoleBtn").attr("disabled","disabled");
				    		  $("#userList_setRoleBtn").removeClass("button4_disable_hover");
				    		  $("#userList_deleteBtn").removeAttr("disabled");
				    		  $("#userList_deleteBtn").addClass("button4_disable_hover");
				    	  } else if (selections.length == 1){
				    	  		$('#userList_deleteBtn-btnInnerEl font,#userList_setRoleBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#userList_deleteBtn,#userList_setRoleBtn").removeAttr("disabled");
				    		  	$("#userList_deleteBtn,#userList_setRoleBtn").addClass("button4_disable_hover");
				    	  } else {
				    	  		$('#userList_deleteBtn-btnInnerEl font,#userList_setRoleBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#userList_deleteBtn,#userList_setRoleBtn").attr("disabled","disabled");
				    	  		$("#userList_deleteBtn,#userList_setRoleBtn").removeClass("button4_disable_hover");
				    	  }
				      }
				}
 		 }),
		        columns: [
							{
								id:'company',
								header: "<spring:message code="ACCOUNT_LAB"></spring:message>",  
								sortable: true ,
								dataIndex: 'employeeNum',
								align: 'center'
							 },
				            {
					            header: "<spring:message code="NAME_LAB"></spring:message>", 
					            sortable: true , 
					            dataIndex: 'employeeName',
					            align: 'center'
					            
				            },
				            {
					            header: "<spring:message code="SUPPLIER_SAP_NUM_LAB"></spring:message>", 
					             sortable: true, 
					             dataIndex: 'svwCode',
					              align: 'center'
				             },
				            {
					            header: "<spring:message code="ROLE_LAB"></spring:message>", 
					            sortable: true, 
					            dataIndex: 'uerRoles',
					             align: 'center',
					              renderer: function(value, meta) {
					                  if(value){
						                  var max = 20;  //显示多少个字符
					                       meta.tdAttr = 'data-qtip="' + value + '"';
					                       return value.length <= max ? value :value.substring(0, max) + '...';
					                  }else{
					                   	return value;
					                  }
		                       }
				            },
				             {
					            header: "<spring:message code="SYNC_TIME_OPT"></spring:message>", 
					            sortable: true, 
					            dataIndex: 'updateStringDate',
					             align: 'center'
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
  <shiro:hasPermission name="USER_ROLE">
 /*---------------setRoleBtn-------------*/		
	$('#userList_setRoleBtn').click(function(){
		var demoListSelection = userGrid.getSelectionModel().getSelection();
		if(demoListSelection.length == 0||demoListSelection.length > 1){
			return;
		}else{
		    $('#add_ifa,#bgDiv').css('display','block');
			$('#userList_kcpd').attr('src',"<%=path%>/user/addUserRoleInit.do?id="+ demoListSelection[0].data.id);
			
		}
	});
	</shiro:hasPermission>
	<shiro:hasPermission name="USER_DEL">
	/* --------------deleteBtn------------*/
	$('#userList_deleteBtn').click(function(){
    var demoListSelection = userGrid.getSelectionModel().getSelection();
    if (demoListSelection.length == 0) {
    	return;
    } else {
    	var _list = {};
        var long = demoListSelection.length;
        for (var i = 0; i < long; i++) {
          _list[i] = demoListSelection[i].data.id;//将id赋值到list中
        }
        isLoginUser(_list);
      return false;
    }  
	});
	</shiro:hasPermission>
	/* 判断是否删除数据中是否含有当前登录用户 */
function isLoginUser(_list){
    Ext.Ajax.request({
                url: 'user/isLoginUser.do',
                params: {ids: _list },
                method: 'post',
                success: function (response, options) {
               	var data = Ext.decode(response.responseText); 
	               	if(data.success){
	               		deleteComfirm(_list);
	               	}else{
	               		deleteId = _list;
	               		$('#delete_login_win,#bgDiv').css('display','block');
	               	}
                },
                failure: function (data) {
                }
            }); 
}

//显示弹框函数
function deleteComfirm(val){
	deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
	$('#delete_win,#bgDiv').css('display','block');
}
}); 
 function deleteLogin(){
		containerLoginUserFlag=true;
		doDeleteConfirm();
	}
//执行删除的函数
 function doDeleteConfirm(){
 	 Ext.Ajax.request({
          url: 'user/deleteUser.do',
          params: {ids: deleteId },
          method: 'post',
          success: function (response, options) {
        	 if(containerLoginUserFlag){
                 window.location.href="<%=path%>/sso.do";
               }
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
</script>
</html>
