<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=basePath%>">
	<meta charset="UTF-8">
	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<!--  PAGINATION plugin -->
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination-master/localization/en.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#saveCreateClueBtn").click(function () {
			//ζΆιεζ°
			var owner=$("#create-clueOwner").val();
			var company=$.trim($("#create-company").val());
			var appellation=$("#create-appellation").val();
			var fullName=$.trim($("#create-fullName").val());
			var job=$.trim($("#create-job").val());
			var email=$.trim($("#create-email").val());
			var phone=$.trim($("#create-phone").val());
			var website=$.trim($("#create-website").val());
			var mphone=$.trim($("#create-mphone").val());
			var state=$("#create-state").val();
			var source=$("#create-source").val();
			var description=$.trim($("#create-description").val());
			var contactSummary=$.trim($("#create-contactSummary").val());
			var nextContactTime=$("#create-nextContactTime").val();
			var address=$.trim($("#create-address").val());
			//θ‘¨ειͺθ―(δ½δΈ)
			//ειθ―·ζ±
			$.ajax({
				url:'workbench/clue/saveCreateClue.do',
				data:{
					fullName       :fullName       ,
					appellation    :appellation    ,
					owner          :owner          ,
					company        :company        ,
					job            :job            ,
					email          :email          ,
					phone          :phone          ,
					website        :website        ,
					mphone         :mphone         ,
					state          :state          ,
					source         :source         ,
					description    :description    ,
					contactSummary :contactSummary ,
					nextContactTime:nextContactTime,
					address        :address
				},
				type:'post',
				dataType:'json',
				success:function (data) {
					if (data.code=="1"){
						//ε³ι­ζ¨‘ζηͺε£
						$("#createClueModal").modal("hide");
						alert(data.message)
						//ε·ζ°ηΊΏη΄’εθ‘¨
                        queryClueForPageByCondition(1,$("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'));
					}else{
						//ζη€ΊδΏ‘ζ―
						alert(data.message);
						//ζ¨‘ζηͺε£δΈε³ι­
						$("#createClueModal").modal("show");
					}
				}
			});
		});
		queryClueForPageByCondition(1,10);

		$("#queryClueBtn").click(function () {
			//ζΎη€Ίζζη¬¦εζ‘δ»Άηζ°ζ?ηη¬¬δΈι‘΅οΌι»θ?€ζ―ι‘΅ζΎη€Ί10ζ‘
			queryClueForPageByCondition(1,$("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'));
		})


	});
	function queryClueForPageByCondition(pageNo,pageSize) {
		//ζΆιεζ°
		//var pageNo=1;
		//var pageSize=10;
		var name=$("#query-name").val();
		var company=$("#query-company").val();
		var mphone=$("#query-mphone").val();
        var phone=$("#query-phone").val();
        var source=$("#query-source").val();
		var owner=$("#query-owner").val();
		var state=$("#query-state").val();

		//ειθ―·ζ±
		$.ajax({
			url:'workbench/clue/queryClueForPageByCondition.do',
			data:{
				pageNo:pageNo,
				pageSize:pageSize,
				/*εη§°οΌε¬εΈοΌε¬εΈεΊ§ζΊοΌζζΊοΌηΊΏη΄’ζ₯ζΊοΌζζθοΌηΊΏη΄’ηΆζ*/
				name:name,
				company:company,
				mphone:mphone,
                phone:phone,
                source:source,
                owner:owner,
                state:state
			},
			type:'post',
			dataType:'json',
			success:function (data) {
				//ζΎη€Ίζ»ζ‘ζ°γεθ½η±paginationζδ»ΆζΏδ»£
				//$("#totalRowsB").text(data.totalRows);
				//ιεdata.acitivtyList,ζΎη€Ίζ°ζ?εθ‘¨
				var htmlStr="";
				$.each(data.clueList,function (index,obj) {

                    htmlStr+="<tr class=\"clue\">";
                    htmlStr+="<td><input type=\"checkbox\" value=\""+obj.id+"\"/></td> ";
                    htmlStr+="<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='workbench/clue/detailClue.do?id="+obj.id+"'\">"+obj.fullName+"</a></td>";
                    htmlStr+="<td>"+obj.company+"</td>";
                    htmlStr+="<td>"+obj.mphone+"</td>";
                    htmlStr+="<td>"+obj.phone+"</td>";
                    htmlStr+="<td>"+obj.source+"</td>";
                    htmlStr+="<td>"+obj.owner+"</td>";
                    htmlStr+="<td>"+obj.state+"</td>";
                    htmlStr+="</tr>";
				});

				//ζhtmlStrζΎη€Ίε¨tbody
				$("#tBody").html(htmlStr);

				//θ?‘η?ζ»ι‘΅ζ°
				var totalPages=1;
				if (data.totalRows%pageSize==0){
					totalPages=data.totalRows/pageSize;
				}else{
					totalPages=parseInt(data.totalRows/pageSize)+1;
				}

				//ζΎη€ΊηΏ»ι‘΅δΏ‘ζ―
				$("#demo_pag1").bs_pagination({
					currentPage:pageNo,//ε½ει‘΅

					rowsPerPage:pageSize,//ζ―ι‘΅ζΎη€Ίζ‘ζ°
					totalRows:data.totalRows,//ζ»ζ‘ζ°
					totalPages: totalPages,//ζ»ι‘΅ζ°

					visiblePageLinks:5,//ζΎη€ΊηηΏ»ι‘΅ε‘ηζ°

					showGoToPage:true,//ζ―ε¦ζΎη€Ί"θ·³θ½¬ε°η¬¬ε ι‘΅"
					showRowsPerPage:true,//ζ―ε¦ζΎη€Ί"ζ―ι‘΅ζΎη€Ίζ‘ζ°"
					showRowsInfo:true,//ζ―ε¦ζΎη€Ί"θ?°ε½ηδΏ‘ζ―"

					//ζ―ζ¬‘εζ’ι‘΅ε·ι½δΌθͺε¨θ§¦εζ­€ε½ζ°οΌε½ζ°θ½ε€θΏεεζ’δΉεηι‘΅ε·εζ―ι‘΅ζΎη€Ίζ‘ζ°
					onChangePage: function(e,pageObj) { // returns page_num and rows_per_page after a link has clicked
						//alert(pageObj.currentPage);
						//alert(pageObj.rowsPerPage);
						queryClueForPageByCondition(pageObj.currentPage,pageObj.rowsPerPage);

					}
				});

			}
		});
	}
