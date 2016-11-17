// JavaScript Document

$(document).ready(function(){ 
	
	 //当前页面卸载时主动再触发一次内存清理
	//当页面卸载前
	$(window,document).unload(function(){
	if (navigator.userAgent.indexOf('MSIE') >= 0) {
	if (CollectGarbage) {
	//window.jQuery = null;
	//window.$ = null;
	//Ext = null;
	CollectGarbage(); //IE 特有 释放内存
	}
	}
	})
	
	/*index arror 收起和展开*/
	$(".shouqi").click(function(){
		$(this).closest(".title_ov").find(".list_ov").slideToggle('slow');
		$(this).toggleClass("active")
	})
	var height = $(".main_right").outerHeight();
		//alert(width);
	$(".main_left").css("min-height",height);	

	    $('.main_left ul > li >span ').click(function(){ 
        if($(this).parent().hasClass('active')){ 
            $(this).parent().find('.sub-menu').slideUp('fast');
            $(this).parent().removeClass('active');
        }else{ 
        	$('.sub-menu').slideUp('fast');
        	$('.accordion > li').removeClass('active')
            $(this).parent().find('.sub-menu').slideDown('fast');
            $(this).parent().addClass('active');
        }
    })

	    $('.sub-menu li').mouseout(function(){
	    	if($(this).hasClass('current')){
	    		$(this).removeClass('current2')
	    	}
	    })
	    $('.sub-menu li').mouseover(function(){
	    	if($(this).hasClass('current')){
	    		$(this).addClass('current2')
	    	}
	    })


    $(".sub-menu li").click(function(){
    	$(".sub-menu li").removeClass('current');
        $(this).addClass("current");
        $(this).addClass("current2");

    });
  

		$(".xllba").click(function(){
            $(this).css("border","1px rgb(145,178,211) solid");
        });            
        $('.xllba').mouseout(function(){
        $(this).css("border","1px rgb(217,217,217) solid");
        });

    /*condition choose*/
	$('#help').hover(function(){
		$('.help_chuan').css('display','block');
		$(this).find('img').attr('src','image/help_hover.png')
	},function(){
		$('.help_chuan').css('display','none');
		$(this).find('img').attr('src','image/help_bgn1.png')
	})

	$('.condition .condition_content_font').hover(function(){
		$(this).find('.seach_xunfu').css('display','block');
		$(this).addClass('position')
	},function(){
		$(this).find('.seach_xunfu').css('display','none');
		$(this).removeClass('position')
	})


    /*select 美化*/
	$('.select_fixed_145px').each(function(){
		$(this).Selectyze({
			theme : 'skype'
		},$(this).attr("title"));	
	});
	

	$("#sel").change(function(){ 
		$("#sel option").each(function(i){ 
		//console.log("sdas")
			if($(this).attr("selected"))
				{ 				
					$(".sel_change").hide();
					$(".sel_change").eq(i).css("display","block");
				}				
		})
	})
		
	/*close 弹窗*/

	$('.close_ifa').click(function(){
		$(this).parent().parent().css('display','none')
		$('#bgDiv').css('display','none')
	})




	$('.lbtable1 .srnr select,.textarea1,.srnr  textarea,.file_fixed_150px,.page_input,.int_80').focus(function(){
		$(".lbtable1 .srnr input").css("border","1px rgb(217,217,217) solid");
		$(this).css("border","1px rgb(145,178,211) solid");
		$(".input2").css("border","0px");
	});
	$('.lbtable1 .srnr select,.textarea1,.srnr  textarea,.file_fixed_150px,.page_input,.int_80').mouseout(function(){
		$(this).css("border","1px rgb(217,217,217) solid");
	});
	
			$(".lbtable table tbody tr").click(function(){
				
				$(".lbtable table tbody tr").css("background","rgb(255,255,255)");
				$(this).css("background","rgb(223,232,246)");
				
			})
			
			

			$(".baobiao_tab table tbody tr td:last-child").css('border-right','none');
			$(".baobiao_tab table tbody tr td:first-child").css('background','rgb(238,238,238)');
			$(".baobiao_tab table:last-child tr:last-child td").css('border-bottom','none');
			$(".baobiao_tab table:first-child").css('border-top','none');

			$(".baobiao_tab table tbody tr").click(function(){			
				$(".baobiao_tab table tbody tr").css("background","rgb(255,255,255)");
				$(this).css("background","rgb(223,232,246)");
			})
	
})
	function upLoad(){
	var upLoad = document.getElementById("upLoad");
	upLoad.click();
}

