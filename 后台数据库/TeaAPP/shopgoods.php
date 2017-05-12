<?php
$con = mysqli_connect("localhost","yuxin","123456","teahouse");
mysqli_query($con,"SET NAMES utf8");

$action = $_POST['key'];
switch ($action) {
	//商品列表
	case 'showGoodsMenu':
		showGoodsMenu();
		break;
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
	//模糊搜索相近商品全称接口
	case 'searchGoodName':
		$goodStr = $_POST['goodStr'];
		searchGoodName($goodStr);
		break;
	//确认商品是否在接口
	case 'goodIsHave':
		$goodName = $_POST['goodName'];
		goodIsHave($goodName);
		break;
	default:
		break;
}

function showGoodsMenu() {
	$sql = "SELECT * FROM t_shopCategory";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$dataArray = array();
		$i=0;
		while ($row = mysqli_fetch_array($result)) {
			$dataArray[$i]["CategoryID"] = $row["t_shopCategoryID"];
			$dataArray[$i]["CategoryName"] = $row["t_shopCategoryName"];
			$categoryID = $row["t_shopCategoryID"];

			$sql1 = "SELECT * FROM t_shopGoods where t_shopCtegory_t_shopCategoryID = $categoryID ";
			$result1 = mysqli_query($con,$sql1);
			if ($result1) {
				$goodsArray = array();
				$j=0;
				while ($row1 = mysqli_fetch_array($result1)) {
					$goodsArray[$j]["goodsID"] = $row1["t_shopGoodsID"];
					$goodsArray[$j]["goodsName"] = $row1["t_shopGoodsName"];
					$goodsID = $row1["t_shopGoodsID"]; 

					$sql2 = "SELECT * FROM t_shopthird WHERE t_shopGoods_t_shopGoodsID = $goodsID";
					$result2 = mysqli_query($con,$sql2);
					if ($result2) {
						$thirdArray = array();
						$k=0;
						while ($row2 = mysqli_fetch_array($result2)) {
							$thirdArray[$k]["goodsthirdID"] = $row2["t_shopthirdID"];
							$thirdArray[$k]["goodsThirdName"] = $row2["t_shopthirdName"];
							$thirdID = $row2["t_shopthirdID"];

							$sql3 = "SELECT * FROM t_image where t_shopthird_t_shopthirdID = $thirdID and t_imageIsThumbnail = 1";
							$result3 = mysqli_query($con,$sql3);
							if ($result3) {
								while ($row3 = mysqli_fetch_array($result3)) {
									$thirdArray[$k]["goodsImage"] = $row3["t_imageName"];
								}
							}

							$k++;
						}
						$goodsArray[$j]["thirdMenu"] = $thirdArray;
					}
					$j++;
				}
				$dataArray[$i]["goodsMenu"] = $goodsArray;
			}
			$i++;
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
	}else {
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}


//按名称搜索
function goodsSearch($goodName) {
	$sql = "SELECT * FROM t_shopthird where t_shopthirdName = '$goodName'";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$goodsArray = array();
		while ($row = mysqli_fetch_array($result)) {
			$goodsArray[0]["goodsID"] = $row["t_shopthirdID"];
			$goodsArray[0]["goodsName"] = $row["t_shopthirdName"];
			$goodsArray[0]["goodsIsDiscount"] = $row["t_goodsIsDiscount"];
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

//产品详情接口
function goodsDetails($goodsID) {
	$sql = "SELECT * FROM t_shopthird where t_shopthirdID = $goodsID";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$goodsArray = array();
		while ($row = mysqli_fetch_array($result)) {
			$goodsArray[0]["goodsID"] = $goodsID;
			$goodsArray[0]["goodsName"] = $row["t_shopthirdName"];
			$goodsArray[0]["goodsIsDiscount"] = $row["t_goodsIsDiscount"];
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

//模糊搜索相近商品全称接口
function searchGoodName($goodStr) {
	$sql = "SELECT * FROM t_shopthird WHERE t_shopthirdName LIKE '%$goodStr%'";
	global $con;
	$result = mysqli_query($con,$sql);
	if ($result) {
		$thirdArray = array();
		$i=0;
		while ($row = mysqli_fetch_array($result)) {
			$thirdArray[$i]["goodName"] = $row["t_shopthirdName"];
			$i++;
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $thirdArray);
	}else {
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}

//确认商品是否在接口
function goodIsHave($goodName) {
	$sql = "SELECT * FROM t_shopthird WHERE t_shopthirdName = '$goodName'";
	global $con;
	// echo $sql;
	$result = mysqli_query($con,$sql);
	if ($result) {
		while ($row = mysqli_fetch_array($result)) {
			$resultArray = array('code' => 200, 'msg' => "success");
		}
		// $resultArray = array('code' => 300, 'msg' => "goood is not have");
	}else {
		$resultArray = array('code' => 500, 'msg' => "error");
	}
	echo json_encode($resultArray);
}


mysqli_close($con);
?>

