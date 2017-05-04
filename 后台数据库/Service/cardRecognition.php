
<?php
//header('Content-type:text/html;charset=utf-8');


$action = $_POST['funId'];

switch ($action) {
	//名片识别接口
	case 'cardRecognition':
		$key = $_POST['AppKey'];
		$url = $_POST['AppUrl'];
		$imageName = $_POST['imageName'];
		cardRecognition($key,$url,$imageName);
		break;

	default:		
		# code...
		break;

}

//名片识别接口
function cardRecognition($key,$url,$imageName) {
	//$url = 'http://op.juhe.cn/hanvon/bcard/query';//名片识别api地址
	$params = array(
	    'image' => base64_encode(file_get_contents($imageName)),//将名片内容转为base64编码
	    'key' => $key //这里填写你申请到的appkey
	);
	$content = juhecurl($url,$params,1);

	$result = json_decode($content,true);

	if($result){
	    $error_code = $result['error_code'];
	    if($error_code == '0'){
	       // print_r($result['result']); //可以根据聚合官方的在线文档说明解析自己需要的字段内容
	    	$resultArray = array('code' => "200", 'msg' => "success",'list' => $result['result']);
			echo json_encode($resultArray);
	    }else{
	        echo "请求失败".$result['reason'];
	    }
	}else{
	    echo "请求错误";
	}
}
 
function juhecurl($url,$params=false,$ispost=0){
        $httpInfo = array();
        $ch = curl_init();
 
        curl_setopt( $ch, CURLOPT_HTTP_VERSION , CURL_HTTP_VERSION_1_1 );
        curl_setopt( $ch, CURLOPT_USERAGENT , 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36' );
        curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT , 30 );
        curl_setopt( $ch, CURLOPT_TIMEOUT , 30);
        curl_setopt( $ch, CURLOPT_RETURNTRANSFER , true );
        if( $ispost )
        {
            curl_setopt( $ch , CURLOPT_POST , true );
            curl_setopt( $ch , CURLOPT_POSTFIELDS , $params );
            curl_setopt( $ch , CURLOPT_URL , $url );
        }
        else
        {
            if($params){
                curl_setopt( $ch , CURLOPT_URL , $url.'?'.$params );
            }else{
                curl_setopt( $ch , CURLOPT_URL , $url);
            }
        }
        $response = curl_exec( $ch );
        if ($response === FALSE) {
            //echo "cURL Error: " . curl_error($ch);
            return false;
        }
        $httpCode = curl_getinfo( $ch , CURLINFO_HTTP_CODE );
        $httpInfo = array_merge( $httpInfo , curl_getinfo( $ch ) );
        curl_close( $ch );
        return $response;
        echo $response;
    }
   
?>