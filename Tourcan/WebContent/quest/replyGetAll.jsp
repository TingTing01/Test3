<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/emsPart1.jsp"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.35.3/js/bootstrap-dialog.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.35.3/js/bootstrap-dialog.min.js"></script>
<div class="container">
  <div>
    <p></p>
    <span style="font-size: 200%;font-weight:bold">Question Table</span>
    <button class="btn btn-primary btn-lg outline pull-right" id="quest_raise" style="font-size:13px">搜尋問題</button>
    <input type="text" class="pull-right tooltip-show" id="txt_topic" data-placement="left" title="請輸入查詢標題" style="margin:3px">
  </div>
  <button class="btn btn-primary" id="quest_getAll">查詢全部</button>
  <button class="btn btn-info" id="quest_cancel">取消查詢</button>
  <p></p>
  <div id="table1">
  <table class="table table-striped" id="replyAll">
    <thead>
      <tr>
        <th>問題序號</th>
        <th>會員ID</th>
        <th>標題</th>
        <th>提問時間</th>
        <th>編輯</th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
<!--     <div id="demo1">    -->
<!--     </div> -->
  </div>
</div>
<!------------------------!!!!!!---- 請勿刪除此段註解的 div, 謝謝 ----!!!!!!------------------------------------>
<!-- <div class="container" id="replyOne"> -->
<!-- 		<ul class="timeline"> -->
<!-- 			<li> -->
<!-- 				<div class="timeline-badge"> -->
<!-- 					<i class="glyphicon glyphicon-check"></i> -->
<!-- 				</div> -->
<!-- 				<div class="timeline-panel"> -->
<!-- 					<div class="timeline-heading"> -->
<!-- 						<h4 class="timeline-title">會員提問</h4> -->
<!-- 						<p> -->
<!-- 							<small class="text-muted"> -->
<!-- 							   <i class="glyphicon glyphicon-time"></i> 11 hours ago via Twitter -->
<!-- 							</small> -->
<!-- 						</p> -->
<!-- 					</div> -->
<!-- 					<div class="timeline-body"> -->
<!-- 						<p>Mussum ipsum cacilds, vidis litro abertis. Consetis -->
<!-- 							adipiscings elitis. Pra lá , depois divoltis porris, paradis. -->
<!-- 							Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, -->
<!-- 							nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. -->
<!-- 							Manduma pindureta quium dia nois paga. Sapien in monti palavris -->
<!-- 							qui num significa nadis i pareci latim. Interessantiss quisso -->
<!-- 							pudia ce receita de bolis, mais bolis eu num gostis.</p> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</li> -->
<!-- 			<li class="timeline-inverted"> -->
<!-- 				<div class="timeline-badge warning"> -->
<!-- 					<i class="glyphicon glyphicon-credit-card"></i> -->
<!-- 				</div> -->
<!-- 				<div class="timeline-panel"> -->
<!-- 					<div class="timeline-heading"> -->
<!-- 						<h4 class="timeline-title">管理員回覆</h4> -->
<!-- 						<p> -->
<!-- 							<small class="text-muted"><i -->
<!-- 								class="glyphicon glyphicon-time"></i> 11 hours ago via Twitter</small> -->
<!-- 						</p> -->
<!-- 					</div> -->
<!-- 					<div class="timeline-body"> -->
<!-- 						<p>Mussum ipsum cacilds, vidis litro abertis. Consetis -->
<!-- 							adipiscings elitis. Pra lá , depois divoltis porris, paradis. -->
<!-- 							Paisis, filhis, espiritis santis. Mé faiz elementum girarzis, -->
<!-- 							nisi eros vermeio, in elementis mé pra quem é amistosis quis leo. -->
<!-- 							Manduma pindureta quium dia nois paga. Sapien in monti palavris -->
<!-- 							qui num significa nadis i pareci latim. Interessantiss quisso -->
<!-- 							pudia ce receita de bolis, mais bolis eu num gostis.</p> -->
<!-- 						<p>Suco de cevadiss, é um leite divinis, qui tem lupuliz, -->
<!-- 							matis, aguis e fermentis. Interagi no mé, cursus quis, vehicula -->
<!-- 							ac nisi. Aenean vel dui dui. Nullam leo erat, aliquet quis tempus -->
<!-- 							a, posuere ut mi. Ut scelerisque neque et turpis posuere pulvinar -->
<!-- 							pellentesque nibh ullamcorper. Pharetra in mattis molestie, -->
<!-- 							volutpat elementum justo. Aenean ut ante turpis. Pellentesque -->
<!-- 							laoreet mé vel lectus scelerisque interdum cursus velit auctor. -->
<!-- 							Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ac -->
<!-- 							mauris lectus, non scelerisque augue. Aenean justo massa.</p> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</li> -->
			
