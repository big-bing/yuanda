// JavaScript Document

function PageCommentTool(){
}

PageCommentTool.init = function(cols, rows){
$('body').append('<br>  <hr/> <br> \
    <div class="footer mt20"> \
					<h2 class="h2_tit">本画面/機能の詳細仕様説明：</h2> \
                    <form action="/php/page_comment_save.php" method="post" id="form-add-page-comment-tools"> \
					<table class="form_table"> \
                        <tr> \
                             <td><textarea cols="' + cols + '" rows="' + rows + '" name="content"></textarea></td> \
                        </tr>       \
                        <tr> \
                             <td colspan="2" align="center"><input type="image" alt="確認する" src="/user/images/buttons/btn_confirm.jpg"></td> \
                        </tr>                        \
					</table>  \
                    </form> \
                    <br/> </div> ')
	

 //$(document).ready(function(){
  var postData = $('#form-add-page-comment-tools').serializeArray();
  postData[postData.length] = { name: "page_path", value: $(location).attr('pathname') };
  var formUrl = $('#form-add-page-comment-tools').prop('action');	 
  $.ajax({
    url: formUrl,
   type: 'get',
   data: postData,
   success: function(data){
    //console.log(data);
    $('#form-add-page-comment-tools').find('textarea[name=content]').val(data);
   }
  });
//});

 $('#form-add-page-comment-tools').submit(function(e){
  var postData = $(this).serializeArray();
  postData[postData.length] = { name: "page_path", value: $(location).attr('pathname') };
  var formUrl = $(this).prop('action');
  $.ajax({
    url: formUrl,
   type: 'post',
   data: postData,
   success: function(data){
    //console.log(data);
	if(data == 'ok'){
    	alert('画面説明内容の保存に成功しました。');
	}else{
		alert('画面説明内容の保存に失敗しました。');
		$('#form-add-page-comment-tools').find('textarea[name=content]').data('changed', 'changed');
	}
   }
  });
   e.preventDefault();
  try{
   e.unbind();
  }catch(ex){

  }
 });


var warnLeavingUnsavedMessage;
function warnLeavingUnsaved(message) {
  warnLeavingUnsavedMessage = message;
  $('#form-add-page-comment-tools').on('submit', function(){
    $('#form-add-page-comment-tools').find('textarea[name=content]').removeData('changed');
  });
  $('#form-add-page-comment-tools').on('change', 'textarea', function(){
    $(this).data('changed', 'changed');
  });
  window.onbeforeunload = function(){
    var warn = false;
    $('#form-add-page-comment-tools').find('textarea[name=content]').blur().each(function(){
      if ($(this).data('changed')) {
        warn = true;
      }
    });
    if (warn) {return warnLeavingUnsavedMessage;}
  };
}
$(window).load(function(){ warnLeavingUnsaved('画面説明内容を変更しましたが、このページから移動すると、保存されていないデータが失われます。'); });
}