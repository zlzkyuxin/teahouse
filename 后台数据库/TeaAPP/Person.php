<?php
$con = mysql_connect("localhost","root","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];
switch ($action) {
	// //13.添加地址接口
	// case 'addAddress':
	// 	$pient = $_POST['Pient'];
	// 	$phone = $_POST['Phone'];
	// 	$userID = $_POST['userID'];
	// 	$isDefault =$_POST['IsDefault'];
	// 	$province = $_POST['Province'];
	// 	$region = $_POST['Region'];
	// 	$detail = $_POST['Detail'];
	// 	addAddress($pient,$phone,$userID,$isDefault,$province,$region,$detail);
	// 	break;
	// //14.删除地址
	// case 'deleteAddress':
	// 	$addressID =$_POST['addressID'];
	// 	deleteAddress($addressID);
	// 	break;
	// //15.修改地址
	case 'updateAddress':
		$Province = $_POST['Province'];
		$Region = $_POST['Region'];
		$Detail = $_POST['Detail'];
		$userID =$_POST['userID'];
		updateAddress($Province,$Region,$Detail,$userID);
		break;
	// //16.查收货地址(按用户id)
	// case 'searchAddress':
	// 	$userID = $_POST['userID'];
	// 	searchAddress($userID);
	// 	break;
	//17.个人中心页面
	case 'showperson':
		$phone = $_POST['phone']; 
		showperson($phone);
		break;
	//18.账户安全
	case 'showAccount':
		$userID = $_POST['userID'];
		showAccount($userID);
		break;
	// //19.全部订单
	// case 'user0rder':
	// 	$userID = $_POST['userID'];
	// 	user0rder($userID);
	// 	break;
	// //20.评论页(待完善解决)
	case 'userComment':
		$userID = $_POST['userID'];
		$goodsID = $_POST['goodsID'];
		$comment = $_POST['comment'];
		$commtime=$_POST['commtime'];
		userComment($userID,$goodsID,$comment,$commtime);
		break;
	//21.注册接口
	case 'regist':
		$phone = $_POST['phone'];
		$password = $_POST['password'];
		regist($phone,$password);
		break;
	//22.登陆接口
	case 'login':
		$phone = $_POST['phone'];
		$password = $_POST['password'];
		login($phone,$password);
		break;
	//23.个人资料页面
	case 'showUser':
		$userID = $_POST['userID'];
		showUser($userID);
		break;
	// //26.查看通知消息
	// case 'showNotice':
	// 	showNotice();
	// 	break;
	//27.查看支付方式
	case 'showPayType':
		showPayType();
		break;
	case 'updatanick':
	    $userID = $_POST['userID'];
	    $userNick = $_POST['userNick'];
	    $usersex = $_POST['usersex'];
	    updatanick($userID,$userNick,$usersex);
	break;	
	// //28.意见反馈
	// case 'feedBack':
	//     $feedbackCont = $_POST["content"];
	//     $feedbackPhone = $_POST["phone"];
	//     $feedTypeID = $_POST["backTypeID"];
	// 	feedBack($feedbackCont,$feedbackPhone,$feedTypeID);
	// 	break;

	//29.购物车商品详情
	case 'buyGoodsCar':
		$goodsID = $_POST['goodsID'];
		$userID = $_POST["userID"]; 
		buyGoodsCar($goodsID,$userID);
		break;
	// //30.加入购物车
	case 'addBuyGoodsCar':
		$userID = $_POST['userID'];
		$goodsAmount = $_POST['goodsAmount'];
		$goodsID = $_POST['goodsID'];
		addBuyGoodsCar($userID,$goodsID,$goodsAmount);
		break;
	default:		
		# code...
		break;
}
// //13.添加地址接口
// function addAddress($Pient,$Phone,$userID,$IsDefault,$Province,$Region,$Detail)
// {
// 	$sql = "INSERT INTO `t_address`(`t_addressRecipient`, `t_addressPhone`, `t_user_t_userID`, `t_addressIsdefault`, `t_addressProvince`, `t_addressRegion`, `t_addressDetail`) VALUES ('$Pient','$Phone','$userID','$IsDefault','$Province','$Region','$Detail')";
	
// 	$result = mysql_query($sql);
// 	if ($result) 
// 	{		
// 		$resultArray = array('code' => 200, "msg" => 'success');
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, "  msg" => 'error');
// 	}
// 	echo json_encode($resultArray);
// }
// //14.删除地址
// function deleteAddress($addressID)
// {

