<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/frontPageHeader.jsp" />
<div class="container">
	<div>	
		<form name="addTheme">
			<div class="row">
				<div  class="col-sm-6 col-sm-offset-3">
					<h2>發表新主題</h2>
				</div>
			</div>
			<div>
				<div class="form-inline">
				
					<div class="form-group">
						<span class="glyphicon glyphicon-star" aria-hidden="true"><label for="themeTopic">主題名稱</label> </span>						
						<input type="text" id="theme_topic" name="theme_topic"  class="form-control"	placeholder="請輸入主題名稱">
						
					</div>
					<div class="form-group" >
						 <span class="glyphicon glyphicon-user" aria-hidden="true"><label for="memId" >會員名</label>	</span>	 
						 <input type="text"  class="form-control" value="${vo.mem_fname}"  readonly="readonly">
						 <input type="hidden" id="mem_uid" name="mem_uid" class="form-control" value="${vo.mem_uid}"
							placeholder="會員Id" readonly="readonly" >
					</div>
				
				</div>
			</div>
			<div class="from-grop">
				<label for="">內容:</label>
				<div id="d2"></div>
				<textarea name="theme_article" id="theme_article" class="form-control"></textarea>

			</div>
			  
			<div class="form-inline">
				<div class="col-md-3">
					<button type="button" class="btn btn-default form-control" id="backall" onclick="javascript:location.href='<%=request.getContextPath()%>/articles/list.jsp'">回到所有主題</button>
				</div>
				<div class="col-md-3 col-sm-offset-6" >
					<button type="button" class="btn btn-success form-control btn" id="btnInsert">確認新增</button>
				</div>
			</div>
		<div>
			<div id="result"></div>
		</div>
		</form>

	</div>	
</div>

    <script src="//cdnjs.cloudflare.com/ajax/libs/summernote/0.8.2/summernote.js"></script>
    <script src="${contextPath}/lang/summernote-zh-TW.js"></script>
  
	<script type="text/javascript">

	//----------summernote---------------
		 $('#theme_article').summernote({
			 height:200,
			 lang: 'zh-TW', // default: 'en-US'
			 placeholder:"請在此編輯內容"
			 });
	//----------End---------------------
	 $(function() {
	
		 $("#btnInsert").click(function() {
				var errMsgSpan = $('form[name="addTheme"] span');
				errMsgSpan.remove();
				var form = $(document.addTheme).serializeArray(), json = {};
				for (var i = 0; i < form.length; i++) {
					
					if (form[i].value.length > 0) {
						json[form[i].name] = form[i].value;
					}
				}
				$.post("ThemeServlet" ,JSON.stringify(json)).done(function(data) {
					console.log(data);
					$.each(data, function(errAtt, errMsg) {
						console.log(errMsg);
						if (errMsg == "success") {
							document.addTheme.reset();
							errMsgSpan.remove();
							alert("新增成功 即將跳轉畫面");
							location.href="list.jsp";
					        $( "#theme_article" ).remove();
							
						}
						var errSpan = document.createElement("span");
						var errText = document.createTextNode(errMsg);
						var errId = 'err' + errAtt;
						errSpan.appendChild(errText);
						errSpan.setAttribute("style", "color:red");
						errSpan.setAttribute("id", errId);
						$('#' + errId).remove();
						$('#' + errAtt).after(errSpan);
					});
					console.log("200.");
					var makrup = $('#theme_article').summernote('code');
					
				}).fail(function(xhr) {
					console.log("ERR.");
				});
			});
	 });
	 
	 
		var edit = function() {
			  $('#theme_article').summernote({focus: true});
			};

		var show = function() {
		  var makrup = $('.theme_article').summernote('code');
		  console.log($('.theme_article').summernote('code'));
		  $('.theme_article').summernote('destroy');
		};
	
	</script>
	<jsp:include page="/frontPageFooter.jsp" />

