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
		createOrder($goodID,$userID,$goodsNumber,$goodsPrice);
		break;
	//更新订单
	case 'updateOrder':
		$orderID = $_POST['orderID'];
		$goodsNumber = $_POST['goodsNumber'];
		$goodsPrice = $_POST['goodsPrice'];
		updateOrder($orderID,$goodsNumber,$goodsPrice);
		break;
	//订单详情(根据订单ID)
	case 'orderFromOorderID':
		$orderID = $_POST['orderID'];
		orderFromOorderID($orderID);
		break;
	//订单详情(根据用户ID)
	case 'orderFromUserID':
		$userID = $_POST['userID'];
		$orderState = $_POST['orderState'];
		orderFromUserID($userID,$orderState);
		break;
	//删除订单
	case 'deleteOrder':
		$orderID = $_POST['orderID'];
		deleteOrder($orderID);
		break;
	default:
		break;
}

//生成订单
function createOrder($goodID,$userID,$goodsNumber,$goodsPrice) {
	$state = "待付款";
	//去掉传入价格头尾引号
	$goodsTotal = substr($goodsPrice,1,strlen($goodsPrice)-1) * $goodsNumber;

	$orderTime = time();
	$addressID = "1";
	//生成不重复随机订单号
	$yCode = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J');
	$orderSn = $yCode[intval(date('Y')) - 2011] . strtoupper(dechex(date('m'))) . date('d') . substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%02d', rand(0, 99));
	global $con;
	//先查询数据库是否存在(存在更新,不存在插入)
	$checkSql = "SELECT * FROM `t_order` WHERE `t_userID` = $userID AND `t_shopthird_t_shopthirdID` = $goodID AND `t_orderstate` = '$state'";
	
	$checkResult = mysqli_query($con,$checkSql);
	$sql = "";
	if ($checkResult) {

		$checkRow = mysqli_fetch_array($checkResult);
		$checkOrderID = $checkRow["t_orderID"];
		$num = $goodsNumber + $checkRow["t_orderamount"];
		$goodsTotal = substr($goodsPrice,1,strlen($goodsPrice)-1) * $num;
		
		if ($checkOrderID != null) {
			$sql = "UPDATE `t_order` SET `t_orderNumber`='$orderSn',`t_orderamount`=$num,`t_orderstate`='$state',`t_orderTime`=$orderTime,`t_orderTotal`=$goodsTotal WHERE `t_order`.`t_orderID` = $checkOrderID";
		}else {
			$sql = "INSERT INTO `t_order`(`t_orderamount` ,  `t_orderTime`, `t_orderTotal`, `t_userID`, `t_shopthird_t_shopthirdID`, `t_address_t_addressID`, `t_orderstate`, `t_orderNumber`) VALUES ('$goodsNumber','$orderTime','$goodsTotal','$userID','$goodID','$addressID','$state','$orderSn')";
		}
	}else {
		$sql = "INSERT INTO `t_order`(`t_orderamount` ,  `t_orderTime`, `t_orderTotal`, `t_userID`, `t_shopthird_t_shopthirdID`, `t_address_t_addressID`, `t_orderstate`, `t_orderNumber`) VALUES ('$goodsNumber','$orderTime','$goodsTotal','$userID','$goodID','$addressID','$state','$orderSn')";
	}
	// echo $sql;
	$result = mysqli_query($con,$sql);
	$orderID = mysqli_insert_id($con);
	if ($result) 
	{
		// $sql2 = "SELECT * FROM t_order WHERE t_orderTime = (SELECT max(t_orderTime) from t_order)";
		// $result2 = mysqli_query($con,$sql2);
		$dataArray = array();
		// if ($result2) 
		// {
		// 	while ($row = mysqli_fetch_array($result2)) 
		// 	{
		if ($orderID == 0) {
			$orderID = $checkOrderID;
		}else {}
		$dataArray["orderID"] = $orderID;
				// $dataArray["orderState"] = $row["t_orderstate"];
			// }
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

//更新订单
function updateOrder($orderID,$goodsNumber,$goodsPrice) {
	$state = "待付款";
	//去掉传入价格头尾引号
	$goodsTotal = substr($goodsPrice,1,strlen($goodsPrice)-1) * $goodsNumber;

	$orderTime = time();
	$addressID = "1";
	//生成不重复随机订单号
	$yCode = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J');
	$orderSn = $yCode[intval(date('Y')) - 2011] . strtoupper(dechex(date('m'))) . date('d') . substr(time(), -5) . substr(microtime(), 2, 5) . sprintf('%02d', rand(0, 99));
	global $con;
	$sql = "UPDATE `t_order` SET `t_orderNumber`='$orderSn',`t_orderamount`=$goodsNumber,`t_orderstate`='$state',`t_orderTime`=$orderTime,`t_orderTotal`=$goodsTotal WHERE `t_order`.`t_orderID` = $orderID";
	// echo $sql;
	$result = mysqli_query($con,$sql);
	if ($result) 
	{
		$resultArray = array('code' => 200, 'msg' => "success");
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

//订单详情
function orderFromOorderID($orderID) {
	$sql = "SELECT * FROM t_order WHERE t_orderID = $orderID";
	global $con;
	$result = mysqli_query($con,$sql);
	$dataArray = array();
	if ($result) 
	{
		while ($row = mysqli_fetch_array($result)) {
			$dataArray["orderID"] = $orderID; 
			$dataArray["userID"] = $row["t_userID"];
			$goodID = $row["t_shopthird_t_shopthirdID"]; 
			$dataArray["goodID"] = $goodID;
			$dataArray["goodsNumber"] = $row["t_orderamount"];
			$dataArray["orderState"] = $row["t_orderstate"];
			$dataArray["orderTime"] = $row["t_orderTime"];
			$dataArray["orderTotal"] = $row["t_orderTotal"];

			$sql1 = "SELECT * FROM t_shopthird WHERE t_shopthirdID = $goodID";
			$result1 = mysqli_query($con,$sql1);
			if ($result1) 
			{
				while ($row1 = mysqli_fetch_array($result1)) 
				{
					$dataArray["goodsID"] = $goodID;
					$dataArray["goodsName"] = $row1["t_shopthirdName"];
					$dataArray["goodsPrice"] = $row1["t_shopthirdPrice"];
					$dataArray["goodsIsDiscount"] = $row1["t_goodsIsDiscount"];
					$dataArray["goodsContent"] = $row1["t_shopthirdcontent"];
					$sql2 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodID and t_imageIsThumbnail = 0";
					$result2 = mysqli_query($con,$sql2);
					if ($result2) {
						$row2 = mysqli_fetch_array($result2);
						$dataArray["goodsImageName"] = $row2["t_imageName"];
					}
				}
			}
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

//订单详情(根据用户ID)
function orderFromUserID($userID,$orderState) {
	$sql = "SELECT * FROM t_order WHERE t_userID = $userID AND t_orderstate = '$orderState' ORDER BY `t_order`.`t_orderTime` DESC ";
	global $con;
	$result = mysqli_query($con,$sql);
	$dataArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysqli_fetch_array($result)) {
			$dataArray[$i]["orderID"] = $row["t_orderID"]; 
			$dataArray[$i]["userID"] = $userID;
			$goodID = $row["t_shopthird_t_shopthirdID"]; 
			// $dataArray[$i]["goodID"] = $goodID;
			$dataArray[$i]["goodsNumber"] = $row["t_orderamount"];
			$dataArray[$i]["orderState"] = $row["t_orderstate"];
			$dataArray[$i]["orderTime"] = $row["t_orderTime"];
			$dataArray[$i]["orderTotal"] = $row["t_orderTotal"];

			$sql1 = "SELECT * FROM t_shopthird WHERE t_shopthirdID = $goodID";
			$result1 = mysqli_query($con,$sql1);
			if ($result1) 
			{
				while ($row1 = mysqli_fetch_array($result1)) 
				{
					$dataArray[$i]["goodsID"] = $goodID;
					$dataArray[$i]["goodsName"] = $row1["t_shopthirdName"];
					$dataArray[$i]["goodsPrice"] = $row1["t_shopthirdPrice"];
					$dataArray[$i]["goodsIsDiscount"] = $row1["t_goodsIsDiscount"];
					$dataArray[$i]["goodsContent"] = $row1["t_shopthirdcontent"];
					$sql2 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodID and t_imageIsThumbnail = 0";
					$result2 = mysqli_query($con,$sql2);
					if ($result2) {
						$row2 = mysqli_fetch_array($result2);
						$dataArray[$i]["goodsImageName"] = $row2["t_imageName"];
					}
				}
			}
			$i++;
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

//删除订单
function deleteOrder($orderID) {
	$sql = "DELETE FROM `t_order` WHERE `t_orderID` = $orderID";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$resultArray = array('code' => 200, 'msg' => "success");
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

mysqli_close($con);
?>

