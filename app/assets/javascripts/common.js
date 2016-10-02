// JavaScript Document



function showTab(num){
		trs = document.getElementById("tabs").getElementsByTagName("li");
		for(j=0; j<trs.length;j++){
			trs[j].className = "";
		}
		trs[num-1].className = "on";
		
		for(i=1; i<=5; i++){
			ti = document.getElementById("tc" + i);
			ti.style.display = "none";	
		}
		tg = document.getElementById("tc" + num);
		tg.style.display = "block";
}


function openWithSBox(url, h, w) {
    Shadowbox.open({
        content: url,
        player: "iframe",
        width: w,
        height: h,
        resizable: false
    });
}

//function showAllDiv(){
  //  $('.showAllDiv').toggle();
//}



function showRight(){
	
	$('.showRight').show();
	$('.showLeft').hide();
}
function showLeft(){
	$('.showLeft').show();
	$('.showRight').hide();
}

function showRight01(){
	
	$('.showRight01').show();
	$('.showLeft01').hide();
}
function showLeft01(){
	$('.showLeft01').show();
	$('.showRight01').hide();
}

function showOpen(){
     $('.openDiv').toggle();
	 if( $(".openDiv").css("display")=='none' ){
		 
		 $('.openSpan').show();
		$('.closeSpan').hide();
	 }
	 else
	 {
		$('.openSpan').hide();
		 $('.closeSpan').show(); 
	 }
}

function showpurchaseTable(){
	$('.purchaseTable').toggle();
	 if( $(".purchaseTable").css("display")=='none' ){
		 
		 $('.purchaseSpanOpen').show();
		$('.purchaseSpanClose').hide();
	 }
	 else
	 {
		$('.purchaseSpanOpen').hide();
		 $('.purchaseSpanClose').show(); 
	 }
}
function trashInputShow(num){
	$('.trashInputNone' + num).hide();
	$('.trashInput' + num).show();
	
	
}
function showSubSort(num){
    $('.subSortA'+ num).show()	
}
function hideSubSort(num){
    $('.subSortA'+ num).hide()	
}

function showTdText(num){
    $('.tdText' + num).show();	
}

/*レジ　お届け先・お支払方法入力 用途 */
function ShowPay(selectID, targetID){
	var tmp = $("#" + selectID).val();
	if(tmp == 1 || tmp == 2){
		$("#" + targetID).show();
	}else{
		$("#" + targetID).hide();
	}
}


function CheckChangeShow(checkBox, checkedShowId, unCheckId){
		if(!checkBox.checked){
			$('#'+checkedShowId).show();
			$('#'+unCheckId).hide();
			}else{
				$('#'+checkedShowId).hide();
				$('#'+unCheckId).show();
				}
}


function ChangeCustomType(selected_value){
	switch (selected_value)
	{
		case '0':
			$('.other').hide();
			$('.ss').show();
		break;
		case '1':
			$('.other').show();
			$('.self').hide();
		break;
		case '2':
			$('.other').hide();
			$('.self').show();
		break;		
		}
}

function toggleTr(p_tr){
	$(p_tr).parent().parent().next().toggle();
	}
	
function carSelect(obj){
	var tmp = $(obj).val();
	var tmpSrc;
	
	switch(tmp){
		case '1':
			tmpSrc = '/user/images/cars/car.jpg';
			break;
		case '2':
			tmpSrc = '/user/images/cars/car01.jpg';
			break;
		case '3':
			tmpSrc = '/user/images/cars/car03.jpg';
			break;
	}	
	
	$('#carImg').attr('src', tmpSrc);
}

function RemoveCar(){
	$(".c_info_news").hide();
	$("#AddCar").show();
}

function AddCar(){
	$(".c_info_news").show();
	$("#AddCar").hide();
}