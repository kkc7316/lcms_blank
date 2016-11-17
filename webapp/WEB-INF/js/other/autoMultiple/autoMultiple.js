/**
 * @authors yaozongping
 * @date    2015-12-9
 * @version 1.0
 */
(function($) {
	
    $.fn.LCMSAutoMultiple = function(_params, func) {
    	// init
    	var isUrl = typeof _params.action == "string";
  	    if(!isUrl || null == func){
  	    	return;
  	    }
    	
        var _pdiv = $('<div></div>');
        var _queryType =  _params.queryType;
        _pdiv.attr('id', _queryType + 'Div');
        _pdiv.addClass('choose_div');
        $(this).parent().append(_pdiv);
       // $('.div_form_content').css({'position':'static','z-index':'99'});
        $(this).bind("dblclick", function(){
        	$('.div_form_content').css({'position':'static','z-index':'99'});
        	$(this).parent().css({'position':'relative','z-index':'99999'});
        	var parWid = $(this).parent().width();
            $('.choose_div').css('display','none');
            var _queryType = $(this).attr("id");
            _queryType = _queryType.substring(_queryType.indexOf(".") + 1, _queryType.length);
            var _inputs = $(this).attr("value").split(", ");
            var _content = _inputs[_inputs.length - 1];
            
            $.ajax({
              type: _params.method,
              url: _params.action,
              data: {queryType:_queryType, content:_content},
              dataType: "json",
              success: function(data){
                init(_queryType, data, func,parWid);
              }
            });
            return false;
        });
        
        $(this).bind("keyup", function(event){
        	$('.div_form_content').css({'position':'static','z-index':'99'});
        	$(this).parent().css({'position':'relative','z-index':'9999'});
        	
        	if(event.keyCode!=13 && event.keyCode!=38 && event.keyCode!=40){
                $('.choose_div').css('display','none');
                var _queryType = $(this).attr("id");
                _queryType = _queryType.substring(_queryType.indexOf(".") + 1, _queryType.length);
                var _inputs = $(this).val().split(", ");
                
                var _content = "";
                if(_inputs.length > 0){
                	_content = _inputs[_inputs.length - 1];
                } else {
                	_content = $(this).val();
                }
                $.ajax({
                    type: _params.method,
                    url: _params.action,
                    data: {queryType:_queryType, content:_content},
                    dataType: "json",
                    success: function(data){
                      init(_queryType, data, func);
                    }
                });
        	}
        	return false;
        });
  };
  
  function init(_id, data, func,parWid){
      $("#"+_id+"Div").empty();
      var _pul = $('<ul></ul');
      $.each(data, function(idx, obj) {
    	  /*var _pli = $('<li></li');
          _pli.append('<input value="'+obj.key+'" type="checkbox" name="checkName" id="checkName"'+idx+'/>'+obj.key+" - "+obj.value);*/
    	  var _pli = $('<li name="'+obj.key+'">'+obj.key+' - '+obj.value+'</li>');
          //_pli.append('<input value="'+obj.key+'" type="text" name="checkName" style="display:none;" id="checkName"'+idx+'/>'+obj.key+" - "+obj.value);
          //_pli.append(obj.key+" - "+obj.value);
          _pul.append(_pli);
      });
      /*var _btn = '<li><input id="certainButton" class="button2" style="line-height:10px;width:45px; height:20px;" type="button" value="确定">'
          + '<input id="cancleButton" style="line-height:10px;width:45px; height:20px;" class="button2" type="button" value="取消"></li></ul>';
      _pul.append(_btn);*/
      if(data.length>0){
    	  $("#"+_id+"Div").append(_pul);  
    	  $("#"+_id+"Div").css('display','block');
      }
      /////下拉框ie67出现空白兼容
      if($.browser.msie && $.browser.version <= 7.0){//ie6、7宽度设置
          var maxWarr = [];
          $.each(data,function(i){
        	  maxWarr.push($('.choose_div li').eq(i).width());
          });
          var maxW = Math.max.apply(null, maxWarr);
          if(parWid>maxW){
        	  $('.choose_div li').width(parWid);
          }else{
          $('.choose_div li').width(maxW);
      }
      
      }
      
      $('.choose_div li').click(function(e){
    	  
    	 /* var html = "";
    	  for(var aaa in e.target) {
    		  html += aaa+":"+e.target[aaa]+"\r\n";
    	  }
    	  alert(html);
    	  $(e.target).children('input').val(); */
    	  $(this).closest('.choose_div').parent().css('position','static');
    	 
    	  var boo = '';
    	  var inputValue = $(this).attr("name"); 
    	  if(boo == null){
              boo=inputValue+", ";
          }else{
              boo=boo+inputValue+", ";
          }
          /*var checkEles = document.getElementsByName('checkName');
          var boo = '';
          for (var i = 0; checkEles[i]; ++i) {
              if (checkEles[i].checked) {
                  if(boo == null){
                      boo=checkEles[i].value+", ";
                  }else{
                      boo=boo+checkEles[i].value+", ";
                  }
              }
          }*/
          var input_val = $("#filter\\." + _id).val();
          var input_len = input_val.lastIndexOf(", ");
          var array=[];
          array = input_val.substring(0, input_len).split(", ");
          var inval = "";
          if (input_len > 0) {
        	    if($.inArray(inputValue, array) > -1){ //判断值是否存在
        	    	 inval = input_val.substring(0, input_len) + ", ";
        	    } else {
        	    	 inval = input_val.substring(0, input_len) + ", " + boo;
        	    }
          } else {
        	  inval = inval + boo;
          }
          $("#"+_id+"Div").empty();
          $('.choose_div').css('display','none');
          func(_id, inval);
          return false;
      });
      $(document).click(function(){
          $(".choose_div").hide();
          $('.file_fixed_150px').parent().css('position','static');
     	});
      $('#cancleButton').click(function(){
          $(this).closest('.choose_div').css('display','none');
          $('.choose_div').empty();
      });
  }
})(jQuery);
