<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8">

		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
				
		<link href="css/mui.min.css" rel="stylesheet" />
		
		<link rel="stylesheet" type="text/css" href="css/app.css" />
		
			<meta name="format-detection" content="telephone=no" />
			<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover" />
			<title>登录</title>
		<link rel="stylesheet" href="Public/Mobile/ecshe_css/wapmain.css?v=1543408652" />

		
	</head>

	<body>
		<script src="js/util.js"></script>
		<script src="js/mui.min.js"></script>
		<script src="js/child_tool.js"></script>	 
		<header class="mui-bar mui-bar-bg mui-bar-nav">
			<a class="mui-icon mui-icon-left-nav mui-pull-left" href="/Trade/tradelist.html"></a>
			<h1 class="mui-title color_white"></h1>
		</header>
		<div class="mui-content cur-padding-bottom" style="background:inherit;">
			<div class="mylogin">
				<p class="title"><b>登录</b></p>
				 
				<div class="login-input-group">					
					<div class="mui-input-row">
						<input type="password" name="password" id="edit_pass_word" class="mui-input-clear mui-input-password" autocomplete="off" placeholder="登录密码">						
					</div>					
					<div class="mui-button-row" style="margin-top:25px;">
						<button id="login_in"  type="button" class="mui-btn mui-btn-primary">登录</button>
					</div>
				</div>
				<p class="text-s" style="margin-top:25px;font-size:14px;"><a href="#">忘记密码没法找回</a></p>
				<p class="text-s tc" style="margin-top:60px;">还没有账号？<a href="#register_ui" style="margin-left:10px;">注册</a></p>
			</div>			
		</div>
		<!--注册--> 
		<div id="register_ui" class="mui-modal" style="background:linear-gradient(to left,#313e51, #111e31);">
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-close mui-pull-right" href="#register_ui"></a>
				<h1 class="mui-title">注册</h1>
			</header>
			
			
			<ul id="reg_box" class="mui-table-view msg_box" style="margin-top: 10rem;background-color: rgba(0,0,0,0.2);">				
				
				<li class="mui-table-view-cell">
					<div class="mui-input-row" >
						<label style="font-size: 1rem;">*密码</label>
						
						<input  id="input_pass_word" type="password" class="mui-input-password"  placeholder="请输入密码">
					</div>
				</li>
				<li class="mui-table-view-cell">
					<div class="mui-input-row">
						<label style="font-size: 1rem;">*确认密码</label>
						<input  id="input_ok_pass_word" type="password" class="mui-input-password"  placeholder="请确认密码">
					</div>
				</li>
				
				<li class="mui-table-view-cell">
					<p style="text-align: center;">
						<a href="#register_ui" class="mui-btn mui-btn-royal" style="width: 40%;">
							取消
						</a> 
						<button id="reg_button" type="button" class="mui-btn mui-btn-royal" style="width: 40%;">
							注册
						</button>
					</p>
				</li>
			</ul>
			
			
			<div id="reg_success" style="text-align: center;display: none;margin-top: 10rem;">
				<h3 style="margin-bottom: 2rem;">请选择是导入还是创建钱包</h3>
				<button onclick="on_select_change(1);" type="button" class="mui-btn mui-btn-royal" style="width: 10rem;height: 10rem;">
					<h2>我要创建</h2>
				</button>
				<button onclick="on_select_change(2);" type="button" class="mui-btn mui-btn-royal" style="width: 10rem;height: 10rem;">
					<h2>我要导入</h2> 
				</button>				
			</div>
		</div>
		<!--注册结束-->
		<div id="load_ico" style="position: absolute;inline-start;margin: 10rem 10rem 10rem 8rem; z-index:9999;display: none;">
			<span class="mui-spinner" style="width:5rem;height:5rem;"></span> 
		</div>

		<!--
		<ul class="mui-table-view">
		    <li class="mui-table-view-cell">
				自动登录
		        <div id="M_Toggle" class="mui-switch mui-active">
		            <div class="mui-switch-handle"></div>
		        </div>				
		    </li>			
		</ul>		
		-->
	
	<script type="text/javascript">
		function get_message(msg){;}
		(function() {			
			mui.init({
				swipeBack: true ,//启用右滑关闭功能
				//localStorage.setItem("ECS_PASS_WORD",pass_word.value);				
			});	
		})();
		
		mui.plusReady(function() {
			//读出数据信息化
			let user_data=JSON.parse(localStorage.getItem('MOLC_ACCOUNTS_MESSAGE'));
			if(user_data != null)getElem('edit_pass_word').value=user_data.pass_word;
			else {
				getElem('register_ui').classList.add("mui-active");
			}
			//点击登录事件
			getElem('login_in').addEventListener('click',function(e){

				var pass=getElem('edit_pass_word').value;
				if(pass.length<6)
				{
					alert('请输入密码');
					return;
				}
				//调用登录函数
				
				if(pass != user_data.pass_word){
					alert('密码不正确');
					return;
				}
				
				call_main_func('login','"'+pass+'"');
			});
			
			getElem('reg_button').addEventListener('click',function(e){
				//注册
				let pass_word=getElem('input_pass_word').value;				
				let ok_pass_word = getElem('input_ok_pass_word').value;
				if(pass_word.length<6){alert('密码到少6位');return;}
				if(ok_pass_word.length<6){alert('确认密码到少6位');return;}
				if(pass_word!==ok_pass_word){alert('两次输入的密码不同');return;}
				call_main_func('create_accounts','"'+pass_word+'"');
			});
			//启动完成,关闭启动页
			plus.navigator.closeSplashscreen();//关闭启动页
		})();
		function on_select_change(s)
		{
			//document.querySelector(".mui-modal").classList.remove("mui-active");
			getElem('register_ui').classList.remove("mui-active");
			call_main_func('open_html',s);
		}
	</script>
	</body>
</html> 
