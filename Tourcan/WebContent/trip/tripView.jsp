<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/frontPageHeader.jsp"/>
	<div class="container">

		<div class="row" style="display: block" id="title1">
			<div class="col-sm-6 col-sm-offset-2">
				<h1>建立行程</h1>
			</div>
		</div>
		<div class="row" style="display: none" id="title2">
			<div class="col-sm-6 col-sm-offset-2">
				<h1>行程規劃</h1>
			</div>
		</div>

		<div class="row">
			<div class="row col-sm-7 ">
				<!--新增行程 -->
				<div class="row addTripDiv col-sm-12">
					<div class="col-sm-10 col-sm-offset-2 form-group">
						<label>新增行程名稱：</label> 
						<input type="text" id="trip_name" name="trip_name" placeholder="請輸入行程名稱" autofocus>
					</div>
					<div class="col-sm-2 col-sm-offset-2">
						<button type="button" class="btn-success form-control" id="addTripBtn">新增</button>
					</div>
					<div class="col-sm-2 col-sm-offset-2">
						<button type="button" class="btn-danger form-control" id="deleteTripBtn">重設</button>
					</div>
				</div>			
			
				<div  id="start" class="row div1 col-sm-12">
					<div class="col-sm-10 form-group">
						<label>出發地點：</label> <input type="text" id="possition"
							placeholder="地址或景點名稱">
					</div>
					<div class="col-sm-10 form-group">
						<label for="attName">出發時間：</label> <input type="datetime-local" id="sTime" name="sTime">
					</div>
					<div class="col-sm-12 form-group">
