<?php
require "twitteroauth/autoload.php";
use Abraham\TwitterOAuth\TwitterOAuth;

$consumerKey = "uyrXf2COfXQNiyqfAwX21FwF9";
$consumerSecret ="gi8GfznUm3Kr4IuYKVORhX2G3wfVg2WDWBoHy6Bn3yNyLpmUuU";
$accessToken = "2497747381-XiSKaT51LSqimfwv9zGBYS30ypq0VTfUROOhAtl";
$accessTokenSecret ="Vx5kC2bXDvLVMUKpx8Sn4V1S3uue5hXVM5uDaPaz3aIoE";

$connection = new TwitterOAuth($consumerKey, $consumerSecret, $accessToken, $accessTokenSecret);
//var_dump($connection);

$tweets_params =["geocode" => "34.694343,135.194507,25km"];

$tweets = $connection->get('search/tweets', $tweets_params);
var_dump($tweets);
?>