// 	$sql = "DELETE FROM `t_address` WHERE t_addressID = $addressID";	
// 	$result = mysql_query($sql);
// 	if ($result) 
// 	{		
// 		$resultArray = array('code' => 200, "msg" => 'success');
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, "msg" => 'error');
// 	}
// 	echo json_encode($resultArray);
// }
// // //15.修改地址
function updateAddress($Province,$Region,$Detail,$userID)
{

	$sql = "UPDATE t_address SET t_addressProvince = '$Province',t_addressRegion = '$Region', t_addressDetail = '$Detail' where t_user_t_userID = '$userID'";	
	echo "$sql";
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

function updatanick($userID,$userNick,$usersex)
{

	$sql = "UPDATE t_user SET t_Nickname = '$userNick',t_userSex = '$usersex' WHERE t_userID ='$userID'";
	echo "$sql";
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

// //16.查地址接口
// function searchAddress($userID)
// {

// 	$sql = "SELECT * FROM t_address  where t_user_t_userID = $userID";
// 	$result = mysql_query($sql);
// 	if ($result) 
// 	{
		
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$key = array("address","name","phone","isDefault","province","region","detail");
// 			$value = array($row["t_addressID"],$row["t_addressRecipient"],$row["t_addressPhone"],$row["t_addressIsdefault"],$row["t_addressProvince"],$row["t_addressRegion"],$row["t_addressDetail"]);

// 			$results = array_combine($key, $value);
// 			array_push($array, $results);	
// 	  	}
// 	$resultArray = array('code' => 200,'msg' =>"success",'list' => $array);
// 	echo json_encode($resultArray);
// 	}
// 	else 
// 	{
// 		$resultArray = array('code' => 500,'msg' =>"error");
// 		echo json_encode($resultArray);
// 	}
// }

// //17.个人中心页面
function showperson($phone)
{
	$dataArray = array();
	$i = 0;
	$sql = "SELECT * FROM t_user where t_userPhone = $phone";
	$result = mysql_query($sql);
	if ($result)
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["nickName"] = $row["t_Nickname"];	
			$dataArray[$i]["userImage"] = $row["t_userImage"];
		}
		
		$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500,'msg' =>"error");
		echo json_encode($resultArray);
	}

}
//18.账户安全
// function showAccount($userID)
// {
// 	$dataArray = array();
// 	$i = 0;
// 	$sql = "SELECT * FROM t_Account where t_user_t_userID = $userID";
// 	$result = mysql_query($sql);
// 	if ($result)
// 	{
// 		while ($row = mysql_fetch_array($result)) 
// 		{

// 			$dataArray[$i]["AccountID"] = $row["t_AccountID"];
// 			$dataArray[$i]["AccountBalance"] = $row["t_AccountBalance"];
// 			$userID = $row["t_user_t_userID"];
// 			$sql1 = "SELECT * from t_user WHERE t_userID = $userID";
// 			$result1 = mysql_query($sql1);
// 					if ($result1) 
// 					{
// 						while ($row1 = mysql_fetch_array($result1)) 
// 						{
// 							$dataArray[$i]["userName"] = $row1["t_userName"];

// 						    $dataArray[$i]["userPhone"] = $row1["t_userPhone"];
//  						}
// 					}


// 		}
// 	}

// 	$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
// 	echo json_encode($resultArray);
// 	else
// 	{
// 		$resultArray = array('code' => 500,'msg' =>"error");
// 		echo json_encode($resultArray);
// 	}
// }
// //19.全部订单
// function user0rder($userID)
// {
// 	$sql = "SELECT * from t_userOrder WHERE t_user_t_userID = $userID";
// 	$result = mysql_query($sql);
// 	$dataArray = array();
// 	$i = 0 ;
// 	if ($result) 
// 	{		
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$orderID = $row["t_order_t_orderID"];
// 			$goodsID = $row["t_shopGoods_t_shopGoodsID"];
// 			$sql1 = "SELECT * from t_order WHERE t_orderID = $orderID";
// 			$result1 = mysql_query($sql1);
// 			if ($result1) 
// 			{
// 				while ($row1 = mysql_fetch_array($result1)) 
// 				{
// 					$dataArray[$i]["buyTime"] = $row1["t_orderTime"];
// 				}
// 			}
// 			$sql2 = "SELECT * from t_shopGoods WHERE t_shopGoodsID = $goodsID";
// 			$result2 = mysql_query($sql2);
// 			if ($result2) 
// 			{
// 				while ($row2 = mysql_fetch_array($result2)) 
// 				{
// 					$dataArray[$i]["goodsName"] = $row2["t_shopGoodsName"];
// 					$dataArray[$i]["goodsPrice"] = $row2["t_shopGoodsPrice"];
// 					$image = $row2["t_image_t_imageID"];
// 					$sql3 = "SELECT * from t_image WHERE t_imageID = $image";
// 					$result3 = mysql_query($sql3);
// 					if ($result3) 
// 					{
// 						while ($row3 = mysql_fetch_array($result3)) 
// 						{
// 							$dataArray[$i]["goodsImage"] = $row3["t_imageName"];
// 						}
// 					}
// 				}

