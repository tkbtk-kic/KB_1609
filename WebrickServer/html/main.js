var map;

function jsonRead(){
  // JSONファイル読み込み開始
  $.ajax({
    //url:"http://210.146.64.140:4567/hotspot",
  url:"zantei.json",
    cache:false,
    dataType:"json",
    success:function(json){
      var data=jsonRequest(json);
            createMaker(data);

    }
  });
};

function jsonReadTweet(){
  // JSONファイル読み込み開始
  $.ajax({
    //url:"http://210.146.64.140:4567/hotspot",
  url:"zantei.json",
    cache:false,
    dataType:"json",
    success:function(json){
      var data=jsonRequest2(json);
            createTweetMaker(data);

    }
  });
};


// JSONファイル読み込み完了
function jsonRequest(json){ //hotspot情報リクエスト
  var data=[];
  if(json.Marker){
    var n=json.Marker.length; //長さ５
    for(var i=0;i<n;i++){
      //  data.push(json.Marker[4].Tweet[i]);??
      data.push(json.Marker[i]);  //マーカーのみtweet無し？
    }
  }
  return data;
}

function jsonRequest2(json){  //tweet情報リクエスト
  var data=[];
  if(json.Tweet){
    var n=json.Tweet.length;
    for(var i=0;i<n;i++){
      data.push(json.Tweet[i]);
    }
  }
  return data;
}


// マップを生成して、複数のマーカーを追加
function initialize(){
  var op={
    zoom:15,
    center:new google.maps.LatLng(34.694137, 135.193130),
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("map_canvas"),op);

}
function createMaker(data){
  var op={
    zoom:15,
    center:new google.maps.LatLng(34.694137, 135.193130),
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("map_canvas"),op);

  var i=data.length;
  while(i-- >0){
    var dat=data[i];
    var obj={
      position:new google.maps.LatLng(dat.lat,dat.lng),
      animation: google.maps.Animation.DROP,
      map:map
    };
    var marker=new google.maps.Marker(obj);
  }
  // Circleの初期設定
var circleOpts = {
  center: new google.maps.LatLng(34.694137, 135.193130),
  map: map,
  radius: 50
};
// 直前で作成したCircleOptionsを利用してCircleを作成
var circle = new google.maps.Circle(circleOpts);
}


function createTweetMaker(data){
  var op={
    zoom:15,
    center:new google.maps.LatLng(34.694137, 135.193130),
    mapTypeId:google.maps.MapTypeId.ROADMAP
  };
  var map=new google.maps.Map(document.getElementById("map_canvas"),op);

  var i=data.length;
  while(i-- >0){
    var dat=data[i];
    var obj={
      position:new google.maps.LatLng(dat.lat,dat.lng),
      animation: google.maps.Animation.DROP,
      map:map
    };
    var marker=new google.maps.Marker(obj);
  }
}
