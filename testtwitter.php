<?php
//require "twitteroauth/autoload.php";
require "TwistOAuth/build/TwistOAuth.phar";
//use Abraham\TwitterOAuth\TwitterOAuth;

$jsonUrl = "Twitterkey.json"; //JSONファイルの場所とファイル名を記述
if(file_exists($jsonUrl)){
  $json = file_get_contents($jsonUrl);
  $json = mb_convert_encoding($json, 'UTF8', 'ASCII,JIS,UTF-8,EUC-JP,SJIS-WIN');
  $obj = json_decode($json,true);
  //var_dump($obj);
  $consumerKey = $obj["CONSUMERKEY"];
  $consumerSecret = $obj["CONSUMERSECRET"];
  $accessToken = $obj["ACCESSTOKEN"];
  $accessTokenSecret = $obj["ACCESSTOKENSECRET"];
}

//var_dump($consumerKey);

$connection = new TwistOAuth($consumerKey, $consumerSecret, $accessToken, $accessTokenSecret);
//var_dump($connection);

$tweets_params =["rpp"=>"90", "geocode" => "34.694343,135.194507,1km"];

while(1){

$tweets = $connection->get('search/tweets', $tweets_params);
// この時点で$tweetsはオブジェクト型らしい
//var_dump($tweets);
$arr = json_encode($tweets);
//file_put_contents("geosearch.json" , $arr);

$url = 'http://localhost:4567/edit';
$headers = ['Content-type: application/json'];

$curl = curl_init($url);
curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
curl_setopt($curl, CURLOPT_POSTFIELDS, $arr);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($curl);
curl_close($curl);


sleep(480);

}


//echo $response, PHP_EOL;

//$post=[];
//foreach($tweets as $key => $value){
//    if($key == "statuses"){
//        $i=0;
//        print ("status");
//        foreach($value as $key => $value){
//            var_dump($value);
//            foreach($value as $key => $value){
//                var_dump($key);
//            }
//        }
//    }
//    var_dump($key);
//    var_dump($value);
//}

?>