// 			}
// 			$i++;
// 		}
						
// 	}
// 	$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
// 	echo json_encode($resultArray);
// 	else 
// 	{
// 		$resultArray = array('code' => 500,'msg' =>"error");
// 		echo json_encode($resultArray);
// 	}
// }

//20.评论页
function userComment($userID,$goodsID,$comment,$commtime)
{
	$sql="INSERT INTO `t_usercomment`(`t_user_t_userID`,`t_shopthird_t_shopthirdID` ,`t_usercommentContent`, `t_usercommentMoment`) VALUES ('$userID','$goodsID','$comment','$commtime')";
	$result=mysql_query($sql);
	if ($result) {
		$resultArray = array('code' => 200,'msg' =>"success");
		echo json_encode($resultArray);
	}
	else 
	{
		$resultArray = array('code' => 500,'msg' =>"error");
		echo json_encode($resultArray);
	}	
}


// //21.注册接口
function regist($phone,$password)
{
	$isSame = 0;
	$sql4 = "SELECT t_userPhone FROM t_user";
	$result4 = mysql_query($sql4);
	if ($result4)
	{
		while ($row = mysql_fetch_array($result4)) 
		{
			$phone1 = $row["t_userPhone"];
			if ($phone1 != $phone) 
			{
				$isSame = 0;				
			}else
			{
				$isSame = 1;
			}
		}
	}
	if ($isSame == 0) 
	{
		$sql = "INSERT INTO t_user(t_userName,t_userPhone,t_userAge,t_userSex,t_userPassword,t_Nickname) values ('$phone','$phone','18','不详','$password','$phone')";
		$result = mysql_query($sql);
		if ($result) 
		{	
			$sql1 = "SELECT * FROM t_user WHERE t_userPhone = $phone";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row = mysql_fetch_array($result1)) 
				{
					$userID = $row["t_userID"];
					$sql2 = "INSERT INTO t_Account(t_AccountBalance,t_user_t_userID)VALUES('0','$userID')";
					$result2 = mysql_query($sql2);
					if ($result2) 
					{
						$resultArray = array('code' => 200, "msg" => 'success');
					}
				}
			}
			
		}
		else
		{
			$resultArray = array('code' => 500, "msg" => 'error');
		}
		
	}
	else
	{
		$resultArray = array('code' => 300, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//22.登陆接口
function login($phone,$password)
{
	$sql = "SELECT t_userID from t_user where t_userPhone = $phone and t_userPassword = $password";
	$result = mysql_query($sql);
	if ($result) 
	{
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("userID");
			$value = array($row["t_userID"]);
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, "msg" => 'success','list' => $array);
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	
	echo json_encode($resultArray);
}
//23.个人资料页面
function showUser($userID)
{	
	$sql = "SELECT * from t_user where t_userID = $userID";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["Nickname"] = $row["t_Nickname"];
			$dataArray[$i]["userSex"] = $row["t_userSex"];
			$dataArray[$i]["userImage"] = $row["t_userImage"];
			
		}
		$i++;
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500,'msg' =>"error");
		echo json_encode($resultArray);
	}
}
// //26.查看通知消息
// function showNotice()
// {
// 	$sql = "SELECT * from t_Noticet";
// 	$result = mysql_query($sql);
// 	if ($result) {
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) {
// 			$key = array("NoticeID","NoticeName","NoticeContent","NoticeMoment","NoticeImage");
// 			$value = array($row["t_NoticetID"],$row["t_NoticetName"],$row["t_NoticetContent"],$row["t_NoticetMoment"],$row["t_NoticetImage"]);
// 			$results = array_combine($key, $value);
// 			array_push($array, $results);
// 		}
// 		$resultArray = array('code' =>200,"msg" =>'success','list' => $array);
// 		echo json_encode($resultArray);
// 	}
// 	else 
// 	{
// 		$resultArray = array('code' => 500,'msg' =>"error");
// 		echo json_encode($resultArray);
// 	}
// }
//27.查看支付方式
function showPayType()
{
	$sql = "SELECT * FROM t_payType";
	$result = mysql_query($sql);
	if ($result) {
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("typeID","typename");
			$value = array($row["t_payTypeID"],$row["t_payTypeName"]);

			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200,'msg' =>"success",'lisft' => $array);
		echo json_encode($resultArray);
	}else
	{
		$resultArray = array('code' => 500,'msg' =>"error");
		echo json_encode($resultArray);
	}
}
// //28.插入反馈内容
// function feedBack($feedbackCont,$feedbackPhone,$feedTypeID)
// {
// 	$sql = "SELECT * FROM t_feedbackType where t_feedbackTypeID = $feedTypeID";
// 	$result = mysql_query($sql);
// 	if ($result) 
// 	{
// 		$array = array();
// 		while ($row = mysql_fetch_array($result)) 
// 		{
// 			$key = array("feedtypeName");
// 			$value = array($row["t_feedbackTypeName"]);
// 			$results = array_combine($key, $value);

