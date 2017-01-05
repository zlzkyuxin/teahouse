<?php
$con = mysql_connect("localhost","root","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];

switch ($action) {
	//13.添加地址接口
	case 'addAddress':
		$pient = $_POST['Pient'];
		$phone = $_POST['Phone'];
		$userID = $_POST['userID'];
		$isDefault =$_POST['IsDefault'];
		$province = $_POST['Province'];
		$region = $_POST['Region'];
		$detail = $_POST['Detail'];
		addAddress($pient,$phone,$userID,$isDefault,$province,$region,$detail);
		break;
	//14.删除地址
	case 'deleteAddress':
		$addressID =$_POST['addressID'];
		deleteAddress($addressID);
		break;
	//15.修改地址(待完善解决)
	case 'updateAddress':
		$pient = $_POST['Pient'];
		$phone = $_POST['Phone'];
		$isDefault =$_POST['IsDefault'];
		$province = $_POST['Province'];
		$region = $_POST['Region'];
		$detail = $_POST['Detail'];
		$addressID =$_POST['addressID'];
		updateAddress($Pient,$Phone,$IsDefault,$Province,$Region,$Detail,$addressID);
		break;
	//16.查收货地址(按用户id)
	case 'searchAddress':
		$userID = $_POST['userID'];
		searchAddress($userID);
		break;
default:		
		# code...
		break;
}
//13.添加地址接口
function addAddress($Pient,$Phone,$userID,$IsDefault,$Province,$Region,$Detail)
{
	$sql = "INSERT INTO `t_address`(`t_addressRecipient`, `t_addressPhone`, `t_user_t_userID`, `t_addressIsdefault`, `t_addressProvince`, `t_addressRegion`, `t_addressDetail`) VALUES ('$Pient','$Phone','$userID','$IsDefault','$Province','$Region','$Detail')";
	
	$result = mysql_query($sql);
	if ($result) 
	{		
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "  msg" => 'error');
	}
	echo json_encode($resultArray);
}
//14.删除地址
function deleteAddress($addressID)
{

	$sql = "DELETE FROM `t_address` WHERE t_addressID = $addressID";	
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
//15.修改地址
function updateAddress($Pient,$Phone,$IsDefault,$Province,$Region,$Detail,$addressID)
{

	$sql = "UPDATE t_address SET t_addressRecipient = '$Pient', t_addressPhone = '$Phone',t_addressIsdefault = '$IsDefault',t_addressProvince = '$Province',t_addressRegion = '$Region', t_addressDetail = '$Detail' where t_addressID = $addressID";	
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
//16.查地址接口
function searchAddress($userID)
{

	$sql = "SELECT * FROM t_address  where t_user_t_userID = $userID";
	$result = mysql_query($sql);
	if ($result) 
	{
		
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("address","name","phone","isDefault","province","region","detail");
			$value = array($row["t_addressID"],$row["t_addressRecipient"],$row["t_addressPhone"],$row["t_addressIsdefault"],$row["t_addressProvince"],$row["t_addressRegion"],$row["t_addressDetail"]);

			$results = array_combine($key, $value);
			array_push($array, $results);	
	  	}
	$resultArray = array('code' => 200,'msg' =>"success",'list' => $array);
	echo json_encode($resultArray);
	}
	else 
	{
		$resultArray = array('code' => 500,'msg' =>"error");
		echo json_encode($resultArray);
	}
}
mysql_close($con)
?>

