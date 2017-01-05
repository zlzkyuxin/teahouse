<?php
$con = mysql_connect("localhost","root","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];

switch ($action) {
	//1.商城主页(左侧菜单栏:大类)<已完成>	
	// case 'showCategoryGoods':
	// 	showCategoryGoods();
	// 	break;
	//2.商城主页(右侧菜单栏:小类及图片)<已完成>	
	case 'showShopGoods':
		// $categoryID = $_POST['categoryID'];
		showShopGoods();
		break;
	//3.通过商品名来查询商品(模糊查询)<已完成>	
	case 'search':
		$goodsName = $_POST['goodsName'];
		$pageIndex = $_POST['pageIndex'];
		search($goodsName,$pageIndex);
		break;


	//4.产品详情接口<已完成>
	case 'goodsDetails':
		$goodsID = $_POST['goodsID'];
		goodsDetails($goodsID);
		break;


	// //5.订单详情和购买接口<已完成>
	// case 'buy':
	// 	$goodsID = $_POST['goodsID'];
	// 	buy($goodsID);
	// 	break;
	//6.确认订单<已完成>
	case 'payfor':
		$thirdID = $_POST['goodsID'];
		$userID = $_POST['userID'];
		payfor($thirdID,$userID);
		break;
	// //7.根据用户ID来查看所有收藏商品信息<已完成>
	// case 'collection':
	// 	$userID = $_POST['userID'];
	// 	collection($userID);
	// 	break;
	//8.生成订单并写入数据库
		case 'orderWrite':
		$orderNumber = $_POST['orderNumber'];
		$thirdID = $_POST['goodsID'];
		$userID = $_POST['userID'];
		$addressID = $_POST['addressID'];
		$goodsAmount = $_POST['goodsAmount'];
		$goodsTotal = $_POST['goodsTotal'];
		$goodsTime = $_POST['buygoodstime'];
		orderWrite($orderNumber,$thirdID,$userID,$addressID,$goodsAmount,$goodsTotal,$goodsTime);
		break;
		// //30.加入购物车
	case 'addBuyGoodsCar':
		$userID = $_POST['userID'];
		$goodsAmount = $_POST['goodsAmount'];
		$goodsID = $_POST['goodsID'];
		addBuyGoodsCar($userID,$goodsID,$goodsAmount);
	default:
		break;
}
// //1.商城主页(按类别排的商品列表)
// function showCategoryGoods()
// {
// 	$sql = "SELECT * FROM t_shopCategory ";
// 	$result = mysql_query($sql);
// 	if ($result) 
// 	{
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$key = array("CategoryID","CategoryName");
// 			$value = array($row["t_shopCategoryID"],$row["t_shopCategoryName"]);
// 			$results = array_combine($key, $value);
// 			array_push($array, $results);
			
// 		}
// 		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
// 		echo json_encode($resultArray);
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, 'msg' => "error");
// 		echo json_encode($resultArray);
// 	}
// }
//2.商城主页(右侧菜单栏:小类及图片)
function showShopGoods()
{
	$sql = "SELECT * FROM t_shopCategory ";
	$result = mysql_query($sql);
	if ($result) 
	{
		$dataArray = array();
		$i = 0;
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["CategoryID"] = $row["t_shopCategoryID"];
			$dataArray[$i]["CategoryName"] = $row["t_shopCategoryName"];
			$categoryID = $row["t_shopCategoryID"];
			$sql1 = "SELECT * FROM t_shopGoods where t_shopCtegory_t_shopCategoryID = $categoryID ";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				$goodsArray = array();
				$j = 0;
				while ($row = mysql_fetch_array($result1)) 
				{
					$goodsArray[$j]["goodsID"] = $row["t_shopGoodsID"];
					$goodsArray[$j]["goodsName"] = $row["t_shopGoodsName"];
					$goodsID = $row["t_shopGoodsID"]; 
					$sql3 = "SELECT * FROM t_shopthird WHERE t_shopGoods_t_shopGoodsID = $goodsID";
					$result3 = mysql_query($sql3);
					if ($result3) 
					{
						$thirdArray = array();
						$k = 0;
						while ($row3 = mysql_fetch_array($result3))
						{
							$thirdArray[$k]["goodsthirdID"] = $row3["t_shopthirdID"];
							$thirdArray[$k]["goodsThirdName"] = $row3["t_shopthirdName"];
							$thirdID = $row3["t_shopthirdID"];
							$sql2 = "SELECT * FROM t_image where t_shopthird_t_shopthirdID = $thirdID and t_imageIsThumbnail = 1";
							$result2 = mysql_query($sql2);
							if ($result2)
							{
								$goodsImageArray = array();
								$l = 0;
								while ($row1 = mysql_fetch_array($result2))
								{	
									$image = $row1["t_imageName"];
									// $goodsImageArray[$l]["isThumbnail"] = $row1["t_imageIsThumbnail"];

									$l++;
								}
								$thirdArray[$k]["goodsImage"] = $image;
							}
							$k++;
						}
						$goodsArray[$j]["thirdMenu"] = $thirdArray;
					}
					$j++;
				}
		     	$dataArray[$i]["goods"] =$goodsArray; 
			}
			$i++;
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}
//3.通过商品名来查询商品(模糊查询)
function search($goodsName,$pageIndex)
{
	$pageSize = 10;
	$offset = $pageSize * ($pageIndex - 1);
	$sql = "SELECT * FROM t_shopthird WHERE t_shopthirdName LIKE '%$goodsName%' limit $offset,$pageSize";
	$result = mysql_query($sql);
	if ($result) 
	{
		$thirdArray = array();
		$i = 0;
		while ($row = mysql_fetch_array($result)) 
		{
			$thirdArray[$i]["goodsID"] = $row["t_shopthirdID"];
			$thirdArray[$i]["goodsName"] = $row["t_shopthirdName"];
			$thirdArray[$i]["goodsPrice"] = $row["t_shopthirdPrice"];
			$thirdArray[$i]["goodsContent"] = $row["t_shopthirdcontent"];
			$thirdID = $row["t_shopthirdID"];
			$sql1 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $thirdID and t_imageIsThumbnail = 0";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$image = $row1["t_imageName"];
				}
			}
			$thirdArray[$i]["goodsImage"] = $image;
			$i++;		
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $thirdArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}

