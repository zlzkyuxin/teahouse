<?php
$con = mysqli_connect("localhost","yuxin","123456","teahouse");
mysqli_query($con,"SET NAMES utf8");

$action = $_POST['key'];
switch ($action) {
	//按名称搜索
	case 'goodsSearch':
		$goodName = $_POST['goodName'];
		goodsSearch($goodName);
		break;
	//产品详情接口
	case 'goodsDetails':
		$goodsID = $_POST['goodsID'];
		goodsDetails($goodsID);
		break;
	default:
		break;
}

function goodsSearch($goodName) {
	$sql = "SELECT * FROM t_shopthird where t_shopthirdName = '$goodName'";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$goodsArray = array();
		while ($row = mysqli_fetch_array($result)) {
			$goodsArray[0]["goodsID"] = $row["t_shopthirdID"];
			$goodsArray[0]["goodsName"] = $row["t_shopthirdName"];
			$goodsArray[0]["goodsPrice"] = $row["t_shopthirdPrice"];
			$goodsArray[0]["goodsNumber"] = $row["t_shopNumber"];
			$goodsArray[0]["goodsContent"] = $row["t_shopthirdcontent"];
			$goodsID = $row["t_shopthirdID"];
			$sql1 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodsID and t_imageIsThumbnail = 0";
			$result1 = mysqli_query($con,$sql1);
			if ($result1) {
				$row1 = mysqli_fetch_array($result1);
				$goodsArray[0]["goodsImageName"] = $row1["t_imageName"];
			}
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $goodsArray);
		echo json_encode($resultArray);
	}else {
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}

function goodsDetails($goodsID) {
	$sql = "SELECT * FROM t_shopthird where t_shopthirdID = $goodsID";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$goodsArray = array();
		while ($row = mysqli_fetch_array($result)) {
			$goodsArray[0]["goodsID"] = $goodsID;
			$goodsArray[0]["goodsName"] = $row["t_shopthirdName"];
			$goodsArray[0]["goodsPrice"] = $row["t_shopthirdPrice"];
			$goodsArray[0]["goodsNumber"] = $row["t_shopNumber"];
			$goodsArray[0]["goodsContent"] = $row["t_shopthirdcontent"];

			$sql1 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodsID and t_imageIsThumbnail = 0";
			$result1 = mysqli_query($con,$sql1);
			if ($result1) {
				$row1 = mysqli_fetch_array($result1);
				$goodsArray[0]["goodsImageName"] = $row1["t_imageName"];
			}
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $goodsArray);
		echo json_encode($resultArray);
	}else {
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}

mysqli_close($con);
?>

