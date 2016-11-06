function initMap() {

$.getJSON('http://210.146.64.140:4567/hotspot/long', function(json){
//alert(json[0].coordinates[0]);
var tweetCircle =[];
map = new google.maps.Map(document.getElementById('map_canvas'), {
center: {lat:34.694343,lng:135.194507},
zoom: 16
});



var hotCircle = new google.maps.Circle({
strokeColor: '#FF0000',
strokeOpacity: 0.8,
strokeWeight: 2,
fillColor: '#FF0000',
fillOpacity: 0.35,
map: map,
center: {lat:json[0].coordinates[0],lng:json[0].coordinates[1]},
radius: 60
});
    $.each(json,function(index,val){
        $.each(val.tweets,function(index,val){
            console.log(val);
            tweetCircle[index] = new google.maps.Marker({
                position: {lat:val.tweets_coordinates[0],lng:val.tweets_coordinates[1]},
                map: map
            });
        });
    });
});

}
