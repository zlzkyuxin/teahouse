<?php
$con = mysqli_connect("localhost","yuxin","123456","teahouse");
mysqli_query($con,"SET NAMES utf8");

$action = $_POST['key'];
switch ($action) {
	//生成订单
	case 'createOrder':
		$goodID = $_POST['goodID'];
		$userID = $_POST['userID'];
		$goodsNumber = $_POST['goodsNumber'];
		$goodsPrice = $_POST['goodsPrice'];
		$orderTime = $_POST['orderTime'];
		$addressID = $_POST['addressID'];
		createOrder($goodID,$userID,$goodsNumber,$goodsPrice,$orderTime,$addressID);
		break;

	default:
		break;
}

//生成订单
function createOrder($goodID,$userID,$goodsNumber,$goodsPrice,$orderTime,$addressID) {
	$state = "待付款";
	$goodsTotal = $goodsPrice * $goodsNumber;
	$sql = "INSERT INTO `t_order`(`t_orderNumber` ,  `t_orderTime`, `t_orderTotal`, `t_userID`, `t_shopthird_t_shopthirdID`, `t_address_t_addressID`, `t_orderstate`) VALUES ('$goodsNumber',,'$orderTime','$goodsTotal','$userID','$goodID','$addressID','$state')";
	$result = mysql_query($sql);
	if ($result) 
	{
		$sql2 = "SELECT t_orderID FROM t_order WHERE t_orderID = (SELECT max(t_orderID) from t_order)";
		$result2 = mysql_query($sql2);
		$dataArray = array();
		if ($result2) 
		{
			while ($row = mysql_fetch_array($result2)) 
			{
				$dataArray["orderID"] = $row["t_orderID"];
				$dataArray["orderState"] = $row["t_orderstate"];
			}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		}
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

mysqli_close($con);
?>