<!-- 		</ul> -->
<!-- 	</div> -->
<!------------------------!!!!!!---- 請勿刪除此段註解的 div, 謝謝 ----!!!!!!------------------------------------>

<div class="container">
  <!-- Trigger the modal with a buttom n -->
<!-- <button type="button" class="btn btn-default btn-lg" id="quest_editReply">Reply</button> -->
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 id="h4_1"><span class="glyphicon glyphicon-lock"></span> Reply</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" name="addQuest">
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> Admin Name</label>
              <input type="text" class="form-control"  value="${admin.admin_name }" readonly="readonly">
              <input type="hidden"  id="admin_id" name="admin_id" placeholder="Enter adminId" >
            </div>
            <div class="form-group">
              <label for="questReply"><span class="glyphicon glyphicon-eye-open"></span> Reply Text</label>
              <textarea class="form-control" id="quest_reply" name="quest_reply" placeholder="Enter Reply Text"></textarea>
            </div>
            <div class="checkbox">
              <label></label>
            </div>
              <button type="button" class="btn btn-success btn-block form-control" id="btnInsert"><span class="glyphicon glyphicon-off"></span> 確定</button>
            <div >
				<div  id="result"></div>
			</div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          <p></p>
          <p></p>
        </div>
      </div>
      
    </div>
  </div>
