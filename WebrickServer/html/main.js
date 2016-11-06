var map;

function jsonRead(){
  // JSONファイル読み込み開始
  $.ajax({
  url:"http://210.146.64.140:4567/hotspot", /* APIと通信 */
  url:"test.json",
    cache:false,
    dataType:"json",
    success:function(json){
      var data=jsonRequest(json);
            createMap_hostspot(data);

    }
  });
};

// JSONファイル読み込み
function jsonRequest(json){ //hotspot情報リクエスト
  var data=[];
  if(json.Marker){
    var n=json.Marker.length;
    for(var i=0;i<n;i++){
      data.push(json.Marker[i]);
    }
  }
  return data;
}

function jsonRequestTweet(json){  //tweet情報リクエスト
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

function createMap_hostspot(data){
  var op={
    zoom:16,
    center:new google.maps.LatLng(34.694106, 135.196619),
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
    // Circleのオプション
  var circleOpts = {
    center: new google.maps.LatLng(dat.lat,dat.lng),
    map: map,
    radius: 90
  };
  // Circleを作成
  var circle = new google.maps.Circle(circleOpts);
  }
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
