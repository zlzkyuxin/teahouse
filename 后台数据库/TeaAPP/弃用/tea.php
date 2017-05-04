<?php
$con = mysql_connect("localhost","yuxin","123456");
mysql_query("SET NAMES utf8");


mysql_select_db("teahouse")or die("error!");
$action = $_POST['key'];
switch ($action) {
	//1.茶的首页
	case 'showTeaHome':
		showTeaHome();
		break;
	//2.茶历史介绍接口
	case 'showteaHistory':
		showteaHistory();
		break;
	//3.茶艺介绍接口
	case 'teaCeremony':
		teaCeremony();
		break;
	//3.具体的茶的信息展示接口
	case 'showTea':
		showTea();
		break;
	//5.茶具的展示接口
	case 'showTeaAppliances':
		showTeaAppliances();
		break;
	default:		
		# code...
		break;
}
//1.茶的首页
function showTeaHome()
{
	$sql = "SELECT * FROM t_teaScroller";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("ScrollerID","ScrollerImage");
			$value = array($row["t_teaScrollerID"],$row["t_teaScrollerImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}
//2.茶历史介绍接口
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
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}
//3.茶艺展示接口
function teaCeremony()
{
	$sql = "SELECT * FROM  t_teaCeremony";
	$result = mysql_query($sql);
	if ($result) {		
		$array = array();
		while ($row = mysql_fetch_array($result)) {
			$key = array("teaCeremonyID","teaCeremonyName","teaCIntroduction","teaCeremonyImage");
			$value = array($row["t_teaCeremonyID"],$row["t_teaCeremonyName"],$row["t_teaCIntroduction"],$row["t_teaCeremonyImage"]);			
			$results = array_combine($key, $value);
			array_push($array, $results);
		}
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $array);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}
//4.具体的茶的信息展示接口
function showTea()
{
	$sql = "SELECT * FROM  t_teaType";
	$result = mysql_query($sql);
	if ($result) 
	{		
		$array = array();
		$dataArray = array();
		$i = 0;
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["teaTypeID"] = $row["t_teaTypeID"];
			$dataArray[$i]["teaTypeName"] = $row["t_teaTypeName"];
			$typeID = $row["t_teaTypeID"];	
			$sql1 = "SELECT * FROM  t_tea where t_teaType_t_teaTypeID = $typeID";
			$result1 = mysql_query($sql1);
			$teaArray = array();
			$j = 0;
			if ($result1) 
			{		
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$teaArray[$j]["teaID"] = $row1["t_teaID"];
					$teaArray[$j]["teaName"] = $row1["t_teaName"];
					$teaArray[$j]["teaImage"] = $row1["t_teaImage"];
					$j++;
				}
				$dataArray[$i]["tea"] = $teaArray;
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


//5.茶具的信息展示接口
function showTeaAppliances()
{
	
	$sql = "SELECT * FROM t_teaAppliancesType";
	$result = mysql_query($sql);
	$dataArray = array();
	$i = 0;
	
	if ($result) 
	{		
		while ($row = mysql_fetch_array($result)) 
		{
			$dataArray[$i]["teaAppTypeID"] = $row["t_teaAppliancesTypeID"];
			$dataArray[$i]["teaAppTypeName"] = $row["t_teaAppTName"];
			$apID = $row["t_teaAppliancesTypeID"];
			$sql1 = "SELECT * FROM  t_teaAppliances where t_teaAppliancesType_t_teaAppliancesTypeID = $apID";
			$result1 = mysql_query($sql1);
			if ($result1) 
			{		
				$array1 = array();
				while ($row1 = mysql_fetch_array($result1)) 
				{
					$key = array("AppliancesID","AppliancesName","AppliancesImage");
					$value = array($row1["t_teaAppliancesID"],$row1["t_teaAppliancesName"],$row1["t_teaAppImage"]);
					// $dataArray[$j]["AppliancesID"] = $row1["t_teaAppliancesID"];
					// $dataArray[$j]["AppliancesName"] = $row1["t_teaAppliancesName"];
					// $dataArray[$j]["AppliancesImage"] = $row1["t_teaAppImage"];	
					$results1 = array_combine($key, $value);
					array_push($array1,$results1);				
				}

				$dataArray[$i]["teaAppliances"] = $array1;
			}
			
			$i++;
		}
		// $array2 = array('teaAppliancesType' => $dataArray);
		$resultArray = array('code' => 200, 'msg' => "success",'list' => $dataArray);
		echo json_encode($resultArray);
	}
	else
	{
		$resultArray = array('code' => 500, 'msg' => "error");
		echo json_encode($resultArray);
	}
}

mysql_close($con)
?>