function changeUrl(url){
	//location.href="C"+url+".html";	
	//location.href="/url" 当前页面打开URL页面
	location.href=url+".html";	
}



/*点击按钮弹出新建div框，并且按钮变为不可用*/
var thisBtn;
$(function(){
	$(".btn_save").click(function(){
		thisBtn = $(this);
		//if($(this).hasClass('btn_active')) return;
		func1();							///	新建一个div存放弹出字母
		$(this).attr("disabled","disabled");  // 不能点击的按钮变灰
		$(this).addClass('btn_active');
        setTimeout(function(){
        clearWord();			///移动新建div
       	//thisBtn.removeAttr("disabled");				///	去除不能点击按钮的变灰效果
       	//thisBtn.attr('disabled',false); ///也可以
        })
	});

	/*C19-1弹出框不隐藏*/
	$(".btn_save2").click(function(){
		$(".div_wancheng2").remove();
		thisBtn = $(this);
		//if($(this).hasClass('btn_active')) return;
		func2();							///	新建一个div存放弹出字母
		$(this).attr("disabled","disabled");  // 不能点击的按钮变灰
		$(this).addClass('btn_active');
        setTimeout(function(){
        clearWord2();			///移动新建div
       	//thisBtn.removeAttr("disabled");				///	去除不能点击按钮的变灰效果
       	//thisBtn.attr('disabled',false); ///也可以
        })
	});

	$('.btn_save_ceshi').click(function(){
		$(".div_wancheng2").remove();
	})

	/*输入框键盘enter操作*/
	$(".file_fixed_150px").keypress(function(){				////判断input输入框是否有其他class，执行键盘 enter操作
		if($(this).hasClass("riqi")){
			return false;
		}else{
			getKey();			
		}
	});


	////点击查询或者确认按钮检测上面带*输入框中是否有值，给出提醒span
	$('.queren').click(function(){ 	
		queren();
	})

	////给所有带btn_active的按钮添加不能点击效果
	$('button').each(function(){ 
		if($(this).hasClass('btn_active')){ 
			$(this).attr("disabled","disabled");		
		}
	})
});


/* parent div by yao */
function showMsg(msg){
	var topdoc = $($("#index-frame", top.window.document).children("#top-frame")[0].contentWindow.document);
	topdoc.find('#showMsgHid').val(msg);
	topdoc.find('#showMsgBtn').click();
}

function showDiv(){
	var msg = $('#showMsgHid').val();
	var oDiv = document.createElement('div');
    var span = document.createElement('span');
    span.innerHTML = msg;
    oDiv.appendChild(span);
    document.body.appendChild(oDiv);
    oDiv.className='div_wancheng'; 
    span.className='div_wancheng_span';
	setTimeout(function() {
        clearWord();
    });
}
///新建div
function func1(){ 
    var oDiv = document.createElement('div');
    var span = document.createElement('span');
    span.innerHTML = '保存完成';
    oDiv.appendChild(span)
    document.body.appendChild(oDiv);
    oDiv.className='div_wancheng'; 
    span.className='div_wancheng_span'
}
/*错误提示*/
function func2(){ 
    var oDiv = document.createElement('div');
    var span = document.createElement('span');
    span.innerHTML = '输入中存在错误信息';
    oDiv.appendChild(span)
    document.body.appendChild(oDiv);
    oDiv.className='div_wancheng2';
    span.className='div_wancheng_span2'
}
/*绑定新建div的事件*/
// function clearWord(){ 
//     $('.div_wancheng').animate({
//         // opacity: 0,
//         top: '60',
//       }, 2000, function() {
//         // Animation complete.
//     $(".div_wancheng").remove();
// 	setTimeout(function(){
//        $('.btn_save').removeClass('btn_active');
//        thisBtn.removeAttr("disabled");     
//     },1000)
//   });
// }