//4.产品详情接口
function goodsDetails($goodsID)
{
	$sql = "SELECT * FROM t_shopthird where t_shopthirdID = $goodsID";
	$result = mysql_query($sql);
	$goodsArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$goodsArray[$i]["goodsName"] = $row["t_shopthirdName"];
			$goodsArray[$i]["goodsPrice"] = $row["t_shopthirdPrice"];
			$goodsArray[$i]["goodsNumber"] = $row["t_shopNumber"];
			$goodsArray[$i]["goodsContent"] = $row["t_shopthirdcontent"];

			$sql4 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodsID and t_imageIsThumbnail = 0";
			$result4 = mysql_query($sql4);
			if ($result4) 
			{
				while ($row4 = mysql_fetch_array($result4)) 
				{
					$ThirdName = $row4["t_imageName"];
				}
			}
			$goodsArray[$i]["goodsImageName"] = $ThirdName;
			$sql1 = "SELECT * FROM t_usercomment where t_shopthird_t_shopthirdID = $goodsID";
			$result1 =mysql_query($sql1);
			if ($result1) 
			{
				$commentArray = array();
				$j = 0;
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$commentArray[$j]["CommentID"] = $row1["t_usercommentID"];
					$commentArray[$j]["CommentTitle"] = $row1["t_usercommentTitle"];
					$commentArray[$j]["CommentContent"] = $row1["t_usercommentContent"];
					$commentArray[$j]["CommentMoment"] = $row1["t_usercommentMoment"];

					$commentID = $row1["t_usercommentID"];

					$sql3 = "SELECT * FROM t_commentimage WHERE t_usercomment_t_usercommentID = $commentID";
					$result3 = mysql_query($sql3);
					$comimageArray = array();
					$l = 0;
					if ($result3) 
					{
						
						while ($row3 = mysql_fetch_array($result3)) 
						{
							$comimageArray[$l]["commentImageName"] = $row3["t_commentimageName"];
							$l++;
						}
						$commentArray[$j]["commentImage"] = $comimageArray;
					}


					$userID = $row1["t_user_t_userID"];
					
					$sql2 = "SELECT * FROM t_user where t_userID = $userID";
					$result2 =mysql_query($sql2);
					$userArray = array();
					$k = 0;
					if ($result2) 
					{
						
						while ($row2 = mysql_fetch_array($result2)) 
						{
							$userArray[$k]["Nickname"] = $row2["t_Nickname"];
							$userArray[$k]["userImage"] = $row2["t_userImage"];
							$k++;
						}
						$commentArray[$j]["user"] = $userArray;
					}
					$j++;					
				}
				$goodsArray[$i]["comment"] = $commentArray;
			}
			$i++;
		}
		$resultArray = array('code' => 200,"msg" => 'success','list' =>$goodsArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
	
}
	
