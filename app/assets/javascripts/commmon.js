// JavaScript Document

window.onload = function(){
	//gnHover();
	//snHover();
	//formW();
}



function openWithSBox(url, h, w){
 Shadowbox.open({
  content: url,
  player: "iframe",
  width: w,
  height: h,
  resizable: false
 });
}



//tab switch
//changeTitle is true or false
//default is true
function tabSwitch(changeTitle){
	if(changeTitle == undefined){
		changeTitle = true;	
	}
	var tc = $(".tabWrap > .tabContent > .tabConBody");
	var tab = $(".tab > li > a");
	for(var t=1;t<=tc.length;t++){
		document.getElementById('tab' + t).onclick = function(){
		for(i=0;i<tc.length;i++){
			tc[i].style.display = 'none';
			tab[i].className = '';
		}
		var arr = this.id.split('');
		document.getElementById('tc' + arr[arr.length - 1]).style.display = 'block';
		this.className = 'on';
		if(changeTitle){
		document.title = this.innerHTML;}
		return false;
		}
	}
}

//button state
function btn_state(obj){
	if (obj.className == '') {
        obj.className = 'disabled';
    }
	else{
		obj.className = '';
	}
}

//delete confirm
function delete_confirm(){
	 window.confirm('削除してもよろしいでしょうか。');
}

//pop up dialog box
function openDialog(){
	var obj = new Object();
	var dwidth = 360;
	var dheight = 150;
	var w_left = (screen.availWidth-dwidth)/2;
	var w_top = (screen.availHeight-dheight)/2;
	window.open("dialog1.html","","innerWidth ="+dwidth+",innerHeight ="+dheight+",screenX ="+w_left+",screenY ="+w_top+",resizable=no");
}



//show hided div
function hideShow(){
	document.getElementById("h_s").style.display="";
}

function toggleTr(p_tr){
	$(p_tr).parent().parent().next().toggle();
	}
	
	
var type_val_arr = [
	["M","L","XL"],
	["黑","白","赤"]
];
var type_title_arr = ['サイズ','色'];

function fillSelect(sel,vals){
	$(sel).html("");
	for(var i=0;i<vals.length;i++)
		$(sel).append("<option value='"+i+"'>"+vals[i]+"</option>");
}

function addTypeSelRow(){
	$("#type_sel tr").last().html("<td><select class='type_title' onchange='changeTypeVals(this)'></select></td><td><select class='type_val'></select></td><td><a href='javascript:void(0);' onclick='removeSelRow(this);'>削除</a></td>");
	
	fillSelect($("#type_sel tr").last().find(".type_title").first(),type_title_arr);
	fillSelect($("#type_sel tr").last().find(".type_val").first(),type_val_arr[0]);
	
	$("#type_sel").append("<tr><td></td><td></td><td><a href='javascript:void(0);' onclick='addTypeSelRow();'>新規作成</a></td></tr>");
}

function removeSelRow(sel){
	$(sel).parent().parent().remove();
}

function changeTypeVals(sel){
	fillSelect($(sel).parent().parent().find(".type_val").first(),type_val_arr[$(sel).val()]);
}

