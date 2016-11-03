<?php
require "twitteroauth/autoload.php";
use Abraham\TwitterOAuth\TwitterOAuth;

$connection = new TwitterOAuth($consumerKey, $consumerSecret, $accessToken, $accessTokenSecret);
//var_dump($connection);

$tweets_params =["geocode" => "34.694343,135.194507,25km"];

$tweets = $connection->get('search/tweets', $tweets_params);
var_dump($tweets);
?>