// //5.订单详情或者购买接口
// function buy($goodsID)
// {	
// 	$sql = "SELECT * from t_shopGoods WHERE t_shopGoodsID = $goodsID";
// 	$result = mysql_query($sql);
// 	if ($result) {		
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) {
// 			$key = array("goodsName","goodsPrice");
// 			$value = array($row["t_shopGoodsName"],$row["t_shopGoodsPrice"]);		
// 			$results = array_combine($key, $value);
// 			array_push($array, $results);
// 		}
// 		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
// 		echo json_encode($resultArray);
// 	}
// 	else
// 	{
// 		echo "error";
// 	}
// }
//6.确认订单接口
function payfor($thirdID,$userID)
{
	$sql = "SELECT * from t_shopthird WHERE t_shopthirdID = $thirdID";
	$result = mysql_query($sql);
	if ($result) 
	{		
		$dataArray = array();
		$i = 0;
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["goodsName"] = $row["t_shopthirdName"];
			$dataArray[$i]["goodsPrice"] = $row["t_shopthirdPrice"];
			if ($row["t_goodsIsDiscount"]) {
				$dataArray[$i]["nowPrice"] = $row["t_shopthirdPrice"] * 75 / 100;
			}else
			{
				$dataArray[$i]["nowPrice"] = nill;
			}
			$sql3 = "SELECT * FROM t_image  where t_shopthird_t_shopthirdID = $thirdID";
			$result3 = mysql_query($sql3);
			if ($result3) 
			{		
				$array3 = array();
				while ($row3 = mysql_fetch_array($result3)) 
				{
					$dataArray[$i]["goodsImage"] = $row3["t_imageName"];
				}
				
			}
		}				
		
		$sql1 = "SELECT * FROM t_address  where t_user_t_userID = $userID";
		$result1 = mysql_query($sql1);
		if ($result1) 
		{		
			$array1 = array();
			while ($row = mysql_fetch_array($result1)) 
			{
				$key1 = array("addressID","name","phone","isDefault","province","region","detail");
				$value1 = array($row["t_addressID"],$row["t_addressRecipient"],$row["t_addressPhone"],$row["t_addressIsdefault"],$row["t_addressProvince"],$row["t_addressRegion"],$row["t_addressDetail"]);
				$results1 = array_combine($key1, $value1);
				array_push($array1, $results1);
			}
			
		}
		$sql2 = "SELECT * FROM t_DeliveryType";
		$result2 = mysql_query($sql2);
		if ($result2) 
		{		
			$array2 = array();
			while ($row = mysql_fetch_array($result2)) 
			{
				$key2 = array("DeliveryTypeID","DeliveryTypeName");
				$value2 = array($row["t_DeliveryTypeID"],$row["t_DeliveryTypeName"]);
				$results2 = array_combine($key2, $value2);
				array_push($array2, $results2);
			}	
		}
		$array4 = array('goods' =>$dataArray,'address' => $array1,'DeliveryType' => $array2);
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array4);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}
// //7.显示所有商品信息
// function showShopGoods()
// {
	
// 	$sql = "SELECT * from t_shopGoods";
// 	$result = mysql_query($sql);
// 	$dataArray = array();
// 	$i = 0;
// 	if ($result) {
		
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$dataArray[$i]["goodsID"] = $row["t_shopGoodsID"];
// 			$dataArray[$i]["goodsName"] = $row["t_shopGoodsName"];
// 			$dataArray[$i]["goodsPrice"] = $row["t_shopGoodsPrice"];
// 			$dataArray[$i]["goodsContent"] = $row["t_shopGoodscontent"];
// 			$dataArray[$i]["IsHot"] = $row["t_shopGoodsIsHot"];
// 			$categoryID = $row["t_shopCtegory_t_shopCategoryID"];
// 			$sql1 = "SELECT * FROM t_shopCategory WHERE t_shopCategoryID = '$categoryID'";
// 			$result1 = mysql_query($sql1);
// 			if ($result1) 
// 			{
// 				while ($row1 = mysql_fetch_array($result1))
// 				{
// 					$dataArray[$i]["categoryName"] = $row1["t_shopCategoryName"];
// 				}
// 			}
// 			$i++;
// 		}
// 		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
// 		echo json_encode($resultArray);
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, 'msg' => "error");
// 		echo json_encode($resultArray);
// 	}