function clearWord(){ 
    $('.div_wancheng').animate({
        // opacity: 0,
        height: '47px'
      }, 1500);
    setTimeout(function(){
		$(".div_wancheng").animate({"height":"0px"},1500,function(){
			$(".div_wancheng").remove();
			setTimeout(function(){
				$('.btn_save').removeClass('btn_active');
				$('.btn_save').removeClass('btn_hover');
       			//thisBtn.removeAttr("disabled");
			},3000)
			     
		});
	},4000);
}

function clearWord2(){ 
    $('.div_wancheng2').animate({
        // opacity: 0,
        height: '45'
      }, 2000);
    setTimeout(function(){
		$(".div_wancheng2").animate({"height":"45px"},2000,function(){
			$(".div_wancheng2").fadeOut();
			/*setTimeout(function(){
				$('.btn_save2').removeClass('btn_active');
       			thisBtn.removeAttr("disabled");
			},1000)*/
		});
	},3000);
}	

function clearWord3(){ 
    $('.div_wancheng2').animate({
        // opacity: 0,
        height: '45'
      }, 2000);
    setTimeout(function(){
		$(".div_wancheng2").animate({"height":"45px"},2000,function(){
			//$(".div_wancheng2").fadeOut();
			/*setTimeout(function(){
				$('.btn_save2').removeClass('btn_active');
       			thisBtn.removeAttr("disabled");
			},1000)*/
		});
	},3000);
}

function getKey()  
{  
    //if(event.keyCode==13){  
     //alert('查询按钮被点击');  
    //}     
}  


////判断带*必填输入框是否有值，弹出警告
function queren(){ 
	$('.xh').closest('li').find('input').nextAll('span').css('display','none');
	for(i=0;i<$('.xh').closest('li').find('input').length;i++){
		if($('.xh').closest('li').find('input').eq(i).val() == ""){
			$('.xh').closest('li').find('input').eq(i).nextAll('span').css('display','block');

		}
	}
}

function close_div(){
	$('.addDiv,#bgDiv,#bgDiv2').css('display','none')
	//alert('sad')
}
/*add by xieshuang  delete	 Win 2015-10-24*/

function close_div_update(){
	$('.updateDiv,#bgDiv,#bgDiv2').css('display','none')
	//alert('sad')
}

function close_div_chongxiao(){
	$('.chongxiaoDiv,#bgDiv').css('display','none')
	//alert('sad')
}

/*add be xieshuang 按调教隐藏li*/
$(document).ready(function() {
	$(".se").change(function(){
		
		if($(this).val() == "维修") {
			$(this).closest('li').next('li').find('.noneli').show();
			// $("#hideLi").show();
			
		} else {
			// $("#hideLi").hide();
			$(this).closest('li').next('li').find('.noneli').hide();
			
		}
	});
/////删除按钮弹出框确认
	$('.con_btn').click(function(){
		$('.confim,.confim2,#bgDiv,#bgDiv2').css('display','none')
	})
	$('.re_btn').click(function(){
		$('.confim,.confim2,#bgDiv,#bgDiv2').css('display','none')
	})

})


/*checkbox*/
function myCheckbox(obj,thisobj)
{
	var o = document.getElementsByName(obj);
	//alert(o)
	if(o.checked)
	{
		thisobj.style.backgroundImage="url(../style/image/all_ico/icon_unselect.jpg)";
		o.checked = false;
	}
	else
	{
		thisobj.style.backgroundImage="url(../style/image/all_ico/icon_select.jpg)";
		o.checked = true;
	}
}

