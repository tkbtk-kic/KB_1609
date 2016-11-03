<?php
require "twitteroauth/autoload.php";
use Abraham\TwitterOAuth\TwitterOAuth;

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

$connection = new TwitterOAuth($consumerKey, $consumerSecret, $accessToken, $accessTokenSecret);
var_dump($connection);

$tweets_params =["geocode" => "34.694343,135.194507,25km"];

$tweets = $connection->get('search/tweets', $tweets_params);
var_dump($tweets);
?>


