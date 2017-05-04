<?php
$con = mysql_connect("localhost","yuxin","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("teahouse")or die("error!");
$action = $_POST['key'];
switch ($action) {
	//1.更改个人中心用户名
	case 'updateName':
		$userID = $_POST['userID'];
		$names = $_POST['name'];
		updateName($names,$userID);
		break;
	//2.更改个人中心用户年龄
	case 'updateAge':
		$ages = $_POST['age'];
		$userID = $_POST['userID'];
		updateAge($ages,$userID);
		break;
	//3.更改个人中心用户性别
	case 'updateSex':
		$sexs = $_POST['sex'];
		$userID = $_POST['userID'];
		updateSex($sexs,$userID);
		break;
	//4.更改个人中心用户密码
	case 'updatePassword':
		$passwords = $_POST['password'];
		$userID = $_POST['userID'];
		updatePassword($passwords,$userID);
		break;
	//5.更改个人中心用户昵称
	case 'updateNick':
		$nicks = $_POST['nick'];
		$userID = $_POST['userID'];
		updateNick($nicks,$userID);
		break;
	//6.更改个人中心用户头像
	case 'updateImage':
		$images = $_POST['image'];
		$userID = $_POST['userID'];
		updateImage($images,$userID);
		break;
	default:		
		# code...
		break;
}
//1.更改个人中心用户名
function updateName($names,$userID)
{
	$sql = "UPDATE t_user SET t_userName = '$names' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//2.更改个人中心用户年龄

function updateAge($ages,$userID)
{
	$sql = "UPDATE t_user SET t_userAge = '$ages' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//3.更改个人中心用户性别

function updateSex($sexs,$userID)
{
	$sql = "UPDATE t_user SET t_userSex = '$sexs' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//4.更改个人中心用户密码

function updatePassword($passwords,$userID)
{
	$sql = "UPDATE t_user SET t_userPassword = '$passwords' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//5.更改个人中心用户昵称

function updateNick($nicks,$userID)
{
	$sql = "UPDATE t_user SET t_Nickname = '$nicks' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//6.更改个人中心用户头像

function updateImage($images,$userID)
{
	$sql = "UPDATE t_user SET t_userImage = '$images' where t_userID = $userID";	
	$result = mysql_query($sql);    
	if ($result)
	{	
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
mysql_close($con)
?>