/////table dbclick
function changeTotext(obj) 
    { 
        var tdValue = obj.innerText; 
        obj.innerText = ""; 
        var txt = document.createElement("input"); 
        txt.type = "text"; 
        txt.value = tdValue; 
        txt.id = "_text_"; 
        txt.setAttribute("className","text"); 
        obj.appendChild(txt); 
        txt.select(); 
        //obj.style.border = "1px dashed #ff9900"; 
    } 
     // 取消单元格中的文本框，并将文本框中的值赋给单元格 
    function cancel(obj) 
    { 
        var txtValue = document.getElementById("_text_").value; 
        obj.innerText = txtValue; 
    } 
    /*********************************************/ 

    function ondbclick(){
      if (event.srcElement.tagName.toLowerCase() == "td") 
        { 
            changeTotext(event.srcElement); 
        } 
    }
    document.onmouseup = function() 
    { 
        if (document.getElementById("_text_") && event.srcElement.id != "_text_") 
        { 
            var obj = document.getElementById("_text_").parentElement; 
            cancel(obj); 
        } 
    } 
//////////////////////////////单击鼠标表格单元格可编辑
function danji(){
      if (event.srcElement.tagName.toLowerCase() == "td") 
        { 
            changeTotext(event.srcElement); 
        } 
    }
    document.onmouseup = function() 
    { 
        if (document.getElementById("_text_") && event.srcElement.id != "_text_") 
        { 
            var obj = document.getElementById("_text_").parentElement; 
            cancel(obj); 
        } 
    } 


/////shieldtime add cqy


$(function(){
	var a ;
	$('.month table tr td').hover(function(){
			//alert($(this).text())
			//alert($(this).text()==' ')
			if($(this).text()==''){
				return;
			}else{
	    		$('.month table tr td').removeClass('hover');
	    		$(this).addClass('hover');
			}
			})
	$('.set').click(function(){
		a = -1;
		if (a = -1) {
			$('.month table tr td').click(function(){
				if($(this).text()==''){
					return;
				}else if($(this).hasClass('active_span')){
						$(this).removeClass('active_span');  		
					}else{
						$(this).addClass('active_span');
				}
			})
		}else{
			return;
		}
	})
		
	
	


/////点击灰色背景关闭弹窗
    	//$('#bgDiv').click(function(){
    		//$('.addDiv,#bgDiv,#add_ifa,.chongxiaoDiv,.uploadDiv,#add_div,#update_div,.confim,.confim2,#update_ifa,.updateDiv').css('display','none')
    	//})
    	/////点击灰色背景不关闭弹窗  add by liniansheng
	$('#bgDiv').click(function(){
		$('.chongxiaoDiv').css('display','none')
	})
	
	/////点击灰色背景关闭弹窗 add by liniansheng
	$('#bgDiv2').click(function(){
		$('.addDiv,#bgDiv2,.chongxiaoDiv,.uploadDiv,#add_div,#add_ifa,#update_div,#update_ifa,.updateDiv,#addDivForDisplay,.confim,.confim2').css('display','none')
	})

	$('.button2').hover(function(){
			$(this).addClass('btn_hover')
	},function(){
		$(this).removeClass('btn_hover')
	})

  
  // 鼠标滑过按钮图标变色
	// $('.button2,.tab_btn').hover(function(){
	// //	$(this).addClass('btn_hover');
	// //alert($(this).find('img').length)
	// 	if($(this).find('img').length==1){
	// 		var _imgSrc = $(this).find('img').attr('src').replace(".png","");
	// 		$(this).find('img').attr('src',_imgSrc + '_hover' + '.png');
	// 	}else{
	// 		return;
	// 	}
	// 	},function(){
	// 	//$(this).removeClass('btn_hover')
	// 	if($(this).find('img').length==1){
	// 		var _imgSrc = $(this).find('img').attr('src').replace("_hover","");
	// 		$(this).find('img').attr('src',_imgSrc);
	// 	}else{
	// 		return;
	// 	}
	// })


	$(".checkbox_div").click(function(){
            var _obj =  $(this).siblings('input[name="zcgl"]');
            
            if(_obj.attr("checked")){
                $(this).css("background-Image",'url(../style/image/all_ico/icon_unselect.jpg)')
                _obj.attr("checked",false);
            }else{
                $(this).css("background-Image",'url(../style/image/all_ico/icon_select.jpg)')
                _obj.attr("checked",true);
            }

        })

	/*全选checkbox*/
		$(".qxlb_content .checkbox_div_list").click(function(){
        
        var _obj =  $(this).siblings('input[name="zcgl"]');
        var _clist = $(this).siblings('ul').find('.checkbox_div');
        var _cinput = $(this).siblings('ul').find('input[name="zcgl"]');

        if(_obj.attr("checked")){
            $(this).css("background-Image",'url(../style/image/all_ico/icon_unselect.jpg)')
            _obj.attr("checked",false);
            _clist.css("background-Image",'url(../style/image/all_ico/icon_unselect.jpg)')
            _cinput.attr("checked",false);
        }else{
            $(this).css("background-Image",'url(../style/image/all_ico/icon_select.jpg)')
            _obj.attr("checked",true);
            _clist.css("background-Image",'url(../style/image/all_ico/icon_select.jpg)')
            _cinput.attr("checked",true);
        }
    })
    
    ////input 英文字符输入转大写
    $('input:.upper_case').blur(function(){
		if($(this).hasClass('capital')){
			return false;
		}else{
			var val = $(this).val();
			$(this).val(val.toUpperCase())
		}
	})
})

