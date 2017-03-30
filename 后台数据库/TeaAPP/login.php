<?php
$con = mysql_connect("localhost","yuxin","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];
switch ($action) {
	//登录接口
	case 'login':
		$user = $_POST['userName'];
		$pass = $_POST['password'];
		userlogin($user,$pass);
		break;
	default:		
		# code...
		break;
}

//登录接口
function userlogin($user,$pass)
{
	$sql = "SELECT * FROM  t_user where t_userPhone = $user";
	$result = mysql_query($sql);
	if ($result) 
	{
		$dataArray = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray["userID"] = $row["t_userID"];
			$dataArray["userNick"] = $row["t_Nickname"];
			$dataArray["userSex"] = $row["t_userSex"];
			$dataArray["userImage"] = $row["t_userImage"];
			if ($row['t_userPassword'] == $pass) {
				$resultArray = array('code' => "200", 'msg' => "success", 'list' => $dataArray);
			}else {
				$resultArray = array('code' => "300", 'msg' => "password error!");
			}
	}
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => "500", 'msg' => "error");
		echo json_encode($resultArray);	
	}

}


mysql_close($con);
?>