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
<style type= "text/css">
	.child-row .x-grid-cell { background-color: #E8E8E8;  }
</style>
</head>
<body style="background-color: rgb(249,249,249);">
    <div class="main_right">
    	<iframe name="hiddenIframe" style="display:none;"></iframe>
    <!---->
    <form target="hiddenIframe" action="saveOrUpdateDictIdx.do" method="post" name="dictform" id="dictform" target="hiddenIframe">
    	<div class="lbtable1 lbtable1_tan">
         	<div class="biaoti_title biaoti_title_tan"><span class="font_style"><spring:message code="DICT_MANAGE"></spring:message></span></div>
         	<div class="lbtable1_content lbtable1_content_tan">
	            <ul class="ul_form">
	                <li>
	                    <span class="span_form_label"><font class="xh"></font><spring:message code="DICT_NAME_LAB"></spring:message>：</span>
	                    <div class="div_form_content">
	                    	<input class="file_fixed_150px" value="${model.dictName}" name="dictName" id="dictName" <c:if test="${model.isSystemConfig=='1'}">disabled</c:if>/>
	                    </div>
	               </li>
	               <li>
	                    <span class="span_form_label"><font class="xh"></font><spring:message code="DICT_CODE_LAB"></spring:message>：</span>
	                    <div class="div_form_content">
	                     	<span class="div_form_content_span" style="border-bottom: 1px solid #585757; height: 22px;">${model.dictKey}</span>
	                    	<%-- <input class="file_fixed_150px_span" value="${model.dictKey}" name="dictKey" style="border-bottom: 1px solid #585757; height: 22px;" readonly="true"/> --%>
	                    </div>
	               </li>
	               <li style="width: 100%;">
	                    <span class="span_form_label"><font class="xh"></font><spring:message code="DICT_DES_LAB"></spring:message>：</span>
	                    <div class="div_form_content div_form_content2">
	                    	<textarea class="div_text" style="height: 30px;" id="remark" name="remark" <c:if test="${model.isSystemConfig=='1'}">disabled</c:if>>${model.remark}</textarea>
	                    </div>
	               </li>
	            </ul>
	            <input name="id" value="${model.id}" type="hidden"/>
	            <input name="isSystemConfig" id="isSystemConfig" value="${model.isSystemConfig}" type="hidden"/>
	            <div style="clear:both;"></div>
            </div>
            <div id="grid"></div>
            <div class="tan_table_btn" style="text-align:center;">
<!--            	 <c:if test="${model.isSystemConfig!='1'}">-->
	             <button class="button2 btn_save3" onclick="beforeSubmit()" type="button" id="submit_btn"><spring:message code="SUBMIT_OPT"></spring:message></button>
<!--	              </c:if>-->
	             <a class="button3 close_chuan" onclick="back()"><spring:message code="CANCEL"></spring:message></a>
	        </div>
        </div>
     </div>
     <div id="bgDiv"></div>
     <!-- delete_win -->
    <!-- 删除弹框开始 -->
		<div class="confim" id="delete_win">
			<p>确认删除选中记录？</p>
			<div class="confim_btn">
				<button class="button2" onclick="doDeleteConfirm()" type="button"><spring:message code="SURE_OPT"></spring:message></button>
				<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
			</div>
		</div>
	<!-- 删除弹框结束 -->
	<!-- 恢复弹窗开始 -->
	<div class="confim" id="recover_win">
			<p>确认恢复选中记录？</p>
			<div class="confim_btn">
				<button class="button2" onclick="doRecoverConfirm()" type="button"><spring:message code="SURE_OPT"></spring:message></button>
				<a class="button3 re_btn"><spring:message code="CANCEL"></spring:message></a>
			</div>
		</div>
	<!-- 恢复弹窗end -->
     <div class="confim" id="select_win">
		<p>请选择一条记录</p>
		<div class="confim_btn">
			<button class="button2 re_btn" type="button">
				<spring:message code="SURE_OPT"></spring:message>
			</button>
		</div>
	</div>
	<div class="confim" id="select_win2">
		<p>选择较多，请选择一条记录</p>
		<div class="confim_btn">
			<button class="button2 re_btn" type="button">
				<spring:message code="SURE_OPT"></spring:message>
			</button>
		</div>
	</div>
</body>

<script type="text/javascript">
var parentKey = "${parentKey}";
var store;
var dictGrid;
//点击ENTER执行导入函数
function getKey()  
{  
    if(event.keyCode==13){  
    	if($('#filter.dictKey').is(':focus')||$('#filter.dictValue').is(':focus')||$('#filter.orderNum').is(':focus')||$('#filter.remark').is(':focus')) {
    		$('#export_btn').click();
    	}
    	else {
    		store.loadPage(1);  
    	}
    }     
} 
//-----------------------------------------------------------------------
var flag = false;
var type = {xtype:'textfield',allowBlank:false};
var type1 = {xtype:'textfield'};
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
	//创建一个数据 store
		store = new Ext.data.Store({
			autoLoad : true, //自动读取设成false 是否自动加载数据
			autoDestroy : true, //store的自动销毁，一定要设置成true
			fields : [ 'id','dictKey','dictValue','orderNum','remark','delFlag'], //要显示哪些字段
			pageSize : itemsPerPage, //每页显示条数
			//remoteSort : true, //是不是服务端排序
			//sorters : sorters, //服务端排序的条件
			//sorters:[{property:"containerNum",direction:"ASC"}],
			proxy : {
				type : 'ajax',
				url : 'dictList.do', //调用的action，如果是跨name space的action，这里就要写完整action路径了
				actionMethods : {
					read : 'POST'
				},
				reader : {
					type : 'json',
					totalProperty : 'totalCount',
					root : 'root'
				}
			}
		});
		var rowEditing = Ext.create('Ext.grid.plugin.RowEditing', {
		    clicksToMoveEditor: 1,
		    autoCancel: false,
		    saveBtnText: '保存', 
	        cancelBtnText: "取消"
		});
	    //grid上面的tbar
		var tbar = new Ext.Toolbar({
			items : [ 
			{
				text : '新 增',
				cls:'button4',
				id:'detailDict_addBtn',
				//disabled:flag,
//				hidden:flag,
			    handler:function(){
	             }
	         },
	         {
				text : '<font color="silver">编 辑</font>',
				cls:'button4_disable',
				id:'detailDict_editBtn',
				//disabled:flag,
//				hidden:flag,
			    handler:function(){
	             }
	         },
	         {
				text : '<font color="silver">删 除</font>',
				cls:'button4_disable',
				id:'detailDict_deleteBtn',
				//disabled:flag,
//				hidden:flag,
			    handler:function(){
	             }
			},
			 {
				text : '<font color="silver">恢复</font>',
				cls:'button4_disable',
				id:'detailDict_recoverBtn',
//				disabled:flag,
//				hidden:flag,
			    handler:function(){
	             }
			}]

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
		dictGrid = Ext.create('Ext.grid.Panel', {
			//title:'EXT表格测试',//标题 
			store : store,//store数据源
			columnLines:true,
			listeners: {
	            edit: function(e, context){
	            	var myMask = new Ext.LoadMask(Ext.getBody(), {
	                    msg: '保存中...',
	                    removeMask: true
	                });
	                if(context.originalValue != context.value){
		                myMask.show();
		                Ext.Ajax.request({
		                  url: 'saveOrUpdateDict.do',
		                  method: 'POST',
		                  params: {'id': context.record.get("id"),'orderNum': context.record.get("orderNum"),'remark': context.record.get("remark"),'dictValue':context.record.get("dictValue")},
		                  success: function(response){
		              	    myMask.hide();
		              	    store.load();
		                  },
		                  failure : function(response, options) {
		                	  Ext.MessageBox.alert('保存失败');
		                  }
		                });
	                } else {
	                   return;
	                }
	            }
	        },
			height : 300,
			border : true,
			 plugins:[
                Ext.create('Ext.grid.plugin.CellEditing',{
                    clicksToEdit:2 //设置单击单元格编辑
                })
            ],
			bodyBorder : false,
			tbar : tbar,
			//bbar:{xtype:"pagingtoolbar",store: store,displayInfo:true}, //可以取代 dockedItems
			frame : false,
			columnLines:true,
			viewConfig: { autoFill:true,
						  getRowClass :changeRowClass,
			 			  enableTextSelection:true
						   },
			forceFit : true,//自动填充
			//此代码是设置选择checkBox才能选择该条记录
			selModel : Ext.create('Ext.selection.CheckboxModel', {
	 			//checkOnly : true
	 			
	 			listeners:{
				      'selectionchange':function(sm, selections){
				    	  var demoListSelection = dictGrid.getSelectionModel().getSelection();
				    	  var delFlag = false;
				    	  var recFlag = false;
				    	  for(var i = 0;i<demoListSelection.length;i++){
//				    	  	alert(demoListSelection[i].data.delFlag);
				    	  	if(demoListSelection[i].data.delFlag == '0'){
				    	  		recFlag = true;
				    	  	}
				    	  	if(demoListSelection[i].data.delFlag == '1'){
				    	  		delFlag = true;
				    	  	}
				    	  }
//				    	  alert("recFlag"+recFlag);
//				    	  alert("delFlag"+delFlag);
				    	  if(selections.length > 1){
				    		  $('#detailDict_editBtn-btnInnerEl font').attr('color','silver');
				    		  $("#detailDict_editBtn").attr("disabled","disabled");
				    		  $("#detailDict_editBtn").removeClass("button4_disable_hover");
				    		 if(!recFlag){
				    		  	$('#detailDict_recoverBtn font').attr('color','#545351');
				    		  	$("#detailDict_recoverBtn").removeAttr("disabled");
				    		  	$("#detailDict_recoverBtn").addClass("button4_disable_hover");
				    		  	}else{
				    		  	$('#detailDict_recoverBtn font').attr('color','silver');
				    	  		$("#detailDict_recoverBtn").attr("disabled","disabled");
				    	  		$("#detailDict_recoverBtn").removeClass("button4_disable_hover");
				    		  	}
				    		  if(!delFlag){
				    		  	$('#detailDict_deleteBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#detailDict_deleteBtn").removeAttr("disabled");
				    		  	$("#detailDict_deleteBtn").addClass("button4_disable_hover");
				    		  }else{
				    		  	$('#detailDict_deleteBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#detailDict_deleteBtn").attr("disabled","disabled");
				    	  		$("#detailDict_deleteBtn").removeClass("button4_disable_hover");
				    		  	}
				    	  } else if (selections.length == 1){
				    	  		$('#detailDict_editBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#detailDict_editBtn").removeAttr("disabled");
				    		  	$("#detailDict_editBtn").addClass("button4_disable_hover");
				    		  	if(!recFlag){
				    		  	$('#detailDict_recoverBtn font').attr('color','#545351');
				    		  	$("#detailDict_recoverBtn").removeAttr("disabled");
				    		  	$("#detailDict_recoverBtn").addClass("button4_disable_hover");
				    		  	}else{
				    		  	$('#detailDict_recoverBtn font').attr('color','silver');
				    	  		$("#detailDict_recoverBtn").attr("disabled","disabled");
				    	  		$("#detailDict_recoverBtn").removeClass("button4_disable_hover");
				    		  	}
				    		  	if(!delFlag){
				    		  	$('#detailDict_deleteBtn-btnInnerEl font').attr('color','#545351');
				    		  	$("#detailDict_deleteBtn").removeAttr("disabled");
				    		  	$("#detailDict_deleteBtn").addClass("button4_disable_hover");
				    		  	}else{
				    		  	$('#detailDict_deleteBtn-btnInnerEl font').attr('color','silver');
				    	  		$("#detailDict_deleteBtn").attr("disabled","disabled");
				    	  		$("#detailDict_deleteBtn").removeClass("button4_disable_hover");
				    		  	}
				    	  } else{
				    	  		$('#detailDict_deleteBtn-btnInnerEl font,#detailDict_editBtn-btnInnerEl font,#detailDict_recoverBtn font').attr('color','silver');
				    	  		$("#detailDict_deleteBtn,#detailDict_editBtn,#detailDict_recoverBtn").attr("disabled","disabled");
				    	  		$("#detailDict_deleteBtn,#detailDict_editBtn,#detailDict_recoverBtn").removeClass("button4_disable_hover");
				    	  }
				      }
				}
	 		}),
			columns : [ 
				{
				header : "编号",
				remoteSort : false,
				hidden: true,
				dataIndex : 'id',
				align: 'center'
			}, {
				header : "排序",
				sortable: true,
				dataIndex : 'orderNum',
				align: 'center'
			},{
				header : "字典Key",
				sortable: true,
				dataIndex : 'dictKey',
				align: 'center'
			}, {
				header : "字典值",
				sortable: true,
				dataIndex : 'dictValue',
				align: 'center',
				editor:false,
                     
				listeners : { 
                            click : function(e) { 
                                 afterEdit(e,1); 
                            } 
                     }
			}, 
			{
				header : "字典说明",
				sortable : false,
				dataIndex : 'remark',
				align: 'center',
				editor:false,
                     renderer: function(value, metaData){
                			if (value) {
                				if(value.length>100){
                					metaData.tdAttr='data-qtip="'+value.substring(0,100)+'...(更多内容点击明细查看)"';
                				}else{
                					metaData.tdAttr='data-qtip="'+value+'"';
                				}
                			}
							return value;
        			   },
				listeners : { 
                            click : function(e) { 
                                 afterEdit(e,2); 
                            } 
                       }
                       
			} ,
			{
				header : "是否被删除",
				sortable: true,
				hidden:true,
				dataIndex : 'delFlag',
				align: 'center'
			}],
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
		
	$(window.parent.document).find("#dictIdx_kcpd").css("height",$(".main_right").height() + 30);
	$('.button4_disable').attr('disabled','disabled');	
	
	//新增按钮执行的函数	
	$('#detailDict_addBtn').click(function(){
		$(window.parent.document).find('#add_ifa,#bgDiv').css('display','block');
		$(window.parent.document).find('#dictIdx_kcpd').attr('src',"<%=path%>/addDict.do");
	});
	
	//编辑按钮
	$('#detailDict_editBtn').click(function(){
		if($(this).attr('disabled') =='disabled'){
	    		return false
	    	}else{
				var demoListSelection = dictGrid.getSelectionModel().getSelection();
				if(demoListSelection.length == 0){
					//$('#select_win,#bgDiv').css('display','block');
					showMsg2("请选择一条记录");
				} else if(demoListSelection.length > 1){
					//$('#select_win2,#bgDiv').css('display','block');
					showMsg2("选择较多，请选择一条记录");
				}else{
					var id = demoListSelection[0].data.id;
					$(window.parent.document).find('#add_ifa,#bgDiv').css('display','block');
				    $(window.parent.document).find('#dictIdx_kcpd').attr('src',"<%=path%>/updateDict.do?id="+ id);
				}
			}
		});
		
	//恢复按钮
	    $('#detailDict_recoverBtn').click(function(){
	    	if($(this).attr('disabled') =='disabled'){
	    		return false
	    	}else{
	    		 var demoListSelection = dictGrid.getSelectionModel().getSelection();
		         if(demoListSelection.length == 0){
					//$('#select_win,#bgDiv').css('display','block');
					showMsg2("请选择一条记录");
				 } else if (demoListSelection.length > 0) {
			    	var _list = "";
			        var long = demoListSelection.length;
			        for (var i = 0; i < long; i++) {
				        if(_list==""){
				        	_list="{ "+demoListSelection[i].data.id;//将id赋值到list中
				        }else{
				        	_list+=","+demoListSelection[i].data.id;
				        }
			        }
			         _list=_list+" }";
			        recoverComfirm(_list);
		      		return false;
		    	}  
	    	}
	        
	    });
	    
	    //删除按钮
	    $('#detailDict_deleteBtn').click(function(){
	    if($(this).attr('disabled') =='disabled'){
	    		return false
	    	}else{
	         var demoListSelection = dictGrid.getSelectionModel().getSelection();
	         if(demoListSelection.length == 0){
				//$('#select_win,#bgDiv').css('display','block');
				showMsg2("请选择一条记录");
			 } else if (demoListSelection.length > 0) {
		    	var _list = "";
		        var long = demoListSelection.length;
		        for (var i = 0; i < long; i++) {
			        if(_list==""){
			        	_list="{ "+demoListSelection[i].data.id;//将id赋值到list中
			        }else{
			        	_list+=","+demoListSelection[i].data.id;
			        }
		        }
		         _list=_list+" }";
		        deleteComfirm(_list);
	      		return false;
	    	}
	    	}  
	    });
});

 //显示弹框函数
	function deleteComfirm(val){
		deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
		$('#delete_win,#bgDiv').css('display','block');
		
	}
	//显示恢复按钮弹框函数
	function recoverComfirm(val){
		deleteId = val;//将其传过来的值赋值给deleteId ；deleteId因为是全部变量
		$('#recover_win,#bgDiv').css('display','block');
		
	}
	 //执行删除的函数
	     function doDeleteConfirm(){
	     	
	     	//var url = 'doDelDict.do'; 物理删除
	     	var url = 'doDeleteDict.do';//逻辑删除 add by chenping
	     	 Ext.Ajax.request({
	     	 
	              url: url,
	              params: {dictIds: deleteId },
	              method: 'post',
	              success: function (response, options) {
	               	 $('#delete_win,#bgDiv').css('display','none');
					 deleteId = {};//将其全局变量赋值为空
					 
					 
		             refresh();//刷新数据
		             $('#detailDict_deleteBtn-btnInnerEl font').attr('color','silver');
				    $("#detailDict_deleteBtn").attr("disabled","disabled");
				    $("#detailDict_deleteBtn").removeClass("button4_disable_hover");
		             var demoListSelection = dictGrid.getSelectionModel();
		             demoListSelection.clearSelections();
	         	  },
	         	  failure: function (response, options) {
	              	 Ext.MessageBox.alert('失败');
	        	  }
	          });
	     }
	     
	     //执行恢复的函数
	     function doRecoverConfirm(){
	     	
	     	//var url = 'doDelDict.do'; 物理删除
	     	var url = 'doRecoverConfirm.do';//逻辑删除 add by chenping
	     	 Ext.Ajax.request({
	     	 
	              url: url,
	              params: {dictIds: deleteId },
	              method: 'post',
	              success: function (response, options) {
	               	 $('#recover_win,#bgDiv').css('display','none');
					 deleteId = {};//将其全局变量赋值为空
					 //按钮zhihu
		             refresh();//刷新数据
		             
		             $('#detailDict_recoverBtn font').attr('color','silver');
				    $("#detailDict_recoverBtn").attr("disabled","disabled");
				   $("#detailDict_recoverBtn").removeClass("button4_disable_hover");
				   var demoListSelection = dictGrid.getSelectionModel();
		             demoListSelection.clearSelections();
	         	  },
	         	  failure: function (response, options) {
	              	 Ext.MessageBox.alert('失败');
	        	  }
	          });
	     }
	 
	 function beforeSubmit() {
	 	var dictName = document.getElementById("dictName").value;
//	 	var dictKey = document.getElementById("dictKey").value;
	 	var remark = document.getElementById("remark").value;
	 	var orgdictName = "${model.dictName}";
	 	if(dictName=="" || dictName==undefined || dictName==null){
			showMsg2("字典名称不能为空");
		}else if(remark.length>2000){
			showMsg2("字典描述不能超过2000个字符");
		}else if (orgdictName == dictName){
			$(".btn_save3").attr("disabled","disabled");
			$(".btn_save3").addClass('btn_active');
			document.getElementById("dictform").submit();
		}else{
			$.ajax({
				type: "POST",
				url: "dictNameValidation.do", 
				data: {'dictName':dictName},
				success:function(data){
					if(data.msg == 'true') {
					$(".btn_save3").attr("disabled","disabled");
					$(".btn_save3").addClass('btn_active');
					document.getElementById("dictform").submit();
//					clear_submit_div();
				}else {
					showMsg2(data.msg);
				}
				} 
			});
		}
	 }    
$(function(){
	
	/* 关闭页面及修改弹窗高度的方法 */
    $('.close_chuan').click(function(){
        $(window.parent.document).find("#add_ifa,#bgDiv").css("display",'none');
    })
})

function clearWord3(){ 
	setTimeout(function(){
		$('#submit_btn').removeClass('btn_active');
		$("#submit_btn").removeAttr("disabled");
	},2000);
}

//刷新函数
function refresh(){
	store.load();
}

function  afterEdit(e,val){
     var store = dictGrid.getStore();
     var demoListSelection = store.getUpdatedRecords();
     var long = demoListSelection.length;
     var value;
     if (long > 0) {
         if(val > '1'){
            value = demoListSelection[0].data.remark;
         } else {
          value = demoListSelection[0].data.dictValue;
         }
        if (value != "" && value != null && value.length > 0 && value != undefined) {
//        alert(demoListSelection[0].data.orderNum);
             $.ajax({
				type: "POST",
				url: "saveOrUpdateDict.do", 
				data: {'id':demoListSelection[0].data.id,'orderNum': demoListSelection[0].data.orderNum,'remark': demoListSelection[0].data.remark,'dictValue':demoListSelection[0].data.dictValue},
				success:function(data){
					if(data.success == true){
					    func1();
					    setTimeout(function(){
       						 clearWord();			
        				})
						store.loadPage(1);
					} else {
						showMsg2("保存失败");
					}
				} 
			});
         } else {
            store.loadPage(1);
         }
     }
}

function back(){
    $(window.parent.document).find("#add_ifa,#bgDiv").css('display','none');
    $(window.parent.document).find("#dictIdx_kcpd").attr("src","about:blank");
}
//设置高亮
 function changeRowClass(record,rowIndex,rowParams,store){
	if('1'==record.get('delFlag')){
		return 'child-row';
	} else{
		return '';
	}
}
$(function(){
	var isSystemConfig = $("#isSystemConfig").val();
	if(isSystemConfig==1){
		flag = true;
		type = false;	
		type1 = false;	 
	}
});
</script>
</html>
