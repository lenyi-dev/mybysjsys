<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="bootstrap/jquery.min.js"></script>
<style type="text/css">
/* 不使用项目符号 */
ul, li {
	list-style: none;
}

/* 设置鼠标滑入的时候变成小手 */
#myMouse {
	cursor: pointer
}

#mypass {
	display: none;
}
</style>
<script>
	function show() {
		// 		 $("#roleAddModal2")[0].modal({
		// 	            show: true,
		// 	            backdrop:'static'
		// 	        })
		$("#btnOK").click();
		console.log($("#roleAddModal2"));
		// 		$("#mypass")[0].style.display = "block";
	}
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!--<a class="navbar-brand" href="admin/index.jsp">首页</a>-->
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!-- 缴费管理 -->
				<li><a href="consumeMg">缴费管理 </a></li>
				<!-- 用户管理 -->
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">信息管理 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#"></a></li>
						<li><a href="userMg">用户管理</a></li>
						<li><a href="houseMg">住房管理</a></li>
						<li><a href="carMg">车辆管理</a></li>
						<li><a href="houseTypeMg">户型管理</a></li>
					</ul></li>



				<!-- 通知管理 -->
				<li><a href="noticeMg">通知管理 </a></li>

				<!-- 报修管理 -->
				<li><a href="repairMg">报修管理 </a></li>

				<!-- 投诉管理 -->
				<li><a href="adviceMg">投诉管理 </a></li>

			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li><a>管理员[${sessionScope.user.userName}]</a> <label></label></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">个人中心 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li onclick="show()"><a id="myMouse" class="modal-title"
							id="exampleModalLabel">修改密码</a></li>
						<button id="btnOK" type="button" style="display: none"
							class="btn btn-info btn-sm" data-toggle="modal"
							data-target="#roleAddModal2">修改个人信息</button>
						<li role="separator" class="divider"></li>
						<li><a href="signout">退出</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
	<div class="modal fade" id="roleAddModal2" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">修改密码</h4>
				</div>
				<div class="modal-body">
					<form action="change" method="post">
						<div class="form-group">
							<label for="recipient-name" class="control-label">请输入新密码</label>
							<input type="password" class="form-control" name="password"
								id="recipient-name" value="">
						</div>
						<div class="form-group">
							<label for="message-text" class="control-label">请输入新手机号</label> <input
								type="text" class="form-control" name="phone"
								id="recipient-name" value="">
						</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary">修改</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 	<div id="mypass" class="modal-body"> -->
	<!-- 		<form action="change" method="post"> -->
	<!-- 			<div class="form-group"> -->
	<!-- 				<label for="recipient-name" class="control-label">请输入新密码</label> <input -->
	<!-- 					type="password" class="form-control" name="password" -->
	<!-- 					id="recipient-name" value=""> -->
	<!-- 			</div> -->
	<!-- 			<div class="form-group"> -->
	<!-- 				<label for="message-text" class="control-label">请输入新手机号</label> <input -->
	<!-- 					type="text" class="form-control" name="phone" id="recipient-name" -->
	<!-- 					value=""> -->
	<!-- 			</div> -->
	<!-- 	</div> -->
	<!-- 	<div class="modal-footer"> -->
	<!-- 		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button> -->
	<!-- 		<button type="submit" class="btn btn-primary">修改</button> -->
	<!-- 	</div> -->
	<!-- 	</form> -->
</nav>