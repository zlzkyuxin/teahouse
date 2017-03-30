<?php
$con = mysql_connect("localhost","yuxin","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];
switch ($action) {
	//首页轮播图片和热门推荐商品名及图片接口
	case 'showHome':
		showHome();
		break;
	//专区的商品信息
	case 'showArea':
		$areaID = $_POST["areaID"]; 
		showArea($areaID);
		break;
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

//首页轮播图片和热门推荐商品名及图片接口
function showHome()
{
	$sql = "SELECT * FROM  t_teascroller where t_teaScrollerIsHome = 1";
	$result = mysql_query($sql);
	if ($result) 
	{
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("imageID","scrollerImage");
			$value = array($row["t_teaScrollerID"],$row["t_teaScrollerImage"]);
			$results = array_combine($key, $value);
			array_push($array,$results);
		}
	}
	$sql1 = "SELECT * FROM t_shopthird where t_shopgoodsishot = 1";
	$result1 = mysql_query($sql1);
	if ($result1) 
	{
		$shopgoodsArray = array();
		$HotGoods1 = array();
		$i = 0;
		while ($row1 = mysql_fetch_array($result1)) 
		{
			$shopgoodsArray[$i]["goodsID"] = $row1["t_shopthirdID"];
			$shopgoodsArray[$i]["goodsName"] = $row1["t_shopthirdName"];
			$shopgoodsArray[$i]["content"] = $row1["t_shopthirdcontent"];
			$shopgoodsArray[$i]["beforePrice"] = '￥'.$row1["t_shopthirdPrice"];
			if ($row1["t_goodsIsDiscount"] == 1) 
			{
				$bePrice = $row1["t_shopthirdPrice"];
				$noPrice = round($bePrice * 0.75,2);//四舍五入函数
				$shopgoodsArray[$i]["nowPrice"] = '￥'."$noPrice";
			}
			$goodsID = $row1["t_shopthirdID"];
			$goodsGoodsID = $row1["t_shopGoods_t_shopGoodsID"]; 
			$sql2 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodsID and t_imageIsThumbnail = 0";
			$result2 = mysql_query($sql2);
			if ($result2) 
			{
				while ($row2 = mysql_fetch_array($result2)) 
				{
					$shopgoodsArray[$i]["detailsImageName"] = $row2["t_imageName"];
				}
			}
			$sql3 = "SELECT * FROM t_shopgoods where t_shopGoodsID = $goodsGoodsID";
			$result3 = mysql_query($sql3);
			if ($result3) 
			{
				while ($row3 = mysql_fetch_array($result3)) 
				{
					$categoryID = $row3["t_shopCtegory_t_shopCategoryID"];
					$sql4 = "SELECT * FROM t_shopcategory WHERE t_shopCategoryID = $categoryID";
					$result4 = mysql_query($sql4);
					if ($result4) 
					{
						while ($row4 = mysql_fetch_array($result4)) 
						{
							$shopgoodsArray[$i]["categoryName"] = $row4["t_shopCategoryName"];
						}
					}
				}
			}
			$i++;		
		}
	$resultArray = array('code' => "200", 'msg' => "success",'list' => array('HotGoods' => $shopgoodsArray));
	echo json_encode($resultArray);
	}

	
	else
	{
		$resultArray = array('code' => "500", 'msg' => "error");
		echo json_encode($resultArray);	
	}

}
//专区的商品信息
function showArea($areaID)
{
	$dataArray = array();
	$i = 0;
	$sql = "SELECT * FROM t_shopthird WHERE t_thirdType = $areaID";
	// echo "$sql";
	$result = mysql_query($sql);
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["goodsID"] = $row["t_shopthirdID"];
			$dataArray[$i]["goodsName"] = $row["t_shopthirdName"];
			$dataArray[$i]["content"] = $row["t_shopthirdcontent"];
			$dataArray[$i]["goodsPrice"] = $row["t_shopthirdPrice"];
			$dataArray[$i]["goodsNuber"] = $row["t_shopNumber"];
			if ($row["t_goodsIsDiscount"]) 
			{
				$bePrice = $row["t_shopthirdPrice"];
				$nowPrice = $bePrice * 75 / 100;
				$dataArray[$i]["nowPrice"] = "$nowPrice";
			}
			$sold = (2500 - $row["t_shopNumber"]);
			if ($sold) {
				$dataArray[$i]["soldAmount"] = "$sold";
			}else
			{
				$dataArray[$i]["soldAmount"] = "已售罄";
			}
			
			$thirdID = $row["t_shopthirdID"];
			$sql1 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $thirdID and t_imageIsThumbnail = 0";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$dataArray[$i]["goodsImage"] = $row1["t_imageName"];
				}
			}
			$i++;
		}
	$resultArray = array('code' => "200", 'msg' => "success",'list' => $dataArray);
	echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => "500", 'msg' => "error");
		echo json_encode($resultArray);	
	}
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