</script>
</head>
<body>

<!-- εε»ΊηΊΏη΄’ηζ¨‘ζηͺε£ -->
<div class="modal fade" id="createClueModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">Γ</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">εε»ΊηΊΏη΄’</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">

					<div class="form-group">
						<label for="create-clueOwner" class="col-sm-2 control-label">ζζθ<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-clueOwner">
								<c:forEach items="${userList}" var="u">
									<option value="${u.id}">${u.name}</option>
								</c:forEach>
							</select>
						</div>
						<label for="create-company" class="col-sm-2 control-label">ε¬εΈ<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-company">
						</div>
					</div>

					<div class="form-group">
						<label for="create-appellation" class="col-sm-2 control-label">η§°εΌ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-appellation">
								<c:forEach items="${appllationList}" var="a">
									<option value="${a.id}">${a.value}</option>
								</c:forEach>
							</select>
						</div>
						<label for="create-fullName" class="col-sm-2 control-label">ε§ε<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-fullName">
						</div>
					</div>

					<div class="form-group">
						<label for="create-job" class="col-sm-2 control-label">θδ½</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-job">
						</div>
						<label for="create-email" class="col-sm-2 control-label">ι?η?±</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-email">
						</div>
					</div>

					<div class="form-group">
						<label for="create-phone" class="col-sm-2 control-label">ε¬εΈεΊ§ζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-phone">
						</div>
						<label for="create-website" class="col-sm-2 control-label">ε¬εΈη½η«</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-website">
						</div>
					</div>

					<div class="form-group">
						<label for="create-mphone" class="col-sm-2 control-label">ζζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="create-mphone">
						</div>
						<label for="create-state" class="col-sm-2 control-label">ηΊΏη΄’ηΆζ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-state">
								<option></option>
								<c:forEach items="${clueStateList}" var="cs">
									<option value="${cs.id}">${cs.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="create-source" class="col-sm-2 control-label">ηΊΏη΄’ζ₯ζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="create-source">
								<option></option>
								<c:forEach items="${sourceList}" var="s">
									<option value="${s.id}">${s.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>


					<div class="form-group">
						<label for="create-description" class="col-sm-2 control-label">ηΊΏη΄’ζθΏ°</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="create-description"></textarea>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

					<div style="position: relative;top: 15px;">
						<div class="form-group">
							<label for="create-contactSummary" class="col-sm-2 control-label">θη³»ηΊͺθ¦</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="create-nextContactTime" class="col-sm-2 control-label">δΈζ¬‘θη³»ζΆι΄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-nextContactTime">
							</div>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

					<div style="position: relative;top: 20px;">
						<div class="form-group">
							<label for="create-address" class="col-sm-2 control-label">θ―¦η»ε°ε</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="1" id="create-address"></textarea>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">ε³ι­</button>
				<button id="saveCreateClueBtn" type="button" class="btn btn-primary">δΏε­</button>
			</div>
		</div>
	</div>
</div>

<!-- δΏ?ζΉηΊΏη΄’ηζ¨‘ζηͺε£ -->
<div class="modal fade" id="editClueModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 90%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">Γ</span>
				</button>
				<h4 class="modal-title">δΏ?ζΉηΊΏη΄’</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">

					<div class="form-group">
						<label for="edit-clueOwner" class="col-sm-2 control-label">ζζθ<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-clueOwner">
								<c:forEach items="${userList}" var="u">
									<option value="${u.id}">${u.name}</option>
								</c:forEach>
							</select>
						</div>
						<label for="edit-company" class="col-sm-2 control-label">ε¬εΈ<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-company" value="ε¨εθηΉ">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-call" class="col-sm-2 control-label">η§°εΌ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-call">
								<option></option>
								<c:forEach items="${appellationList}" var="a">
									<option value="${a.id}">${a.value}</option>
								</c:forEach>
							</select>
						</div>
						<label for="edit-surname" class="col-sm-2 control-label">ε§ε<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-surname" value="ζε">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-job" class="col-sm-2 control-label">θδ½</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-job" value="CTO">
						</div>
						<label for="edit-email" class="col-sm-2 control-label">ι?η?±</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-phone" class="col-sm-2 control-label">ε¬εΈεΊ§ζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-phone" value="010-84846003">
						</div>
						<label for="edit-website" class="col-sm-2 control-label">ε¬εΈη½η«</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-mphone" class="col-sm-2 control-label">ζζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" id="edit-mphone" value="12345678901">
						</div>
						<label for="edit-status" class="col-sm-2 control-label">ηΊΏη΄’ηΆζ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-status">
								<option></option>
								<c:forEach items="${clueStateList}" var="cs">
									<option value="${cs.id}">${cs.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="edit-source" class="col-sm-2 control-label">ηΊΏη΄’ζ₯ζΊ</label>
						<div class="col-sm-10" style="width: 300px;">
							<select class="form-control" id="edit-source">
								<option></option>
								<c:forEach items="${sourceList}" var="s">
									<option value="${s.id}">${s.value}</option>
								</c:forEach>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">ζθΏ°</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="edit-describe">θΏζ―δΈζ‘ηΊΏη΄’ηζθΏ°δΏ‘ζ―</textarea>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

					<div style="position: relative;top: 15px;">
						<div class="form-group">
							<label for="edit-contactSummary" class="col-sm-2 control-label">θη³»ηΊͺθ¦</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-contactSummary">θΏδΈͺηΊΏη΄’ε³ε°θ’«θ½¬ζ’</textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="edit-nextContactTime" class="col-sm-2 control-label">δΈζ¬‘θη³»ζΆι΄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
							</div>
						</div>
					</div>

					<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

					<div style="position: relative;top: 20px;">
						<div class="form-group">
							<label for="edit-address" class="col-sm-2 control-label">θ―¦η»ε°ε</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="1" id="edit-address">εδΊ¬ε€§ε΄εΊε€§ζδΌδΈζΉΎ</textarea>
							</div>
						</div>
					</div>
				</form>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">ε³ι­</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal">ζ΄ζ°</button>
			</div>
		</div>
	</div>
</div>




<div>
	<div style="position: relative; left: 10px; top: -10px;">
		<div class="page-header">
			<h3>ηΊΏη΄’εθ‘¨</h3>
		</div>
	</div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

	<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

		<div class="btn-toolbar" role="toolbar" style="height: 80px;">
			<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">εη§°</div>
						<input class="form-control" type="text" id="query-name">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ε¬εΈ</div>
						<input class="form-control" type="text" id="query-company">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ε¬εΈεΊ§ζΊ</div>
						<input class="form-control" type="text" id="query-mphone">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ηΊΏη΄’ζ₯ζΊ</div>
						<select class="form-control" id="query-source">
							<option></option>
							<c:forEach items="${sourceList}" var="s">
								<option value="${s.id}">${s.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<br>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ζζθ</div>
						<input class="form-control" type="text" id="query-owner">
					</div>
				</div>



				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ζζΊ</div>
						<input class="form-control" type="text" id="query-phone">
					</div>
				</div>

				<div class="form-group">
					<div class="input-group">
						<div class="input-group-addon">ηΊΏη΄’ηΆζ</div>
						<select class="form-control" id="query-state">
							<option></option>
							<c:forEach items="${clueStateList}" var="cs">
								<option value="${cs.id}">${cs.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<button id="queryClueBtn" type="submit" class="btn btn-default">ζ₯θ―’</button>

			</form>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
			<div class="btn-group" style="position: relative; top: 18%;">
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createClueModal"><span class="glyphicon glyphicon-plus"></span> εε»Ί</button>
				<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editClueModal"><span class="glyphicon glyphicon-pencil"></span> δΏ?ζΉ</button>
				<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> ε ι€</button>
			</div>


		</div>
		<div style="position: relative;top: 50px;">
			<table class="table table-hover">
				<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" /></td>
					<td>εη§°</td>
					<td>ε¬εΈ</td>
					<td>ε¬εΈεΊ§ζΊ</td>
					<td>ζζΊ</td>
					<td>ηΊΏη΄’ζ₯ζΊ</td>
					<td>ζζθ</td>
					<td>ηΊΏη΄’ηΆζ</td>
				</tr>
				</thead>
				<tbody id="tBody">
				<%--<tr>
					<td><input type="checkbox" /></td>
					<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='workbench/clue/detailClue.do?id=8cfb85063ab3462bb1f426a65a5f332d';">εΌ δΈεη</a></td>
					<td>ε¨εθηΉ</td>
					<td>010-84846003</td>
					<td>12345678901</td>
					<td>εΉΏε</td>
					<td>zhangsan</td>
					<td>ε·²θη³»</td>
				</tr>
				<tr class="active">
					<td><input type="checkbox" /></td>
					<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">ζεεη</a></td>
					<td>ε¨εθηΉ</td>
					<td>010-84846003</td>
					<td>12345678901</td>
					<td>εΉΏε</td>
					<td>zhangsan</td>
					<td>ε·²θη³»</td>
				</tr>--%>
				</tbody>
			</table>
			<div id="demo_pag1"></div>
		</div>

		<%--<div style="height: 50px; position: relative;top: 60px;">
			<div>
				<button type="button" class="btn btn-default" style="cursor: default;">ε±<b>50</b>ζ‘θ?°ε½</button>
			</div>
			<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
				<button type="button" class="btn btn-default" style="cursor: default;">ζΎη€Ί</button>
				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						10
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">20</a></li>
						<li><a href="#">30</a></li>
					</ul>
				</div>
				<button type="button" class="btn btn-default" style="cursor: default;">ζ‘/ι‘΅</button>
			</div>
			<div style="position: relative;top: -88px; left: 285px;">
				<nav>
					<ul class="pagination">
						<li class="disabled"><a href="#">ι¦ι‘΅</a></li>
						<li class="disabled"><a href="#">δΈδΈι‘΅</a></li>
						<li class="active"><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#">δΈδΈι‘΅</a></li>
						<li class="disabled"><a href="#">ζ«ι‘΅</a></li>
					</ul>
				</nav>
			</div>
		</div>--%>

	</div>

</div>
</body>
</html>