function showMsg2(msg){
	var topdoc = $($("#index-frame", top.window.document).children("#top-frame")[0].contentWindow.document);
	topdoc.find('#showMsgHid2').val(msg);
	topdoc.find('#showMsgBtn2').click();
}
function showMsg3(msg){
	var topdoc = $($("#index-frame", top.window.document).children("#top-frame")[0].contentWindow.document);
	topdoc.find('#showMsgHid3').val(msg);
	topdoc.find('#showMsgBtn3').click();
}
function showDiv3(){
	var msg = $('#showMsgHid3').val();
	var oDiv = document.createElement('div');
    var span = document.createElement('span');
    //var close_erro = document.createElement('div');
//    close_erro.onclick = function(){
//    	$(".div_wancheng2").remove();
//    }
	//oDiv.appendChild(close_erro);
	//close_erro.className = 'close_erromsg_div';
    span.innerHTML = msg;
    oDiv.appendChild(span);
    document.body.appendChild(oDiv);
    oDiv.className='div_wancheng2'; 
    span.className='div_wancheng_span2';
	setTimeout(function() {
        clearWord3();
    });
}
function showDiv2(){
	var msg = $('#showMsgHid2').val();
	var oDiv = document.createElement('div');
    var span = document.createElement('span');
    //var close_erro = document.createElement('div');
//    close_erro.onclick = function(){
//    	$(".div_wancheng2").remove();
//    }
	//oDiv.appendChild(close_erro);
	//close_erro.className = 'close_erromsg_div';
    span.innerHTML = msg;
    oDiv.appendChild(span);
    document.body.appendChild(oDiv);
    oDiv.className='div_wancheng2'; 
    span.className='div_wancheng_span2';
	setTimeout(function() {
        clearWord2();
    });
}

//非空验证红色编辑隐藏
$(function(){
	$(".div_form_content,.tab_text").find('input:not([type=radio])').click(function(){
		var _id = $(this).attr("id") + "require";
		if(document.getElementById(_id)){
			var div_input = document.getElementById(_id);
			div_input.style.display = 'none';
		}else{
			return false;
		}
	})
})
//根据输入的值 获得select的key
function getSelectKeyFromText(id, textValue){
    	var key = null;
    	//遍历select option
    	jQuery("#" + id + " option").each(function(){ //遍历全部option
    	        var txt = $(this).text(); //获取option的内容
    	        if(txt == textValue) {
    		        key = $(this).val();
    	        }//如果不是“全部”
    	 });
    	return key;
    }  