// }
// //7.根据用户ID来查看所有收藏商品信息()
// function collection($userID)
// {
// 	$sql = "SELECT * FROM t_shopCollection where t_user_t_userID = '$userID'";
// 	$result = mysql_query($sql);
// 	if ($result)
// 	{
// 		$array = array();
// 		$dataArray = array();
// 		$i = 0;
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$dataArray[$i]["collectID"] = $row["t_shopCollectionID"];
// 			$dataArray[$i]["goodsID"] = $row["t_shopGoods_t_shopGoodsID"];
// 			$goodsID = $row["t_shopGoods_t_shopGoodsID"];
// 			$sql1 = "SELECT * FROM  t_shopGoods WHERE t_shopGoodsID = '$goodsID'";
// 			$result1 = mysql_query($sql1);
// 			if ($result1) 
// 			{
// 				while ($row1 = mysql_fetch_array($result1)) 
// 				{
// 					$dataArray[$i]["GoodsName"] = $row1["t_shopGoodsName"];
// 					$dataArray[$i]["GoodsPrice"] = $row1["t_shopGoodsPrice"];			
// 				}
// 			}
// 			$i++;				
// 		}
// 		$resultArray1 = array('code' => 200,'msg' => "success" , 'list' =>$dataArray);
// 		echo json_encode($resultArray1);
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, 'msg' => "error");
// 		echo json_encode($resultArray);
// 	}
// }
//8.生成订单并写入数据库
function orderWrite($orderNumber,$thirdID,$userID,$addressID,$goodsAmount,$goodsTotal,$goodsTime)
{

	$state = "待付款";
	$sql = "INSERT INTO `t_order`(`t_orderNumber` , `t_orderamount`, `t_orderTime`, `t_orderTotal`, `t_userID`, `t_shopthird_t_shopthirdID`, `t_address_t_addressID`, `t_orderstate`) VALUES ('$orderNumber','$goodsAmount','$goodsTime','$goodsTotal','$userID','$thirdID','$addressID','$state')";
	$result = mysql_query($sql);
	if ($result) 
	{
		$sql2 = "SELECT t_orderID FROM t_order WHERE t_orderID = (SELECT max(t_orderID) from t_order)";
		$result2 = mysql_query($sql2);
		$dataArray = array();
		$i=0;
		if ($result2) 
		{
			while ($row = mysql_fetch_array($result2)) 
			{
				$dataArray[$i]["orderID"] = $row["t_orderID"];
				$dataArray[$i]["orderState"] = $row["t_orderstate"];
				$i++;
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
//30.加入购物车
function addBuyGoodsCar($userID,$goodsID,$goodsAmount)
{
	$sql = "SELECT * FROM t_buyordercar WHERE t_user_t_userID = $userID AND t_shopthird_t_shopthirdID = $goodsID";
	$result = mysql_query($sql);
	$dataArray = array();
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			
			$buyorderID = $row["t_buyordercarID"];
			$amount = $row["t_buyordercarAmount"];
			$dataArray["buyorderID"] = $buyorderID; 
			
			$dataArray["amount"] = $goodsAmount;
			$sql2 = "UPDATE `t_buyordercar` SET `t_buyordercarAmount`= $goodsAmount WHERE t_buyordercarID = $buyorderID";
			$result2 = mysql_query($sql2);
			if ($result2)
			{
				
				$resultArray = array('code' => 200, 'msg' => "success","list" =>$dataArray);
				echo json_encode($resultArray);
			}
			else
			{
				$resultArray = array('code' => 500, 'msg' => "UPDATE error");
				echo json_encode($resultArray);
			}
		}
	}
	if(!mysql_num_rows($result))
	{
		if ($goodsAmount <= 0) 
		{
			$resultArray = array('code' => 300, 'msg' => "Amount error");
			echo json_encode($resultArray);
		}else
		{
			$sql1 = "INSERT INTO `t_buyordercar`(`t_buyordercarAmount`, `t_user_t_userID`, `t_shopthird_t_shopthirdID`) VALUES ('$goodsAmount','$userID','$goodsID')";	
			echo "$sql1";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				$resultArray = array('code' => 200, 'msg' => "success");
				echo json_encode($resultArray);
			}
			else
			{
				$resultArray = array('code' => 600, 'msg' => "INSERT error");
				echo json_encode($resultArray);
			}
		}
	}
	
}
mysql_close($con);
?>