<!-- 						<label>交通方式：</label>  -->
<!-- 						<input type="radio" name="traffic" id="changemode-driving" value="car" checked> -->
<!-- 						<label for="changemode-driving">開車</label> -->
<!-- 						<input type="radio" name="traffic" id="changemode-transit" value="public"> -->
<!-- 						<label for="changemode-transit">大眾運輸</label> -->
<!-- 						<input type="radio" name="traffic" id="changemode-walking" value="walk"> -->
<!-- 						<label for="changemode-walking">步行</label> -->
						<label>
							<span>到下一站距離：</span>
							<span id="tDistance"></span>
							<span style="margin-left: 10px">時間:</span>
							<span id="tTime" name="tTime"></span>
						</label>
						<input name="tripitem_begin" type="number" style="display: none"/>
						<input name="tripitem_staytime" type="number" style="display: none"/>
						<input name="tripitem_end" type="number" style="display: none"/>
					</div>
				</div>
				
				<input type="button" class="row div2 col-sm-12" id="addTripitemBtn"
					value="+新增行程...">
					
				<div class="row div3 col-sm-12" style="display: none" id="div3">
					<div class="col-sm-12 form-group">
						<label>選擇縣市：</label> 
						<select  id="region_id" name="region_id">
							<option value="0">請選擇</option>
						</select> 
						<label>類型：</label> 
						<select  id="tripType" name="tripType">
							<option value="0">請選擇</option>
							<option value="1">景點</option>
							<option value="2">住宿</option>
						</select> 
					    <button type="button" id="searchRegion">查詢</button>
					</div>
					<div class="col-sm-12 form-group">
						<label>景點查詢：</label>
						<input type="text" id="attname" name="attname" placeholder="直接查詢景點名稱">
						<button type="button" id="searchAtt">查詢</button>
					</div>
				</div>
			</div>
			
			<div class="col-sm-5">
				<div class="row">
					<div class="col-sm-12" id="mapPreview"></div>
				</div>
				<div class="row" style="margin-top: 20px">
					<div class="col-sm-6 col-sm-offset-3 form-group">
						<button type="button" class="btn-success form-control" id="saveBtn">Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	  	var sTime,tTime,wTime,eTime;
		var coder, map, marker, checkTrigger, lastValue = "";
		var regionList;
		var serviceProvider = "${contextPath}/hotels";
		var addrArray=[];
		var trip_id=null;
		//定義sortable form
		var tripForm=$("<form></form>").attr("id","tripForm").attr("style","clear:both; margin-right: 28px;")
		var sortDiv=$("<div></div>").attr("id","sortable");
		var count = "A";
		var sumBudget=0;
		
		function initMap() {
			var initPos = new google.maps.LatLng(25.042485, 121.543543);
			var directionsService = new google.maps.DirectionsService;
			var directionsDisplay = new google.maps.DirectionsRenderer;
			var map = new google.maps.Map(
					document.getElementById('mapPreview'), {
						center : initPos,
						zoom : 15,
						mapTypeId : google.maps.MapTypeId.ROADMAP,
					});
			
			directionsDisplay.setMap(map);

						calculateAndDisplayRoute(directionsService,directionsDisplay);

		}
		
		function calculateAndDisplayRoute(directionsService, directionsDisplay) {
			var point = [];
			var waypts = [];
			var lastPos=addrArray[addrArray.length-1];
			for (var i = 0; i < addrArray.length-1; i++) {
				waypts.push({
					location : addrArray[i],
				});
			}
			directionsService.route({
				origin :$("#possition").val(),
				destination :"\""+lastPos+"\"",
				waypoints : waypts,
				optimizeWaypoints : false,
				travelMode : google.maps.TravelMode.DRIVING
			}, function(response, status) {
				if (status === google.maps.DirectionsStatus.OK) {
					directionsDisplay.setDirections(response);
					var route = response.routes[0];
					$("#tDistance").empty();
					$("#tTime").empty();
					
					$("#sortable span[name='tDistance']").empty();
					$("#sortable span[name='tTime']").empty();

					$("#tDistance").append(route.legs[0].distance.text);
					$("#tTime").append(route.legs[0].duration.text);
					
		            $("#sortable>table").each(function(idx,table){
// 		            	console.log("idx="+idx);
// 		            	console.log("table="+table);
						if(parseInt(idx)<(addrArray.length-1)){
		            	$(this).find("span[name='tDistance']").append(route.legs[(parseInt(idx)+1)].distance.text);
		            	$(this).find("span[name='tTime']").append(route.legs[(parseInt(idx)+1)].duration.text);
						}
		            });
			  		timeInit();
			  		timeReveal();
					      for (var i = 0; i < route.legs.length; i++) {
					    	  console.log(route.legs[i].distance.text);
					    	  console.log(route.legs[i].duration.text);
					      }
				}
			});
		}
		
		
		// ↓ 依"啟程"的出發時間為基準，初始化基準值  ↓
		  function timeInit()
		  {
			  //console.log("initial start...");
			  sTime = new Date($("#start input[name='sTime']").val().replace('T'," ")).getTime();
			  console.log(sTime);
			  tTime = parseInt($("#start span[name='tTime']").text())*60*1000;
			  wTime = 0;
			  eTime = sTime + tTime + wTime;
			  $("#start input[name='tripitem_begin']").val(sTime);
			  $("#start input[name='tripitem_staytime']").val(0);
			  $("#start input[name='tripitem_end']").val(eTime);
			  //console.log("initial done.");
		  }
		// ↑ 依"啟程"的出發時間為基準，初始化基準值   ↑
		
		
			//刪除景點明細
			function deleteTripitem(){
				$(".deleteTripitem").off('click').on('click',function(){
					addrArray.splice($( ".deleteTripitem" ).index($( this )),1);
					$(this).parent().parent().parent().parent().remove();
					initMap();
				})
			}
		
			// ↓ 將所有sortable元素的Time帶入值，並準備轉交給下一個item  ↓
			  function timeReveal()
			  {
				  console.log("reveal start...");	  
					$("#sortable").children().each(function(){
					  sTime = eTime;
					  
// 					  console.log(new Date(sTime)); //解開註解，可看該毫秒數所指日期。
					  $(this).find('input[name="tripitem_begin"]').val(sTime);
					  
					  var newSt = new Date(sTime).toTimeString();
					  var sTidx = newSt.indexOf("G");
					  newSt = "起：" + newSt.substr(0,sTidx-4);
					  
					  $(this).find('p[name=sTime]').text(newSt);
					  tTime = parseInt($(this).find('span[name="tTime"]').text())*60*1000;
					  wTime = $(this).find('input[name="wTime"]').val();

					  $(this).find('input[name="tripitem_staytime"]').val(wTime);
					  
					  wTime = wTime*60*1000;
					  var newEt = new Date(eTime+wTime).toTimeString();
					  var eTidx = newEt.indexOf("G");
					  newEt = "訖：" + newEt.substr(0,eTidx-4);

					  //console.log(new Date(sTime+wTime)); //解開註解，可看該毫秒數所指日期。
					  $(this).find('input[name="tripitem_end"]').val(sTime+wTime);
					  
					  $(this).find('p[name="eTime"]').text(newEt);
					  
					  eTime = sTime + tTime + wTime;
				  });
				  console.log("reveal done.");	  
			  }
			// ↑ 將所有sortable元素的Time帶入值，並準備轉交給下一個item  ↑
			
			
			
			
		
		$(function(){
			//監聽每一個input的變化
	  		$(document).on("change","input[name$='Time']",function(){
		  		console.log("input changed");
// 		  		console.log($("#start input[name='sTime']").val());
		  		timeInit();
		  		timeReveal();
	  		}); 
			
	  		$("#possition").on("change",function(){
				initMap();
	  		})
			
			//拖拉排序
			function sortable(){
				$( "#sortable" ).sortable({
		        	update: function(event,ui){
						 timeInit();
						 timeReveal();
						 
			             addrArray.length=0;
			             console.log("array="+addrArray.length);
			             $("#sortable>table").each(function(){
			             	console.log($(this).find("input[name$='addr']").val());
			             	addrArray.push($(this).find("input[name$='addr']").val());
			             });
			             initMap();
					 	 }
			    }).disableSelection();
			}

			//新增行程
			$("#addTripBtn").off('click').on('click',function(){
				var tripName=$("#trip_name").val();
				var json={"trip_name":tripName,"trip_price":0};
				$("#errMsg1").remove();
				$.post("TripServlet",JSON.stringify(json),function(data){
					console.log(data);
					if(data.result[0]=="新增失敗。"){
						var errMsg1=$("<span></span>").attr("style","color:red;font-size:70%").attr("id","errMsg1").text(data.trip_name[0])
						$("#trip_name").after(errMsg1);
					}else{
// 						console.log("tripId="+data.trip_id[0]);
						trip_id=data.trip_id[0];
						$(".addTripDiv").css("display","none");
						$(".div1").css("display","block");
						$(".div2").css("display","block");
						$("#title1").css("display","none");
						$("#title2").css("display","block");
					}
				})
			})  //移除錯誤訊息
			$("#deleteTripBtn").off('click').on('click',function(){
				$("#trip_name").val("");
				$("#errMsg1").remove();				
			})
			
			//加入行程
			$('#addTripitemBtn').off('click').on('click',function(){
				if($("#possition").val().trim().length==0 || $("#sTime").val().trim().length==0){
					alert("請輸入出發地點及完整時間");
				}else{
					$("#addTripitemBtn").css("display","none");
					$("#div3").css("display","block");
				}
			});
			
			//加入縣市
			$.get("../att/RegionServlet").done(
					function(list) {
						regionList = list;
						var frag = document.createDocumentFragment();
						for (var i = 1; i < list.length; i++)
							frag.appendChild(new Option(list[i].region_name,list[i].region_id));
						$("#region_id").append(frag);
					}).fail(function(xhr) {
				console.log("Get region list unsuccessful.");
			});
			

			
// --------------------------↓ 開始長出所有表格 ↓------------------------------------			
			
			//列出所有選擇區域之景點類型form表單
			$("#searchRegion").off('click').on('click',function(){
				var regionId=$('#region_id').val();
				var tripType=$('#tripType').val();
				var nullSpan1=null;
				$("#selectForm").remove();
				$("#nullSpan1").remove();
				$("#nullSpan2").remove();
				console.log(regionId);
				console.log(tripType);
				//沒有選擇區域及類型之錯誤驗證
				if(regionId == 0 || tripType ==0){
					var nullSpan1=$("<span></span>").attr("style","color:red;font-size:70%").attr("id","nullSpan1").text("請選擇區域及類型")
					$("#searchRegion").after(nullSpan1);
				//選擇區域及景點類型之判斷
				}else if(regionId != 0 && tripType ==1){
					var attForm=document.createElement("form");
					attForm.setAttribute("class","row div4 col-sm-12");
					attForm.setAttribute("id","selectForm");
					$.get(("../att/AttServlet"),{"regionId":regionId,"method":"getByRegionId"},function(data){
					console.log("data="+data);
					$.each(data,function(idx,att){
// 						console.log("idx="+idx);
// 						console.log("att="+att);
// 						console.log("test");
						var attDiv=document.createElement("div");
						attDiv.setAttribute("class","col-sm-12 divAtt form-group");
						
						var imgDiv=document.createElement("div");
						imgDiv.setAttribute("class","row col-sm-3");
						
						var urlA=document.createElement("a");
						urlA.setAttribute("href",att.att_url);
						urlA.setAttribute("target","_new");
						
						var attLabel =document.createElement("label");
						var attText = document.createTextNode(att.att_name);
						attLabel.appendChild(attText);
						urlA.appendChild(attLabel);
						imgDiv.appendChild(urlA);
						
						var openLabel=document.createElement("label");
						openLabel.setAttribute("class","row col-sm-3");
						var openText=document.createTextNode("開放時間:");
						openLabel.appendChild(openText);
						
						var contentH5=document.createElement("h5");
						contentH5.setAttribute("class","row col-sm-6");
						contentH5.setAttribute("style","word-break: break-all; margin-right:5px; text-align:left");
						var contentText=document.createTextNode(att.att_open);
						contentH5.appendChild(contentText);
						
						var butDiv=document.createElement("div");
						butDiv.setAttribute("class","row");
						
						var checkInput=document.createElement("input");
						checkInput.setAttribute("type","checkbox");
						checkInput.setAttribute("value",att.att_name);
						checkInput.setAttribute("name","attCheck");

						butDiv.appendChild(checkInput);
						attDiv.appendChild(imgDiv);
						attDiv.appendChild(openLabel);
						attDiv.appendChild(contentH5);
						attDiv.appendChild(butDiv);	
						attForm.appendChild(attDiv);
					})
					var sendBtn=document.createElement("input");
					sendBtn.setAttribute("type","button");
					sendBtn.setAttribute("id","sendBtn");
					sendBtn.setAttribute("value","加入選取行程");
					sendBtn.setAttribute("style","margin:5px");
					attForm.appendChild(sendBtn);
					$("#div3").after(attForm);
					
					//景點選單送出
				    $("#sendBtn").off('click').on('click',function(){
						$("#addTripitemBtn").css("display","block");
						$("#div3").css("display","none");
						tripForm.append(sortDiv);

				    	var selected=[];
				        $("input[name='attCheck']:checked").each(function(){
							var attname1=$(this).val();
							$.get("../att/AttServlet",{"attname":attname1,"method":"getByName"},function(data1){
								count= count+"A";
								$.each(data1,function(idx1,att1){
// 									console.log("idx1="+idx1);
// 									console.log("att1="+att1);
// 									console.log("addr="+att1.att_addr);
									var tripitemTable=$("<table></table>").attr("style","width: 100% ;table-layout: fixed;margin-top: 10px");
// 									var lable1=$("<lable></lable>").text("下一站交通方式:");
// 									var input1=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("checked","checked").attr("value","car");
// 									var input2=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","public");
// 									var input3=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","walk");
// 									var lableA=$("<lable></lable>").text("開車").prepend(input1);
// 									var lableB=$("<lable></lable>").text("大眾運輸").prepend(input2);
// 									var lableC=$("<lable></lable>").text("步行").prepend(input3);
// 									var th1=$("<th></th>").css("display","none").attr("colspan","7").append([lable1,lableA,lableB,lableC]);
									
// 									var span1=$("<span></span>").text("到下一站距離：");
// 									var span2=$("<span></span>").attr("name","tDistance");
// 									var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
// 									var span4=$("<span></span>").attr("name","tTime");
// 									var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
// 									var th2=$("<th></th>").attr("colspan","12").append(lable2);
									
// 									var tr1=$("<tr></tr>").append([th1,th2]);
// 									var tripitemThead=$("<thead></thead>").attr("class","div5").append(tr1);
									
									var input4=$("<input></input>").attr("type","hidden").attr("name","att_addr").attr("value",att1.att_addr);
									var input5=$("<input></input>").attr("type","hidden").attr("name","att_id").attr("value",att1.att_id);
									var td1=$("<td></td>").attr("colspan","3").append([input4,input5]);
									
									var p1=$("<p></p>").html("預算:<input name='tripitem_price' type='number' style='width:60px' value='0' min='0'>元");
									var td2=$("<td></td>").attr("colspan","3").append(p1);
									var p2=$("<p></p>").html("停留:<input name='wTime' type='number' style='width:60px' value='0' min='0'>分");
									var td3=$("<td></td>").attr("colspan","3").append(p2);
									
									var p3=$("<p></p>").attr("name","sTime").text("起：");
									var td4=$("<td></td>").attr("colspan","3").append(p3);
									
									var lable3=$("<lable></lable>").text(attname1);
									var urlAA=$("<a></a>").attr("href",att1.att_url).attr("target","_new").append(lable3);
									var td5=$("<td></td>").attr("colspan","3").attr("style","text-align:center").append(urlAA);
									
									var p4=$("<p></p>").text("註記:");
									var td6=$("<td></td>").attr("colspan","3").append(p4);
									
									var td7=$("<td></td>").attr("colspan","3");
									
									var p5=$("<p></p>").attr("name","eTime").text("迄：");
									var td8=$("<td></td>").attr("colspan","3").append(p5);
									
									var td9=$("<td></td>").attr("colspan","3");
									
									var textarea1=$("<textarea></textarea>").attr("name","tripitem_memo").attr("rows","2").attr("style","width:100%").attr("placeholder","註記:");
									var td10=$("<td></td>").attr("colspan","6").append(textarea1);
									
									var input6=$("<input></input>").attr("type","button").attr("class","deleteTripitem").attr("style","margin-left: 7px").attr("value","刪除"); 
									var td11=$("<td></td>").attr("colspan","3").append(input6);
									
									var tr2=$("<tr></tr>").append([td1,td2,td3,td4]);
									var tr3=$("<tr></tr>").append([td5,td6,td7,td8]);
									var tr4=$("<tr></tr>").append([td9,td10,td11]);
									
									var span1=$("<span></span>").text("到下一站距離：");
									var span2=$("<span></span>").attr("name","tDistance");
									var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
									var span4=$("<span></span>").attr("name","tTime");
									var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
									var td12=$("<td></td>").attr("colspan","12").append(lable2);
									
									var tr1=$("<tr></tr>").attr("class","div5").append(td12);
									
									var tripitemTbody=$("<tbody></tbody>").attr("class","div6").append([tr2,tr3,tr4,tr1]);
									
									tripitemTable.append(tripitemTbody);

									//新增__input(目前非hidden)，以便取item內值送至servlet --------------------------------------------
									var startTime = $("<input></input>").attr("type","number").attr("name","tripitem_begin");
									var wonderTime = $("<input></input>").attr("type","number").attr("name","tripitem_staytime");
									var endTime = $("<input></input>").attr("type","number").attr("name","tripitem_end");
									
									var begin = $("<label></label>").text("begin：").append(startTime);
									var staytime = $("<label></label>").text("staytime：").append(wonderTime);
									var endtime = $("<label></label>").text("end：").append(endTime);

									var dataBox = $("<div></div>").attr("style","display:none").append([begin,staytime,endtime]);
									tripitemTable.append(dataBox);
								   //-------------------------------------------------------------------------------啟程初始值請另取值
									
									sortDiv.append(tripitemTable);
									
									
									addrArray.push(att1.att_addr);
									
								})
								initMap();
								
								sortable();
							    
								deleteTripitem();
							})
				       	});
// 				        alert("景點名稱 : " + selected.join());
                        $("#div3").after(tripForm);
						$("#div3 input").val("");
						$("#region_id option[value='0']").prop("selected",true);
						$("#tripType option[value='0']").prop("selected",true);
						$("#selectForm").remove();
				    });
				  })
				//選擇區域及住宿類型的判斷
				}else if(regionId != 0 && tripType ==2){
					var attForm=document.createElement("form");
					attForm.setAttribute("class","row div4 col-sm-12");
					attForm.setAttribute("id","selectForm");
					$.ajax({
						url : serviceProvider+"/region/"+regionId,
						method : "GET"
					}).done(function(data) {
						console.log("200: " + data);
						$.each(data,function(idx,hotel){
	 						console.log("idx="+idx);
	 						console.log("att="+hotel);
	 						console.log("test");
							var attDiv=document.createElement("div");
							attDiv.setAttribute("class","col-sm-12 divAtt form-group");
							
							var imgDiv=document.createElement("div");
							imgDiv.setAttribute("class","row col-sm-3");
							
							var urlA=document.createElement("a");
							urlA.setAttribute("href",hotel.hotel_url);
							urlA.setAttribute("target","_new");
							
							var attLabel =document.createElement("label");
							var attText = document.createTextNode(hotel.hotel_name);
							attLabel.appendChild(attText);
							urlA.appendChild(attLabel);
							imgDiv.appendChild(urlA);
							
							var openLabel=document.createElement("label");
							openLabel.setAttribute("class","row col-sm-2");
							var openText=document.createTextNode("電話:");
							openLabel.appendChild(openText);
							
							var contentH5=document.createElement("h5");
							contentH5.setAttribute("class","row col-sm-3");
							contentH5.setAttribute("style","word-break: break-all; margin-right:5px; text-align:left");
							var contentText=document.createTextNode(hotel.hotel_phone);
							contentH5.appendChild(contentText);
							
							var classLabel=document.createElement("label");
							classLabel.setAttribute("class","row col-sm-4");
							var classText=document.createTextNode(hotel.hotel_class+"星等");
							classLabel.appendChild(classText);
							
							var butDiv=document.createElement("div");
							butDiv.setAttribute("class","row");
							
							var checkInput=document.createElement("input");
							checkInput.setAttribute("type","checkbox");
							checkInput.setAttribute("value",hotel.hotel_name);
							checkInput.setAttribute("name","attCheck");

							butDiv.appendChild(checkInput);
							attDiv.appendChild(imgDiv);
							attDiv.appendChild(openLabel);
							attDiv.appendChild(contentH5);
							attDiv.appendChild(classLabel);
							attDiv.appendChild(butDiv);	
							attForm.appendChild(attDiv);
						})
						var sendBtn=document.createElement("input");
						sendBtn.setAttribute("type","button");
						sendBtn.setAttribute("id","sendBtn");
						sendBtn.setAttribute("value","加入選取行程");
						sendBtn.setAttribute("style","margin:5px");
						attForm.appendChild(sendBtn);
						$("#div3").after(attForm);
						
						//景點選單送出
					    $("#sendBtn").off('click').on('click',function(){
							$("#addTripitemBtn").css("display","block");
							$("#div3").css("display","none");
							tripForm.append(sortDiv);

					    	var selected=[];
					        $("input[name='attCheck']:checked").each(function(){
								var hotelname1=$(this).val();
								$.ajax({
									url : serviceProvider+"/name/"+hotelname1,
									method : "GET"
								}).done(function(data1){
									count = count+"B";
									$.each(data1,function(idx1,hotel1){
	 									console.log("idx1="+idx1);
	 									console.log("hotel1="+hotel1);
	 									console.log("addr="+hotel1.hotel_addr);
										var tripitemTable=$("<table></table>").attr("style","width: 100% ;table-layout: fixed;margin-top: 10px");
										
// 										var lable1=$("<lable></lable>").text("下一站交通方式:");
// 										var input1=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("checked","checked").attr("value","car");

// 										var input2=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","public");
// 										var input3=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","walk");
// 										var lableA=$("<lable></lable>").text("開車").prepend(input1);
// 										var lableB=$("<lable></lable>").text("大眾運輸").prepend(input2);
// 										var lableC=$("<lable></lable>").text("步行").prepend(input3);
// 										var th1=$("<th></th>").css("display","none").attr("colspan","7").append([lable1,lableA,lableB,lableC]);
										
// 										var span1=$("<span></span>").text("到下一站距離：");
// 										var span2=$("<span></span>").attr("name","tDistance");
// 										var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
// 										var span4=$("<span></span>").attr("name","tTime");
// 										var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
// 										var th2=$("<th></th>").attr("colspan","12").append(lable2);
										
// 										var tr1=$("<tr></tr>").append([th1,th2]);
// 										var tripitemThead=$("<thead></thead>").attr("class","div5").append(tr1);
										
										var input4=$("<input></input>").attr("type","hidden").attr("name","hotel_addr").attr("value",hotel1.hotel_addr);
										var input5=$("<input></input>").attr("type","hidden").attr("name","hotel_id").attr("value",hotel1.hotel_id);
										var td1=$("<td></td>").attr("colspan","3").append([input4,input5]);
										
										var p1=$("<p></p>").html("預算:<input name='tripitem_price' type='number' style='width:60px' value='0' min='0'>元");
										var td2=$("<td></td>").attr("colspan","3").append(p1);
										
										var p2=$("<p></p>").html("停留:<input name='wTime' type='number' style='width:60px' value='0' min='0'>分");
										var td3=$("<td></td>").attr("colspan","3").append(p2);
										
										var p3=$("<p></p>").attr("name","sTime").text("起：");
										var td4=$("<td></td>").attr("colspan","3").append(p3);
										
										var lable3=$("<lable></lable>").text(hotelname1);
										var urlAA=$("<a></a>").attr("href",hotel1.hotel_url).attr("target","_new").append(lable3);
										var td5=$("<td></td>").attr("colspan","3").attr("style","text-align:center").append(urlAA);
										
										var p4=$("<p></p>").text("註記:");
										var td6=$("<td></td>").attr("colspan","3").append(p4);
										
										var td7=$("<td></td>").attr("colspan","3");
										
										var p5=$("<p></p>").attr("name","eTime").text("迄：");
										var td8=$("<td></td>").attr("colspan","3").append(p5);
										
										var td9=$("<td></td>").attr("colspan","3");
										
										var textarea1=$("<textarea></textarea>").attr("name","tripitem_memo").attr("rows","2").attr("style","width:100%").attr("placeholder","註記:");
										var td10=$("<td></td>").attr("colspan","6").append(textarea1);
										
										var input6=$("<input></input>").attr("type","button").attr("class","deleteTripitem").attr("style","margin-left: 7px").attr("value","刪除"); 
										var td11=$("<td></td>").attr("colspan","3").append(input6);
										
										var tr2=$("<tr></tr>").append([td1,td2,td3,td4]);
										var tr3=$("<tr></tr>").append([td5,td6,td7,td8]);
										var tr4=$("<tr></tr>").append([td9,td10,td11]);
										
										var span1=$("<span></span>").text("到下一站距離：");
										var span2=$("<span></span>").attr("name","tDistance");
										var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
										var span4=$("<span></span>").attr("name","tTime");
										var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
										var td12=$("<td></td>").attr("colspan","12").append(lable2);
										
										var tr1=$("<tr></tr>").attr("class","div5").append(td12);
										
										var tripitemTbody=$("<tbody></tbody>").attr("class","div6").append([tr2,tr3,tr4,tr1]);
										
										tripitemTable.append(tripitemTbody);
										
										//新增__input(目前非hidden)，以便取item內值送至servlet --------------------------------------------
										var startTime = $("<input></input>").attr("type","number").attr("name","tripitem_begin");
										var wonderTime = $("<input></input>").attr("type","number").attr("name","tripitem_staytime");
										var endTime = $("<input></input>").attr("type","number").attr("name","tripitem_end");
										
										var begin = $("<label></label>").text("begin：").append(startTime);
										var staytime = $("<label></label>").text("staytime：").append(wonderTime);
										var endtime = $("<label></label>").text("end：").append(endTime);

										var dataBox = $("<div></div>").attr("style","display:none").append([begin,staytime,endtime]);
										tripitemTable.append(dataBox);
									   //-------------------------------------------------------------------------------啟程初始值請另取值
										
										sortDiv.append(tripitemTable);
										
										addrArray.push(hotel1.hotel_addr);
									})
									
									initMap();
									
									sortable();
								    
									deleteTripitem();
								})
					       	});
	                        $("#div3").after(tripForm);
							$("#div3 input").val("");
							$("#region_id option[value='0']").prop("selected",true);
							$("#tripType option[value='0']").prop("selected",true);
							$("#selectForm").remove();
					    });
					})
				}
			});
			
			$("#searchAtt").off('click').on('click',function() {
				$("#selectForm").remove();
				$("#nullSpan1").remove();
				$("#nullSpan2").remove();
				//判斷attname是否輸入
				var attname = $("#attname").val();
				if(attname.trim().length==0){
					var nullSpan2=$("<span></span>").attr("style","color:red;font-size:70%").attr("id","nullSpan2").text("請輸入景點名稱")
					$("#searchAtt").after(nullSpan2);
				}else{
				//列出所有查詢之景點form表單
				var attForm=document.createElement("form");
				attForm.setAttribute("class","row div4 col-sm-12");
				attForm.setAttribute("id","selectForm");
				$.get(("../att/AttServlet"),{"attname":attname,"method":"getByName"},function(data){
					console.log("data="+data);
					if(data<1){
						alert("查無資料");
					}else{
					$.each(data,function(idx,att){
// 						console.log("idx="+idx);
// 						console.log("att="+att);
// 						console.log("test");
						var attDiv=document.createElement("div");
						attDiv.setAttribute("class","col-sm-12 divAtt form-group");
						
						var imgDiv=document.createElement("div");
						imgDiv.setAttribute("class","row col-sm-3");
						
						var urlA=document.createElement("a");
						urlA.setAttribute("href",att.att_url);
						urlA.setAttribute("target","_new");
						
						var attLabel =document.createElement("label");
						var attText = document.createTextNode(att.att_name);
						attLabel.appendChild(attText);
						urlA.appendChild(attLabel);
						imgDiv.appendChild(urlA);
						
						var openLabel=document.createElement("label");
						openLabel.setAttribute("class","row col-sm-3");
						var openText=document.createTextNode("開放時間:");
						openLabel.appendChild(openText);
						
						var contentH5=document.createElement("h5");
						contentH5.setAttribute("class","row col-sm-6");
						contentH5.setAttribute("style","word-break: break-all; margin-right:5px; text-align:left");
						var contentText=document.createTextNode(att.att_open);
						contentH5.appendChild(contentText);
						
						var butDiv=document.createElement("div");
						butDiv.setAttribute("class","row");
						
						var checkInput=document.createElement("input");
						checkInput.setAttribute("type","checkbox");
						checkInput.setAttribute("value",att.att_name);
						checkInput.setAttribute("name","attCheck");

						butDiv.appendChild(checkInput);
						attDiv.appendChild(imgDiv);
						attDiv.appendChild(openLabel);
						attDiv.appendChild(contentH5);
						attDiv.appendChild(butDiv);	
						attForm.appendChild(attDiv);
					})
					var sendBtn=document.createElement("input");
					sendBtn.setAttribute("type","button");
					sendBtn.setAttribute("id","sendBtn");
					sendBtn.setAttribute("value","送出");
					sendBtn.setAttribute("style","margin:5px");
					attForm.appendChild(sendBtn);
					$("#div3").after(attForm);
					
				
					//景點選單送出
				    $("#sendBtn").off('click').on('click',function(){
						$("#addTripitemBtn").css("display","block");
						$("#div3").css("display","none");
						tripForm.append(sortDiv);
				    	var selected=[];
				        $("input[name='attCheck']:checked").each(function(){
							var attname1=$(this).val();
							$.get("../att/AttServlet",{"attname":attname1,"method":"getByName"},function(data1){
								count = count+"C";	
								$.each(data1,function(idx1,att1){
// 									console.log("idx1="+idx1);
// 									console.log("att1="+att1);
// 									console.log("addr="+att1.att_addr);
									var tripitemTable=$("<table></table>").attr("style","width: 100% ;table-layout: fixed;margin-top: 10px");
									
// 									var lable1=$("<lable></lable>").text("下一站交通方式:");
// 									var input1=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("checked","checked").attr("value","car");

// 									var input2=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","public");
// 									var input3=$("<input></input>").attr("type","radio").attr("name",count+idx1).attr("value","walk");
// 									var lableA=$("<lable></lable>").text("開車").prepend(input1);
// 									var lableB=$("<lable></lable>").text("大眾運輸").prepend(input2);
// 									var lableC=$("<lable></lable>").text("步行").prepend(input3);
// 									var th1=$("<th></th>").css("display","none").attr("colspan","7").append([lable1,lableA,lableB,lableC]);
									
// 									var span1=$("<span></span>").text("到下一站距離：");
// 									var span2=$("<span></span>").attr("name","tDistance");
// 									var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
// 									var span4=$("<span></span>").attr("name","tTime");
// 									var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
// 									var th2=$("<th></th>").attr("colspan","12").append(lable2);
									
// 									var tr1=$("<tr></tr>").append([th1,th2]);
// 									var tripitemThead=$("<thead></thead>").attr("class","div5").append(tr1);
									
									var input4=$("<input></input>").attr("type","hidden").attr("name","att_addr").attr("value",att1.att_addr);
									var input5=$("<input></input>").attr("type","hidden").attr("name","att_id").attr("value",att1.att_id);
									var td1=$("<td></td>").attr("colspan","3").append([input4,input5]);
									
									var p1=$("<p></p>").html("預算:<input name='tripitem_price' type='number' style='width:60px' value='0' min='0'>元");
									var td2=$("<td></td>").attr("colspan","3").append(p1);
									
									var p2=$("<p></p>").html("停留:<input name='wTime' type='number' style='width:60px' value='0' min='0'>分");
									var td3=$("<td></td>").attr("colspan","3").append(p2);
									
									var p3=$("<p></p>").attr("name","sTime").text("起：");
									var td4=$("<td></td>").attr("colspan","3").append(p3);
									
									var lable3=$("<lable></lable>").text(attname1);
									var urlAA=$("<a></a>").attr("href",att1.att_url).attr("target","_new").append(lable3);
									var td5=$("<td></td>").attr("colspan","3").attr("style","text-align:center").append(urlAA);
									
									var p4=$("<p></p>").text("註記:");
									var td6=$("<td></td>").attr("colspan","3").append(p4);
									
									var td7=$("<td></td>").attr("colspan","3");
									
									var p5=$("<p></p>").attr("name","eTime").text("迄：");
									var td8=$("<td></td>").attr("colspan","3").append(p5);
									
									var td9=$("<td></td>").attr("colspan","3");
									
									var textarea1=$("<textarea></textarea>").attr("name","tripitem_memo").attr("rows","2").attr("style","width:100%").attr("placeholder","註記:");
									var td10=$("<td></td>").attr("colspan","6").append(textarea1);
									
									var input6=$("<input></input>").attr("type","button").attr("class","deleteTripitem").attr("style","margin-left: 7px").attr("value","刪除"); 
									var td11=$("<td></td>").attr("colspan","3").append(input6);
									
									var tr2=$("<tr></tr>").append([td1,td2,td3,td4]);
									var tr3=$("<tr></tr>").append([td5,td6,td7,td8]);
									var tr4=$("<tr></tr>").append([td9,td10,td11]);
									
									var span1=$("<span></span>").text("到下一站距離：");
									var span2=$("<span></span>").attr("name","tDistance");
									var span3=$("<span></span>").attr("style","margin-left:10px").text("時間：");
									var span4=$("<span></span>").attr("name","tTime");
									var lable2=$("<lable></lable>").append([span1,span2,span3,span4]);
									var td12=$("<td></td>").attr("colspan","12").append(lable2);
									
									var tr1=$("<tr></tr>").attr("class","div5").append(td12);
									
									var tripitemTbody=$("<tbody></tbody>").attr("class","div6").append([tr2,tr3,tr4,tr1]);
									
									tripitemTable.append(tripitemTbody);
									
									//新增__input(目前非hidden)，以便取item內值送至servlet --------------------------------------------
									var startTime = $("<input></input>").attr("type","number").attr("name","tripitem_begin");
									var wonderTime = $("<input></input>").attr("type","number").attr("name","tripitem_staytime");
									var endTime = $("<input></input>").attr("type","number").attr("name","tripitem_end");
									
									var begin = $("<label></label>").text("begin：").append(startTime);
									var staytime = $("<label></label>").text("staytime：").append(wonderTime);
									var endtime = $("<label></label>").text("end：").append(endTime);

									var dataBox = $("<div></div>").attr("style","display:none").append([begin,staytime,endtime]);
									tripitemTable.append(dataBox);
								   //-------------------------------------------------------------------------------啟程初始值請另取值
									
									sortDiv.append(tripitemTable);
									
									addrArray.push(att1.att_addr);
								})
								
								initMap();
								
								sortable();
								
								deleteTripitem();
							})
				       	});
                        $("#div3").after(tripForm);
						$("#div3 input").val("");
						$("#region_id option[value='0']").prop("selected",true);
						$("#tripType option[value='0']").prop("selected",true);
						$("#selectForm").remove();
				   });
				}
				})
			  }
		   });
			
			$("#saveBtn").off('click').on('click',function(){
					
					var json = {
							"trip_id":trip_id,
							"tripitem_serial":"0",
							"tripitem_staytime":"0",
							"tripitem_memo":$("#possition").val(),
							"tripitem_begin":$("#start input[name='tripitem_begin']").val(),
							"tripitem_end":$("#start input[name='tripitem_end']").val(),
					};
					$.post("../tripitem/TripitemServlet",JSON.stringify(json)).done(function(data){
						console.log(data);
						$.each(data,function(idx,result){
							console.log(result);
						})
					})
					
					$("#sortable > table").each(function(idx,table){
// 						console.log("idx="+idx);
// 						console.log("table"+table);
						var tripitemPrice=$(this).find("input[name='tripitem_price']").val();
						var itemJson={
								"trip_id":trip_id,
								"tripitem_serial":(parseInt(idx)+1),
								"att_id":$(this).find("input[name='att_id']").val(),
								"hotel_id":$(this).find("input[name='hotel_id']").val(),
								"tripitem_staytime":$(this).find("input[name='tripitem_staytime']").val(),
								"tripitem_begin":$(this).find("input[name='tripitem_begin']").val(),
								"tripitem_end":$(this).find("input[name='tripitem_end']").val(),
								"tripitem_memo":$(this).find("textarea[name='tripitem_memo']").val(),
								"tripitem_price":$(this).find("input[name='tripitem_price']").val(),
								"tripitem_traffic":$(this).find("input[name$='addr']").val()
						};
						sumBudget=sumBudget+parseInt(tripitemPrice);
						console.log("itemJson="+itemJson);
						$.post("../tripitem/TripitemServlet",JSON.stringify(itemJson)).done(function(data){
							console.log(data);
							$.each(data,function(idx,result){
								console.log(result);
							})
						})
					})
					
					$.get("TripServlet",{"trip_id":trip_id,"method":"getOneById"},function(data){
// 						console.log("data="+data);
						var jsonTrip={
	 							"trip_name":data.trip_name,
	 							"trip_id":trip_id,
	 							"trip_price":sumBudget,
	 							"mem_uid":data.mem_uid 
						}
						console.log(jsonTrip);
						$.ajax({
							"type":"PUT",
							"url":"TripServlet",
							"dataType":"json",
							"data":JSON.stringify(jsonTrip),
							"success":function(data){
								console.log(data.result);
								window.location="${contextPath}/trip/listOneFromMemTrip.jsp";
		                        }
						})		
					})
			})
	    });
			
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGoTWzmY15u_6_Yo6ieFdEHAs2nZJHTBk&libraries=places&callback=initMap"
		async defer></script>
<jsp:include page="/frontPageFooter.jsp"/>