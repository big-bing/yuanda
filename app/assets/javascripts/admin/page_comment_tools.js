// JavaScript Document

function PageCommentTool(){
}

PageCommentTool.init = function(cols, rows){
    $($('.container')[1]).append('<div class="row"> \
	<div class="col-lg-12 col-md-12">\
	<div class="panel panel-white">\
    <div class="panel-heading border-light">\
        <h4 class="panel-title" style="color:red;"><i class="fa fa-comment"></i>本画面/機能の詳細仕様説明：</h4>\
    </div>\
    <div class="panel-body no-padding partition-green">\
        <div class="col-md-12 col-lg-12 no-padding partition-white">\
            <div class="partition">\
                <div class="partition-body padding-15">\
                    <form action="/php/page_comment_save.php" method="post" id="form-add-page-comment-tools"> \
				<div class="col-lg-12 col-md-12"> \
					<textarea cols="' + cols + '" rows="' + rows + '" name="content" style="width:100%"></textarea></div>' +
        '<div class="col-lg-5 col-md-5">' +
        '<input type="submit" class="btn btn-danger btn-block"  value="保存する" alt="保存する"/>' +
        '</div></form></div> </div></div></div></div></div></div>')


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