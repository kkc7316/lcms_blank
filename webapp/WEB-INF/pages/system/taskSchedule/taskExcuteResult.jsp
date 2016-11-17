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
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/ext-theme-classic-all.css" />
<link rel="stylesheet" type="text/css" href="css/resources/ext-theme-classic/all2.css" />
</head> 
<body style="background: rgb(249,249,249)">
<div class="main_right">
 <div class="lbtable1 lbtable1_tan">
        <div class="biaoti_title biaoti_title_tan"><span>任务结果</span>
        <input type="hidden" value="${id}" id="hidden_id"/>
        </div>
		<div id="grid2"></div> 
        <div class="updateDiv" style="width: 700px;height:500px">
            <div class="addDiv_title"><span  class="font_style">执行结果说明</span></div>
            <div class="lbtable1_content lbtable1_content_tan" style="width: 98%; line-height:15px;height:270px;overflow:auto">
    			<span class="span_form_label" style="margin-top:15px;" id="resultDes"><font class="xh"></font></span>
			</div>
<!--			 <iframe id="relay" src="" width="100%" height="100%" border="0" frameborder="0" framespacing=0 ></iframe> -->
            <div class="srnr" style="text-align:center;">
                <button  class="button2" onclick="close_update()"><spring:message code="CANCEL"></spring:message> </button> 
            </div>
        </div>
        <div class="srnr" style="text-align:center;">
             <a  class="button3 close_chuan "><spring:message code="CANCEL"></spring:message> </a> 
        </div>
    </div>
<div id="bgDiv">
</div>
<div id="add_ifa" style="margin-top: -200px;">
    <iframe id="relay" src="" width="100%" height="100%" border="0" frameborder="0" framespacing=0 ></iframe> 
</div>
</div>
</div>
</div>
</body>
<script>
var store;
var detailGrid;
Ext.onReady(function(){
Ext.tip.QuickTipManager.init();
 var itemsPerPage = 10;
    //创建一个数据 store
    store = new Ext.data.SimpleStore({
            autoLoad: true, 
            autoDestroy:true, 
            pageSize: itemsPerPage, 
            remoteSort: false, 
           fields: [
			           'taskName',
			           'planStartTime',
			           'actualStartTime',
			           'actualEndTime',
			           'consequenceTypeValue',
			           'consequenceDesc',
			           'remark'
           ],
           proxy: {
                type: 'ajax',
                url:'taskSchedule/taskScheduleDetail.do',
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
    //store加载之前带入查询条件
    store.on("beforeload", function(store,options){
	    var _id = document.getElementById("hidden_id").value;
	    Ext.apply(store.proxy.extraParams, {
	    		"id":_id
	    	});
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
        // 创建表格
         detailGrid = new Ext.grid.GridPanel({
            store: store,
            autoFill:true,
	        height:339,
	        scroll :'both',
            columnLines:true,
            viewConfig: { enableTextSelection:true },
            //此代码是设置选择checkBox才能选择该条记录
			selModel : Ext.create('Ext.selection.CheckboxModel', {
	 			//checkOnly : true
	 		}),
            columns: [
            {
		        text: "id",
		        width: 50,
		        sortable: true,
		        dataIndex: 'id',
		        hidden: true,
		        align: 'center'
		      },
                {
                    header: "任务名称",
                    dataIndex: 'taskName',
                    align : 'center',
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
                    header: "计划开始日期",
                    align : 'center',
                    width:130,
                    dataIndex: 'planStartTime'
                },
                {
                    header: " 实际开始时间",
                    dataIndex: 'actualStartTime',
                    width:140,
                    align : 'center'
                },
                {
                    header: "实际结束时间",
                    dataIndex: 'actualEndTime',
                    width:140,
                    align : 'center'
                    
                },
                {
                    header: "执行结果",
                    dataIndex: 'consequenceTypeValue',
                    width:70,
                    align : 'center'
                },
				 {
                    header: "执行结果说明",
                    dataIndex: 'consequenceDesc',
                    id:'resultId',
                    width:90,
                    align : 'center',
					renderer : function(value, cellmeta, record, rowIndex, columnIndex, store) {
					                            if(record.get('consequenceTypeValue')=='失败'){
					                            	str = value.replace(/\\/g,'\\\\').replace("\"","");
					                            	cellmeta.tdAttr = 'title="' + str + '"';
//					                            	return str;
													return '<a href="javascript:void(0)" onClick = "showMessage(\''+record.get("id")+'\')" style="text-decoration:underline;color: blue;">'+str+'</a>';
													//return '<a onClick="message1(\''+str+'\')" style="color:blue;CURSOR: hand;text-decoration:underline">'
															//+ value + '</a>';//
					                            }else{
					                                str = value.replace(/\\/g,'\\\\');
					                            	cellmeta.tdAttr = 'title="' + str + '"';
//					                            	return str;
													return '<a href="javascript:void(0)" onClick = "showMessage(\''+record.get("id")+'\')" style="text-decoration:underline;color: blue;">'+str+'</a>';
					                            }
												
											}
                },
                {
                    header: "零件版本号",
                    id:'versionColumn',
                    dataIndex: 'remark',
                    width:80,
                    align : 'center',
                    renderer: function(value, metaData){
                			if (value) {
                				var str = "";
                				var newvalue = {};
                				newvalue = value.split(',');
                				for (var i=0;i<newvalue.length;i++) {
									str = str + newvalue[i] + "<br>";
								}
                				metaData.tdAttr='data-qtip="'+str+'"';
                			}
							return value;
        			   }
                }
            ],

            dockedItems: [   ////翻页
                {
	             id : 'pagingbar',
	             items : [ '-', '每页显示', combo, '条' ],
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
	             emptyMsg: '无记录'
         }],
            stripeRows: true,
            autoExpandColumn: 'touru',
            title:''
        });

        detailGrid.render('grid2');
        $(window.parent.document).find("#taskSchedule_kcpd").css("height",$(".main_right").height()+ 20 );
        /* 判断是否显示版本号一列 */
	var showVersionFlag = '${showVersionFlag}';
	if(showVersionFlag == '1') {
		Ext.getCmp('versionColumn').hide();
		Ext.getCmp('resultId').setWidth(180);
	}else{
		Ext.getCmp('versionColumn').show();
	}
    });
    $(function(){
            $('.close_chuan').click(function(){
                $(window.parent.document).find("#add_ifa,#bgDiv2").css("display",'none');
                $(window.parent.document).find("#taskSchedule_kcpd").attr("src","about:blank");
            })
        })
</script>
<script type="text/javascript">
		function message1(val) {
			$('.updateDiv,#bgDiv').css('display', 'block');
			$("#resultDes").text(val);
		}
		
		//add by chenping 20160804
		function showMessage(id){
//		$("#resultDes").text(val);
//		$('#add_ifa,#bgDiv2').css('display','block');
		//$(window.document).find("#relay").css("height",$(".main_right").height()+ 20 );
//		$('#relay').attr('src',"<%=path%>/taskLog/showMessage.do?id="+ id);
		$.ajax({
				　　url : 'taskLog/showMessage.do',
				　　data : {"id":id},
				　　type : "POST",
				　　success : function(data) {
					$('.updateDiv,#bgDiv').css('display', 'block');
					$("#resultDes").text(data.consequenceDesc);
					}
				});
	}
        function close_update(){
            $('.updateDiv,#bgDiv').css('display','none')
        }
	</script>

</html>
