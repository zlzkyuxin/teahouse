<?php
$con = mysql_connect("localhost","root","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("TeaHouse")or die("error!");
$action = $_POST['key'];

switch ($action) {

	//1-7茶文化模块
	//1.茶历史介绍接口
	case 'showteaHistory':
		showteaHistory();
		break;
	//2.茶的种类展示接口
	case 'showTeaType':
		showTeaType();
		break;
	//3.具体的茶的信息展示接口
	case 'showTea':
		$teaTypeID = $_POST['typeID'];
		showTea($teaTypeID);
		break;
	//4.茶具的种类展示接口
	case 'showTeaAppType':
		showTeaAppType();
		break;
	//5.具体的茶具的信息展示接口
	case 'showTeaAppliances':
		$teaAppTypeID = $_POST['apptypeID'];
		showTeaAppliances($teaAppTypeID);
		break;
	//6.茶艺的种类展示接口
	case 'showTeaCeremonyType': 
		showTeaCeremonyType();
		break;
	//7.茶艺的信息展示接口
	case 'showTeaCeremony':
		$teaCeremonyID = $_POST['teaCeremonyID'];
		showTeaCeremony($teaCeremonyID);
		break;
	//8.热门商品图片及商品展示
	case 'showHotGoods':
		showHotGoods();
		break;
	//9.通过商品名或者商品类别来查询商品	
	case 'search':
		$goodsName = $_POST['goodsName'];
		$categoryID = $_POST['ctegoryID'];
		search($goodsName,$categoryID);
		break;
	//10.产品详情接口
	case 'goodsDetails':
		$goodsID = $_POST['goodsID'];
		goodsDetails($goodsID);
		break;
	//11.订单详情和购买接口
	case 'buy':
		$goodsID = $_POST['goodsID'];
		buy($goodsID);
		break;
	//12.确认订单
	case 'payfor':
		$goodsID = $_POST['goodsID'];
		$userID = $_POST['userID'];
		payfor($goodsID,$userID);
		break;
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
	//17.个人中心页面
	case 'showperson':
		$userID = $_POST['userID']; 
		showperson($userID);
		break;
	//18.账户安全
	case 'showAccount':
		$userID = $_POST['userID'];
		showAccount($userID);
		break;
	//19.全部订单
	case 'user0rder':
		$userID = $_POST['userID'];
		user0rder($userID);
		break;
	//20.评论页(待完善解决)
	case 'userComment':
		$userID = $_POST['userID'];
		$goodsID = $_POST['goodsID'];
		$comment = $_POST['comment'];
		userComment($userID,$goodsID,$comment);
		break;
	//21.注册接口
	case 'regist':
		$t_userName = $_POST['name'];
		$t_userAge = $_POST['age'];
		$t_userSex = $_POST['sex'];
		$t_userPassword = $_POST['password'];
		$t_Nickname = $_POST['nickname'];
		$t_userImage_t_userImageID = $_POST['image'];
		regist($t_userName,$t_userAge,$t_userSex,$t_userPassword,$t_Nickname,$t_userImage_t_userImageID);
		break;
	//22.登陆接口
	case 'login':
		$t_userName = $_POST['name'];
		$t_userPassword = $_POST['Password'];
		login($t_userName,$t_userPassword);
		break;
	//23.个人资料页面
	case 'showUser':
		$userID = $_POST['userID'];
		showUser($userID);
		break;
	//24.显示所有商品信息
	case 'showShopGoods':
		showShopGoods();
		break;
	//25.根据用户ID来查看所有收藏商品信息
	case 'collection':
		$userID = $_POST['UserID'];
		collection($userID);
		break;	
	//26.查看通知消息
	case 'showNotice':
		showNotice();
		break;
	//27.查看支付方式
	case 'showPayType':
		showPayType();
		break;
	//28.意见反馈
	case 'feedBack':
	    $feedbackCont = $_POST["content"];
	    $feedbackPhone = $_POST["phone"];
	    $feedTypeID = $_POST["backTypeID"];
		feedBack($feedbackCont,$feedbackPhone,$feedTypeID);
		break;
	default:		
		# code...
		break;
}
//1.茶历史介绍接口
function showteaHistory()
{
	$sql = "SELECT t_teaHistotyIntro FROM t_teaHistoty";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("Content");
			$value = array($row["t_teaHistotyIntro"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//2.茶的种类展示接口
function showTeaType()
{
	$sql = "SELECT * FROM  t_teaType";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("teaTypeID","teaTypeName","teaTypeImage");
			$value = array($row["t_teaTypeID"],$row["t_teaTypeName"],$row["t_teaTypeImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//3.具体的茶的信息展示接口
function showTea($teaTypeID)
{
	$sql = "SELECT * FROM  t_tea where t_teaType_t_teaTypeID = $teaTypeID";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("teaID","teaName","Introduction","teaImage");
			$value = array($row["t_teaID"],$row["t_teaName"],$row["t_teaIntroduction"],$row["t_teaImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//4.茶具的种类展示接口
function showTeaAppType()
{
	$sql = "SELECT * FROM t_teaAppliancesType";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("teaAppTypeID","teaAppTypeName","teaAppTypeImage");
			$value = array($row["t_teaAppliancesTypeID"],$row["t_teaAppTName"],$row["t_teaAppImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//5.具体的茶具的信息展示接口
function showTeaAppliances($teaAppTypeID)
{
	$sql = "SELECT * FROM  t_teaAppliances where t_teaAppliancesType_t_teaAppliancesTypeID = $teaAppTypeID";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("AppliancesID","AppliancesName","Introduction","AppliancesImage");
			$value = array($row["t_teaAppliancesID"],$row["t_teaAppliancesName"],$row["t_teaAppIntro"],$row["t_teaAppImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//6.茶艺的种类展示接口
function showTeaCeremonyType()
{
	$sql = "SELECT * FROM t_teaCeremonyType";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("teaCeremonyTypeID","teaCeremonyTypeName","teaCeremonyTypeImage");
			$value = array($row["t_teaCeremonyTypeID"],$row["t_teaCTName"],$row["t_teaCeremonyTypeImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//7.茶艺的茶具的信息展示接口
function showTeaCeremony($teaCeremonyID)
{
	$sql = "SELECT * FROM t_teaCeremony where t_teaCeremonyType_t_teaCeremonyTypeID = $teaCeremonyID";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("CeremonyID","CeremonyIntro","CeremonyImage");
			$value = array($row["t_teaCeremonyID"],$row["t_teaCIntroduction"],$row["t_teaCeremonyImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//8.热门商品图片及商品名展示
function showHotGoods()
{
	$sql = "SELECT * FROM t_shopGoods where t_shopGoodsIsHot = '1'";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["goodID"] = $row["t_shopGoodsID"];
			$dataArray[$i]["goddName"] = $row["t_shopGoodsName"];
			$dataArray[$i]["goddImageID"] = $row["t_image_t_imageID"];
			$image = $row["t_image_t_imageID"];
			$sql1 = "SELECT * FROM t_image where t_imageID = $image";
			$result1 =mysql_query($sql1);
			if ($result1) 
			{
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$dataArray[$i]["goodsImage"] = $row1["t_imageName"];
				}
			}
			$i++;
		}
	}
		$resultArray = array('code' => 200,"msg" => 'success','list' =>$dataArray);
		echo json_encode($resultArray);
}
//9.通过商品名或者商品类别来查询商品
function search($goodsName,$categoryID)
{
	$sql = "SELECT * from t_shopGoods where t_shopGoodsName = '$goodsName' or t_shopCtegory_t_shopCategoryID = '$categoryID'";
	$result = mysql_query($sql);
	if ($result) {
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("goodsID","goodsName","goodsPrice","goodsContent","t_t_shopCetegoryID","IsHot");
			$value = array($row["t_shopGoodsID"],$row["t_shopGoodsName"],$row["t_shopGoodsPrice"],$row["t_shopGoodscontent"],$row["t_shopCtegory_t_shopCategoryID"],$row["t_shopGoodsIsHot"]);
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//10.产品详情接口
function goodsDetails($goodsID)
{

	$sql = "SELECT * FROM t_shopGoods where t_shopGoodsID = $goodsID";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["goodsID"] = $row["t_shopGoodsID"];
			$dataArray[$i]["goddName"] = $row["t_shopGoodsName"];
			$dataArray[$i]["goodPrice"] = $row["t_shopGoodsPrice"];
			$dataArray[$i]["goodContent"] = $row["t_shopGoodscontent"];
			$dataArray[$i]["shopcategoryID"] = $row["t_shopCtegory_t_shopCategoryID"];
			$dataArray[$i]["isHot"] = $row["t_shopGoodsIsHot"];
			$sql1 = "SELECT * FROM t_userComment where t_shopGoods_t_shopGoodsID = $goodsID";
			$result1 =mysql_query($sql1);
			if ($result1) 
			{
				while ($row = mysql_fetch_array($result1)) 
				{
					$dataArray[$i]["CommentID"] = $row["t_userCommentID"];
					$dataArray[$i]["CommentTitle"] = $row["t_userCommentName"];
					$dataArray[$i]["CommentContent"] = $row["t_userCommentContent"];
					$dataArray[$i]["CommentMoment"] = $row["t_userCommentMoment"];
					// $dataArray[$i]["userID"] = array($row["t_user_t_userID"]);
					$userID = $row["t_user_t_userID"];
					$sql2 = "SELECT * FROM t_user where t_userID = $userID";
					$result2 =mysql_query($sql2);
					if ($result2) 
					{
						while ($row = mysql_fetch_array($result2)) 
						{
							$dataArray[$i]["Nickname"] = $row["t_Nickname"];
							$userImage = $row["t_userImage_t_userImageID"];
							$sql3 = "SELECT * FROM t_userImage where t_userImageID = $userImage";
							$result3 =mysql_query($sql3);
							if ($result3) 
							{
								while ($row = mysql_fetch_array($result3)) 
								{
									$dataArray[$i]["userImage"] = $row["t_userImageName"];
								}
							}
						}
					}
				}
			}
			$i++;
		}

	}
		$resultArray = array('code' => 200,"msg" => 'success','list' =>$dataArray);
		echo json_encode($resultArray);
}
//11.订单详情或者购买接口
function buy($goodsID)
{	
	$sql = "SELECT * from t_shopGoods WHERE t_shopGoodsID = $goodsID";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("goodsName","goodsPrice");
			$value = array($row["t_shopGoodsName"],$row["t_shopGoodsPrice"]);		
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}
//12.确认订单接口
function payfor($goodsID,$userID)
{
	$sql = "SELECT * from t_shopGoods WHERE t_shopGoodsID = $goodsID";
	$result = mysql_query($sql);
	if ($result) 
	{		
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("goodsName","goodsPrice");
			$value = array($row["t_shopGoodsName"],$row["t_shopGoodsPrice"]);		
			$results = array_combine($key, $value);
			array_push($array, $results);
		}				
	}
	$sql1 = "SELECT * FROM t_address  where t_user_t_userID = $userID";
	$result1 = mysql_query($sql1);
	if ($result1) 
	{		
		$array1 = array();
		while ($row = mysql_fetch_array($result1)) 
		{
			$key1 = array("name","phone","isDefault","province","region","detail");
			$value1 = array($row["t_addressRecipient"],$row["t_addressPhone"],$row["t_addressIsdefault"],$row["t_addressProvince"],$row["t_addressRegion"],$row["t_addressDetail"]);
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
	$array3 = array('goods' =>$array,'address' => $array1,'DeliveryType' => $array2);
	$resultArray = array('code' => 200, 'msg' => "success",'list' => $array3);
	echo json_encode($resultArray);
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
}
//17.个人中心页面
function showperson($userID)
{
	$dataArray = array();
	$i = 0;
	$sql = "SELECT * FROM t_user where t_userID = $userID";
	$result = mysql_query($sql);
	if ($result)
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["Nickname"] = array($row["t_Nickname"]);
		}
		
	}
	$sql1 = "SELECT * FROM t_shopCollection where t_user_t_userID = $userID";
	$result1 = mysql_query($sql1);
	$dataArray[$i]["CollectionAmount"] = array(mysql_num_rows($result1));
	$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
	echo json_encode($resultArray);
}
//18.账户安全
function showAccount($userID)
{
	$dataArray = array();
	$i = 0;
	$sql = "SELECT * FROM t_Account where t_user_t_userID = $userID";
	$result = mysql_query($sql);
	if ($result)
	{
		while ($row = mysql_fetch_array($result)) 
		{

			$dataArray[$i]["AccountID"] = $row["t_AccountID"];
			$dataArray[$i]["AccountName"] = $row["t_AccountName"];
			$dataArray[$i]["AccountBalance"] = $row["t_AccountBalance"];
			$dataArray[$i]["AccountPhone"] = $row["t_AccountPhone"];
		}
	}
	$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
	echo json_encode($resultArray);
}

//19.全部订单
function user0rder($userID)
{
	$sql = "SELECT * FROM t_order WHERE t_userID = $userID";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0;
	if ($result) 
	{
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["orderNumber"] = $row["t_orderNumber"];
			$dataArray[$i]["orderAmount"] = $row["t_orderamount"];
			$dataArray[$i]["orderTime"] = $row["t_orderTime"];
			$dataArray[$i]["orderTotal"] = $row["t_orderTotal"];
			$thirdID = $row["t_shopthird_t_shopthirdID"];
			$sql1 = "SELECT * FROM t_shopthird WHERE t_shopthirdID = $thirdID";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$dataArray[$i]["goodsID"] = $row1["t_shopthirdID"];
					$dataArray[$i]["goodsName"] = $row1["t_shopthirdName"];
				}
			}
			$sql2 = "SELECT * FROM t_image WHERE t_shopthird_t_shopthirdID = $thirdID AND t_imageIsThumbnail = 1";
			$result2 = mysql_query($sql2);
			if ($result2) 
			{
				while ($row2 = mysql_fetch_array($result2)) 
				{
					$dataArray[$i]["goodsimageName"] = $row2["t_imageName"];
				}
			}
			$i++;
		}
		$resultArray = array('code' => 200,'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500,'msg' => "error");
		echo json_encode($resultArray);
	}
}

//20.评论页
function userComment($userID,$goodsID,$comment)
{
	$sql = "SELECT * from t_shopGoods WHERE t_shopGoodsID = $goodsID";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0 ;
	if ($result) 
	{		
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["goodsName"] = $row["t_shopGoodsName"];
			$dataArray[$i]["goodsPrice"] = $row["t_shopGoodsPrice"];
		}				
	}
	$sql1 = "SELECT * from t_order WHERE t_shopGoods_t_shopGoodsID = $goodsID";
	$result1 = mysql_query($result1);
	if ($result1) 
	{
		while ($row = mysql_fetch_array($result1)) 
		{
			$dataArray[$i]["buyTime"] = $row["t_orderTime"];
		}
	}	
}


//21.注册接口
function regist($t_userName,$t_userAge,$t_userSex,$t_userPassword,$t_Nickname,$t_userImage_t_userImageID)
{
	
	$sql = "INSERT INTO t_user(t_userName,t_userAge,t_userSex,t_userPassword,t_Nickname,t_userImage_t_userImageID) values ('$t_userName','$t_userAge','$t_userSex','$t_userPassword','$t_Nickname','$t_userImage_t_userImageID')";
	
	$result = mysql_query($sql);

	if ($result) {
		
		$resultArray = array('code' => 200, "msg" => 'success');
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}
//22.登陆接口
function login($t_userName,$t_userPassword)
{
	$sql = "SELECT * from t_user where t_userName = '$t_userName' and t_userPassword = '$t_userPassword'";
	$result = mysql_query($sql);
	if ($result) {	
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("userID","userName","userAge","userSex","Nickname");
			$value = array($row["t_userID"],$row["t_userName"],$row["t_userAge"],$row["t_userSex"],$row["t_Nickname"]);		
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		if (!empty($array)) 
		{
				$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
				echo json_encode($resultArray);
			}
			else
			{
				$resultArray = array('code' => 500, 'msg' => "error");
				echo json_encode($resultArray);
			}
		}
	
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
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["Nickname"] = $row["t_Nickname"];
			$dataArray[$i]["userSex"] = $row["t_userSex"];
			$image = $row["t_userImage_t_userImageID"];
			$sql1 = "SELECT * FROM t_userImage WHERE t_userImageID = $image ";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row = mysql_fetch_array($result1))
				{
					$dataArray[$i]["userImage"] = $row["t_userImageName"];
				}
			}
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}
}


//24.显示所有商品信息
function showShopGoods()
{
	
	$sql = "SELECT * from t_shopGoods";
	$result = mysql_query($sql);

	if ($result) {
		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("goodsID","goodsName","goodsPrice","goodsContent","t_t_shopCetegoryID","IsHot");
			$value = array($row["t_shopGoodsID"],$row["t_shopGoodsName"],$row["t_shopGoodsPrice"],$row["t_shopGoodscontent"],$row["t_shopCtegory_t_shopCategoryID"],$row["t_shopGoodsIsHot"]);
			
			$results = array_combine($key, $value);

			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		echo "error";
	}

}
//25.根据用户ID来查看所有收藏商品信息
function collection($userID)
{
	$sql = "SELECT * FROM t_shopCollection where t_user_t_userID = '$userID'";
	$result = mysql_query($sql);
	if ($result)
	{
		$array = array();
		$dataArray = array();
		$i = 0;
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["collect"] = $row["t_shopCollectionID"];
			$dataArray[$i]["goodsID"] = $row["t_shopGoods_t_shopGoodsID"];
			$goodsID = $row["t_shopGoods_t_shopGoodsID"];

			$sql1 = "SELECT * FROM  t_shopGoods WHERE t_shopGoodsID = '$goodsID'";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$dataArray[$i]["GoodsName"] = $row1["t_shopGoodsName"];
					$dataArray[$i]["GoodsPrice"] = $row1["t_shopGoodsPrice"];
			
				}
			}
			$i++;				
		}

		$resultArray1 = array('code' => 200,'msg' => "success" , 'list' =>$dataArray);
		echo json_encode($resultArray1);

	}
	else
	{
		echo "error";
	}
}
//26.查看通知消息
function showNotice()
{
	$sql = "SELECT * from t_Noticet";
	$result = mysql_query($sql);
	if ($result) {
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("NoticeID","NoticeName","NoticeContent","NoticeMoment","NoticeImage");
			$value = array($row["t_NoticetID"],$row["t_NoticetName"],$row["t_NoticetContent"],$row["t_NoticetMoment"],$row["t_NoticetImage"]);
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' =>200,"msg" =>'success','list' => $array);
		echo json_encode($resultArray);
	}
	else 
	{
		echo "error";
	}
}
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
		$resultArray = array('code' => 200,'msg' =>"success",'list' => $array);
		echo json_encode($resultArray);
	}else
	{
		echo "error";
	}
}
//28.插入反馈内容
function feedBack($feedbackCont,$feedbackPhone,$feedTypeID)
{
	$sql = "SELECT * FROM t_feedbackType where t_feedbackTypeID = $feedTypeID";
	$result = mysql_query($sql);
	if ($result) 
	{
		$array = array();
		while ($row = mysql_fetch_array($result)) 
		{
			$key = array("feedtypeName");
			$value = array($row["t_feedbackTypeName"]);
			$results = array_combine($key, $value);

			array_push($array, $results);
		}
	}
	$sql1 = "INSERT INTO t_shopFeedback(t_shopFeedbackContent,t_shopFeedbackPhone,t_feedbackType_t_feedbackTypeID)VALUES('$feedbackCont','$feedbackPhone','$feedTypeID')";
	$result1 = mysql_query($sql1);
	if ($result1) {
		$resultArray = array('code' => 200, "msg" => 'success','list' => $array);
	}
	else
	{
		$resultArray = array('code' => 500, "msg" => 'error');
	}
	echo json_encode($resultArray);
}



mysql_close($con)
?>