</div>
<!-- <script src="../js/jquery-3.1.0.min.js"></script>   -->
	<script type="text/javascript">
	$(function(){
		$('#replyOne').remove();
        $('#replyAll').hide();
	    
        $("#quest_getAll").click(function() {
		    $('#replyAll').show();
		    $('#replyAll>tbody').empty();
		    $.getJSON(("QuestServlet"),{"method":"getAll"},function(data){
			    var myBody = $('#replyAll>tbody');
			    $.each(data,function(idx,data){
			    	var replyTxt=data.quest_topic;
			    	if (replyTxt.indexOf("Re:") >= 0){
			    		var but1=$('<button class="btn btn-success btn-xs" >查看</button>');
				        var but2=$('<button class="btn btn-warning btn-xs" >取消查看</button>');
				        var but3=$('<button class="btn btn-info btn-xs" disabled="disabled" >已回覆</button>');
				    	var cell1 = $("<td></td>").text(data.quest_id);
					    var cell2 = $("<td></td>").text(data.mem_uid);
				    	var cell3 = $("<td></td>").text(data.quest_topic);
					    var cell4 = $("<td></td>").text(data.quest_qtime);
				    	var cell5 = $("<td></td>").append(but1).append("  ").append(but2).append("  ").append(but3);
					    var row = $("<tr></tr>").append([cell1,cell2,cell3,cell4,cell5]);
					    myBody.append(row);	
			    	}else{
			            var but1=$('<button class="btn btn-success btn-xs" >查看</button>');
			            var but2=$('<button class="btn btn-warning btn-xs" >取消查看</button>');
			            var but3=$('<button class="btn btn-danger btn-xs" >回覆</button>');
			          	var cell1 = $("<td></td>").text(data.quest_id);
				        var cell2 = $("<td></td>").text(data.mem_uid);
			        	var cell3 = $("<td></td>").text(data.quest_topic);
				        var cell4 = $("<td></td>").text(data.quest_qtime);
			        	var cell5 = $("<td></td>").append(but1).append("  ").append(but2).append("  ").append(but3);
				        var row = $("<tr></tr>").append([cell1,cell2,cell3,cell4,cell5]);
				        myBody.append(row);				
			    	}
			    })
			        
			    $("tr").not(':first').hover(
					    function () {
							$(this).css("background","#FFD9EC");},
						function () {
							$(this).css("background","");});  
			})
		})
		
		$("#quest_raise").click(function() {
		    $('#replyAll').show();
		    $('#replyAll>tbody').empty();
		
		    var questTopic = $('#txt_topic').val();
		    if(questTopic == null || questTopic.trim().length == 0){
		    	$('.tooltip-show').attr('data-original-title', '請勿空白!')
                                  .tooltip('show');
		    	$('#replyAll').hide();
		    }else{
		        $.getJSON(("QuestServlet"),{"questTopic":questTopic,"method":"getByName"},function(data){
		            console.log("questTopic:"+questTopic);
		            var myBody = $('#replyAll>tbody');
		            
			        $.each(data,function(idx,data){
                        console.log("idx:"+idx);
                        console.log("data:"+data);
                        if(idx=="result"){
	                    	$('#replyAll').hide();
	                    	$('.tooltip-show').attr('data-original-title', '查無資料!')
                                              .tooltip('show');
	                    }else{
			                var but1=$('<button class="btn btn-success btn-xs" id="quest_edit">查看</button>');
			                var but2=$('<button class="btn btn-warning btn-xs" id="quest_editCancel">取消查看</button>');
				            var cell1 = $("<td></td>").text(data.quest_id);
				            var cell2 = $("<td></td>").text(data.quest_catalog);
				            var cell3 = $("<td></td>").text(data.quest_topic);
				            var cell4 = $("<td></td>").text(data.quest_qtime);
				            var cell5 = $("<td></td>").append(but1).append("  ").append(but2);
				            var row = $("<tr></tr>").append([cell1,cell2,cell3,cell4,cell5]);
				            myBody.append(row);
	                    }
		            })
			
			    $("tr").not(':first').hover(
				    function () {
				        $(this).css("background","#FFD9EC");},
			        function () {
					    $(this).css("background","");});
		        
			    })
		    }
		})

       $("#replyAll").on('click','.btn-success',function(){
           
            quest_replyValue=null;
            $('#replyOne').remove();
		    var rowClosest = $(this).closest("tr");
		    var questId = rowClosest.find("td:eq(0)").text();     // Finds the 1st <td> element
		    console.log(questId);
		    
		    $.get(("QuestServlet"),{"questId":questId,"method":"getOneById"},function(data){
		    	$.each(data,function(questName,questValue){
// 		   	   	    console.log(questName+" : "+questValue);
				    if(questName=="quest_reply"){
                        quest_replyValue=questValue;
				    	console.log(quest_replyValue);
				    }
				    if(questName=="quest_quiz"){
				    	quest_quizValue=questValue;
				    	quest_quiz=questValue;
				    	console.log(quest_quizValue);
				    	console.log(quest_quiz);
				    }
				    if(questName=="quest_qtime"){
				    	quest_qtimeValue=questValue;
				    	quest_qtime=questValue;
				    	console.log(quest_qtimeValue);
				    	console.log(quest_qtime);		
				    }
				    if(questName=="quest_rtime"){
				    	quest_rtimeValue=questValue;
				    	console.log(quest_rtimeValue);		
				    }
				    if(questName=="quest_catalog"){
				    	quest_catalogValue=questValue;
				    	quest_catalog1=questValue;
				    	quest_catalog=quest_catalog1.toString();
				    	console.log(quest_catalogValue);
				    	console.log(quest_catalog);
				    }
				    if(questName=="quest_topic"){
				    	quest_topicValue=questValue;
				    	quest_topic1=questValue;
				    	quest_topic="Re:"+quest_topic1;
				    	console.log(quest_topicValue);
				    	console.log(quest_topic);		
				    }
				    if(questName=="mem_uid"){
				    	mem_uidValue=questValue;
				    	memUid1=questValue;
				    	mem_uid=memUid1.toString();
				    	console.log(mem_uidValue);
				    	console.log(mem_uid);		
				    }

			     })
			        if(typeof quest_replyValue === "undefined" ||quest_replyValue == null){
			        var frag = document.createDocumentFragment();
		  			var div_head = document.createElement("div");
		  			div_head.setAttribute("id","replyOne");
		  			
		  			var ul_afterHead= document.createElement("ul");
		  			ul_afterHead.className="timeline";
		  			div_head.appendChild(ul_afterHead);
		  			
		  			
		  			var li_afterUl=document.createElement("li");
		  			ul_afterHead.appendChild(li_afterUl);
		  			
		  			
		  			var div_afterLi1 = document.createElement("div");
		  			div_afterLi1.className="timeline-badge";
		  			li_afterUl.appendChild(div_afterLi1);
		  			
		  			var i_afterDiv = document.createElement("i");
		  			i_afterDiv.className="glyphicon glyphicon-check";
		  			div_afterLi1.appendChild(i_afterDiv);
		  			
		  			var div_afterLi2 = document.createElement("div");
		  			div_afterLi2.className="timeline-panel";
		  			li_afterUl.appendChild(div_afterLi2);
		  			
		  			var div_afterDiv2 = document.createElement("div");
		  			div_afterDiv2.className="timeline-heading";
		  			div_afterLi2.appendChild(div_afterDiv2);
		  			
		  			var h4_afterDiv2_1 = document.createElement("h4");
		  			h4_afterDiv2_1.className="timeline-title";
		  			var txt_h4=document.createTextNode("會員提問");
		  			h4_afterDiv2_1.appendChild(txt_h4);
		  			div_afterDiv2.appendChild(h4_afterDiv2_1);
		  			
		  			var p_afterDiv2_1 = document.createElement("p");
		  			div_afterDiv2.appendChild(p_afterDiv2_1);
		  			
		  			var small_afterP = document.createElement("small");
		  			small_afterP.className="text-muted";
		  			
		  			var i_afterP = document.createElement("i");
		  			i_afterP.className="glyphicon glyphicon-time";
		  			small_afterP.appendChild(i_afterP);
		  			small_afterP.setAttribute("style","word-break: break-all");
		  			var txt_small=document.createTextNode(quest_qtimeValue);  //須拿提問時間
		  			small_afterP.appendChild(txt_small);
		  			p_afterDiv2_1.appendChild(small_afterP);
					
		  			var div2_afterDiv2 = document.createElement("div");
		  			div2_afterDiv2.className="timeline-body";
		  			div_afterLi2.appendChild(div2_afterDiv2);
		  			
		  			var p_afterDiv2_2 = document.createElement("p");
		  			p_afterDiv2_2.setAttribute("style","word-break: break-all");
		  			var txt_p=document.createTextNode(quest_quizValue);       //須拿提問內容
		  			p_afterDiv2_2.appendChild(txt_p);
		  			div2_afterDiv2.appendChild(p_afterDiv2_2);
		  			
		  			frag.appendChild(div_head);
		  			
		  			rowClosest.after(frag);
			        }else{
			        	// Question div
	                    var frag = document.createDocumentFragment();
			  			var div_head = document.createElement("div");
			  			div_head.setAttribute("id","replyOne");
			  			
			  			var ul_afterHead= document.createElement("ul");
			  			ul_afterHead.className="timeline";
			  			div_head.appendChild(ul_afterHead);
			  			
			  			
			  			var li_afterUl=document.createElement("li");
			  			ul_afterHead.appendChild(li_afterUl);
			  			
			  			
			  			var div_afterLi1 = document.createElement("div");
			  			div_afterLi1.className="timeline-badge";
			  			li_afterUl.appendChild(div_afterLi1);
			  			
			  			var i_afterDiv = document.createElement("i");
			  			i_afterDiv.className="glyphicon glyphicon-check";
			  			div_afterLi1.appendChild(i_afterDiv);
			  			
			  			var div_afterLi2 = document.createElement("div");
			  			div_afterLi2.className="timeline-panel";
			  			li_afterUl.appendChild(div_afterLi2);
			  			
			  			var div_afterDiv2 = document.createElement("div");
			  			div_afterDiv2.className="timeline-heading";
			  			div_afterLi2.appendChild(div_afterDiv2);
			  			
			  			var h4_afterDiv2_1 = document.createElement("h4");
			  			h4_afterDiv2_1.className="timeline-title";
			  			var txt_h4=document.createTextNode("會員提問");
			  			h4_afterDiv2_1.appendChild(txt_h4);
			  			div_afterDiv2.appendChild(h4_afterDiv2_1);
			  			
			  			var p_afterDiv2_1 = document.createElement("p");
			  			div_afterDiv2.appendChild(p_afterDiv2_1);
			  			
			  			var small_afterP = document.createElement("small");
			  			small_afterP.className="text-muted";
			  			
			  			var i_afterP = document.createElement("i");
			  			i_afterP.className="glyphicon glyphicon-time";
			  			small_afterP.appendChild(i_afterP);
			  			small_afterP.setAttribute("style","word-break: break-all");
			  			var txt_small=document.createTextNode(quest_qtimeValue);  //須拿提問時間
			  			small_afterP.appendChild(txt_small);
			  			p_afterDiv2_1.appendChild(small_afterP);
						
			  			var div2_afterDiv2 = document.createElement("div");
			  			div2_afterDiv2.className="timeline-body";
			  			div_afterLi2.appendChild(div2_afterDiv2);
			  			
			  			var p_afterDiv2_2 = document.createElement("p");
			  			p_afterDiv2_2.setAttribute("style","word-break: break-all");
			  			var txt_p=document.createTextNode(quest_quizValue);       //須拿提問內容
			  			p_afterDiv2_2.appendChild(txt_p);
			  			div2_afterDiv2.appendChild(p_afterDiv2_2);
			  			
			  			// Reply div
			  			var li2_afterUl=document.createElement("li");
			  			li2_afterUl.className="timeline-inverted";
			  			ul_afterHead.appendChild(li2_afterUl);
			  			
			  			var div1_afterLi2 = document.createElement("div");
			  			div1_afterLi2.className="timeline-badge warning";
			  			li2_afterUl.appendChild(div1_afterLi2);
			  			
			  			var i2_afterDiv = document.createElement("i");
			  			i2_afterDiv.className="glyphicon glyphicon-credit-card";
			  			div1_afterLi2.appendChild(i2_afterDiv);
			  			
			  			var div2_afterLi2 = document.createElement("div");
			  			div2_afterLi2.className="timeline-panel";
			  			li2_afterUl.appendChild(div2_afterLi2);
			  			
			  			var div_afterLi2Div2 = document.createElement("div");
			  			div_afterLi2Div2.className="timeline-heading";
			  			div2_afterLi2.appendChild(div_afterLi2Div2);
			  			
			  			var h42_afterDiv2_1 = document.createElement("h4");
			  			h42_afterDiv2_1.className="timeline-title";
			  			var txt_h42=document.createTextNode("管理員回覆");
			  			h42_afterDiv2_1.appendChild(txt_h42);
			  			div_afterLi2Div2.appendChild(h42_afterDiv2_1);
			  			
			  			var p2_afterDiv2_1 = document.createElement("p");
	                    div_afterLi2Div2.appendChild(p2_afterDiv2_1);
			  			
			  			var small2_afterP = document.createElement("small");
			  			small2_afterP.className="text-muted";
			  			
			  			var i2_afterP = document.createElement("i");
			  			i2_afterP.className="glyphicon glyphicon-time";
			  			small2_afterP.appendChild(i_afterP);
			  			small2_afterP.setAttribute("style","word-break: break-all");
			  			var txt2_small=document.createTextNode(quest_rtimeValue);  //須拿回覆時間
			  			small2_afterP.appendChild(txt2_small);
			  			p2_afterDiv2_1.appendChild(small2_afterP);
			  			
			  			var div2_afterLi2Div2 = document.createElement("div");
			  			div2_afterLi2Div2.className="timeline-body";
			  			div2_afterLi2.appendChild(div2_afterLi2Div2);
			  			
			  			var p2_afterDiv2_2 = document.createElement("p");
			  			p2_afterDiv2_2.setAttribute("style","word-break: break-all");
			  			var txt2_p=document.createTextNode(quest_replyValue);       //須拿回覆內容
			  			p2_afterDiv2_2.appendChild(txt2_p);
			  			div2_afterLi2Div2.appendChild(p2_afterDiv2_2);
			  			
			  			frag.appendChild(div_head);
			  			
			  			rowClosest.after(frag);
			        }
		    })
  			
            $(".btn-warning").click(function() {
               $(this).parent().parent().next('#replyOne').remove();
	        })
	      
	       $(".btn-danger").click(function(){
	    	   $("#myModal").modal();
	    	   errMsgSpan = $('form[name="addQuest"] p');
	    	   errMsgSpan.remove();
		        
		        $("#btnInsert").off('click').on('click',function() {
// 					errMsgSpan = $('form[name="addQuest"] span');
// 					errMsgSpan.remove();
					var form = $(document.addQuest).serializeArray(), json = {};
					
					json["quest_quiz"]=quest_quiz;
					json["quest_catalog"]=quest_catalog;
					json["quest_topic"]=quest_topic;
					json["quest_qtime"]=quest_qtime;
					json["mem_uid"]=mem_uid;
					json["admin_id"]=${admin.admin_id};
					
					for (var i = 0; i < form.length; i++) {
						
						if (form[i].value.length > 0) {
							json[form[i].name] = form[i].value;
						}
						console.log(json);
					}
					$.post("ReplyServlet", JSON.stringify(json)).done(function(data) {
						console.log(JSON.stringify(json));
						$.each(data, function(errTrip, errMsg) {
							
							if (errMsg == "回覆成功") {
								document.addQuest.reset();
								errMsgSpan.empty();
                                setTimeout(function() { $('#myModal').modal('hide'); }, 1500);
								
								BootstrapDialog.alert({
									 title: $('<h4 style="color:white !important;text-align: center;font-weight:bold"><span class="glyphicon glyphicon-check"></span>回覆問題成功</h4>'),
							         message: $('<p style="color:blue;font-weight:bold;text-align:ccenter">謝謝您的回覆，此提問已完成處理！</p>')
							    });
							}
							
							var errSpan = document.createElement("p");
							var errText = document.createTextNode(errMsg);
							var errId = 'err' + errTrip;
							errSpan.appendChild(errText);
							errSpan.setAttribute("style", "color:red");
							errSpan.setAttribute("id", errId);
							$('#' + errId).remove();
							$('#' + errTrip).after(errSpan);
							
							
						});
						console.log("200.");
					}).fail(function(xhr) {
						console.log("ERR.");
					});
				});
           })
           
           
       })
       
	   $("#quest_cancel").click(function() {
		   $('#replyAll').hide();
	   })
	   
	   //分页
// 	   $("#demo1").paginate({
// 	       count: 10,
// 	       start: 1,
// 	       display: 10,
// 	       border: true,
// 	       onChange: function(page) {
// 	    	   location.href = "list.aspx?id=" + page;
// 	       }
// 	   });
	   $("#txt_topic").hover(function(){
		   $('.tooltip-show').tooltip('hide')
		                     .attr('data-original-title', '請輸入查詢標題')
		                     .tooltip('show');
		});
	
	})
	
	</script>
<jsp:include page="/emsPart2.jsp"/>