// 			array_push($array, $results);
// 		}
// 	}
// 	$sql1 = "INSERT INTO t_shopFeedback(t_shopFeedbackContent,t_shopFeedbackPhone,t_feedbackType_t_feedbackTypeID)VALUES('$feedbackCont','$feedbackPhone','$feedTypeID')";
// 	$result1 = mysql_query($sql1);
// 	if ($result1) {
// 		$resultArray = array('code' => 200, "msg" => 'success','list' => $array);
// 	}
// 	else
// 	{
// 		$resultArray = array('code' => 500, "msg" => 'error');
// 	}
// 	echo json_encode($resultArray);
// }
//29.购物车商品详情 t_goodsIsDiscount t_shopNumber
function buyGoodsCar($goodsID,$userID)
{
	$dataArray = array();
	$i = 0;
	if ($goodsID) 
	{
		$sql = "SELECT * FROM t_shopthird WHERE t_shopthirdID = $goodsID";
		$result = mysql_query($sql);
		
		if ($result) 
		{
			while ($row = mysql_fetch_array($result)) 
			{
				$dataArray[$i]["goodsName"] = $row["t_shopthirdName"];
				$dataArray[$i]["goodsContent"] = $row["t_shopthirdcontent"];
				$dataArray[$i]["BeforePrice"] = $row["t_shopthirdPrice"];
				$dataArray[$i]["soldAmount"] = $row["t_shopNumber"];
				if ($row["t_goodsIsDiscount"]) 
				{
					$dataArray[$i]["nowPrice"] = $row["t_shopthirdPrice"] * 75 / 100;
				}else
				{
					$dataArray[$i]["nowPrice"] = null;
				}
				$sql1 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $goodsID AND t_imageIsThumbnail = 1";
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
			
			$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
			echo json_encode($resultArray);
		}
		else
		{
			$resultArray = array('code' => 500, 'msg' => "error");
			echo json_encode($resultArray);
		}
	}else
	{
		$sql2 = "SELECT * FROM t_buyordercar WHERE t_user_t_userID = $userID";
		$result2 = mysql_query($sql2);
		if ($result2) 
		{
			while ($row2 = mysql_fetch_array($result2)) 
			{
				$thirdID = $row2["t_shopthird_t_shopthirdID"];
				$sql3 = "SELECT * FROM t_shopthird WHERE t_shopthirdID = $thirdID";
				$result3 = mysql_query($sql3);
				if ($result3) 
				{
					while ($row3 = mysql_fetch_array($result3)) 
					{
						$dataArray[$i]["goodsID"] = $row3["t_shopthirdID"];
						$dataArray[$i]["goodsName"] = $row3["t_shopthirdName"];
						$dataArray[$i]["goodsContent"] = $row3["t_shopthirdcontent"];
						$dataArray[$i]["BeforePrice"] = $row3["t_shopthirdPrice"];
						$dataArray[$i]["soldAmount"] = $row3["t_shopNumber"];
						if ($row3["t_goodsIsDiscount"]) 
						{
							$dataArray[$i]["nowPrice"] = $row["t_shopthirdPrice"] * 75 / 100;
						}else
						{
							$dataArray[$i]["nowPrice"] = null;
						}
						$sql4 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $thirdID AND t_imageIsThumbnail = 1";
						$result4 = mysql_query($sql4);
						if ($result4) 
						{
							while ($row4 = mysql_fetch_array($result4)) 
							{
								$dataArray[$i]["goodsImage"] = $row4["t_imageName"]; 
							}
						}
						$i++;
					}
				}
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
			$upAmount = $amount + $goodsAmount;
			if ($upAmount <= 0) {
				$upAmount = "0";
			}
			$sql2 = "UPDATE `t_buyordercar` SET `t_buyordercarAmount`= $upAmount WHERE t_buyordercarID = $buyorderID";
			$result2 = mysql_query($sql2);
			if ($result2)
			{
				$dataArray["buyorderID"] = $buyorderID; 
				$dataArray["amount"] = $upAmount;
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