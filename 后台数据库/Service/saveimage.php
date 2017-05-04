<?php
header("Content-type:text/html;charset=utf-8");
// print_r($_FILES['header']);

$filename = $_FILES['header']['name'];
if(!$_FILES['header']['error']){

   if(move_uploaded_file($_FILES['header']['tmp_name'],$filename))
   {
  
  //$_FILES['header']['tmp_name']="/Applications/MAMP/tmp/php/phpplgGE9"
    // echo "文件上传成功";
    echo json_encode(array("code"=>"200","path"=>$filename));
  
  }
  else{
    echo json_encode(array("code"=>"300","data"=>$_FILES['file'],"name"=>$filename));
  }


}
else{

   echo json_encode(array("code"=>"400","data"=>$_FILES['file']));
}


 ?>