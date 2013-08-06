 var markersArray = [];
 var latLngList = [];

 var bounds = new google.maps.LatLngBounds();




$(function() {

  // adds and removes the password entry field from form as appropriate
  $( "#user_network_wifi_network_attributes_password_required" ).change(function() {
    if($( "#user_network_wifi_network_attributes_password_required").val() == "false"){
      $( "#password_input" ).fadeTo(200, 0);
      }else{
      $( "#password_input" ).fadeTo(200, 1);
      }
    })

  // controls the fade in/out of the sharing warning on the new user networks page
  $("#user_network_user_sharing_pref").change(function(){
    switch($("#user_network_user_sharing_pref").val()){
      case "public":
        $("#sharing_warning").fadeTo(200, 0);
        setTimeout(function(){
          $("#sharing_warning").html("<p>All Uni-Fi users will be able to see this network, but they won't who shared it</p>");
        }, 200);
        $("#sharing_warning").fadeTo(200, 1);
        break;
      case "close friend":
        $("#sharing_warning").fadeTo(200, 0);
        setTimeout(function(){
          $("#sharing_warning").html("<p>Only close friends will be able to see this network, and they will know you shared it</p>");
        }, 200);
        $("#sharing_warning").fadeTo(200, 1);
        break;
      case "friend":
        $("#sharing_warning").fadeTo(200, 0);
        setTimeout(function(){
          $("#sharing_warning").html("<p>Friends and close friends will be able to see this network,  and they will know you shared it</p>");
        }, 200);
        $("#sharing_warning").fadeTo(200, 1);
        break;
      case "acquaintance":
        $("#sharing_warning").fadeTo(200, 0);
        setTimeout(function(){
          $("#sharing_warning").html("<p>Acquaintances, friends and close friends will be able to see this network,  and they will know you shared it</p>");
        }, 200);
        $("#sharing_warning").fadeTo(200, 1);
        break;
      case "private":
        $("#sharing_warning").fadeTo(200, 0);
        setTimeout(function(){
          $("#sharing_warning").html("<p>Only you will be able to see this network</p>");
        }, 200);
        $("#sharing_warning").fadeTo(200, 1);
        break;
      }
     })

// create a google map + With Control Positions for Map only not streetview Will be adding styling element here aswell later
  var mapOptions = {
    zoom:6,

    // mapTypeControlOptions: {
    //     style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
    //     position: google.maps.ControlPosition.TOP_CENTER
    // },
    // panControl: true,
    // panControlOptions: {
    //     position: google.maps.ControlPosition.TOP_RIGHT
    // },
    // zoomControl: true,
    // zoomControlOptions: {
    //     style: google.maps.ZoomControlStyle.LARGE,
    //     position: google.maps.ControlPosition.RIGHT_CENTER
    // },
    // scaleControl: true,
    // scaleControlOptions: {
    //     position: google.maps.ControlPosition.TOP_RIGHT
    // },
    // streetViewControl: true,
    // streetViewControlOptions: {
    //     position: google.maps.ControlPosition.RIGHT_TOP
    //   },
    disableDefaultUI: true,
    center: new google.maps.LatLng(51.512769700000000000,-0.128924099999949250),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    styles: [
              {
                "featureType": "water",
                "stylers": [
                  { "visibility": "on" },
                  { "color": "#1385eb" }
                ]
              },{
                "featureType": "road.local",
                "elementType": "geometry.stroke",
                "stylers": [
                  { "visibility": "on" },
                  { "color": "#000000" },
                  { "weight": 0.7 }
                ]
              },{
                "featureType": "road.highway",
                "stylers": [
                  { "visibility": "off" }
                ]
              },{
                "featureType": "road.arterial",
                "stylers": [
                  { "color": "#f6003c" },
                  { "visibility": "simplified" },
                  { "weight": 2.5 }
                ]
              },{
                "featureType": "landscape",
                "elementType": "labels.icon",
                "stylers": [
                  { "color": "#808080" },
                  { "visibility": "simplified" }
                ]
              },{
                "featureType": "transit",
                "stylers": [
                  { "visibility": "simplified" },
                  { "invert_lightness": true },
                  { "lightness": 50 },
                  { "color": "#ebfa5e" }
                ]
              },{
                "featureType": "poi.park",
                "stylers": [
                  { "visibility": "simplified" },
                  { "color": "#20d6ae" }
                ]
              },{
                "featureType": "poi",
                "stylers": [
                  { "visibility": "simplified" }
                ]
              },{
                "featureType": "landscape.man_made",
                "stylers": [
                  { "visibility": "simplified" },
                  { "color": "#bec1bc" }
                ]
              }
            ]

  };

  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  //create the info window to populate on clicking a marker
  var infowindow = new google.maps.InfoWindow({
          content: ""
        });

  var resizeMap = function(){
    for(var i = 0; i <latLngList.length ; i++){
      bounds.extend(latLngList[i])
    }
    map.fitBounds(bounds);
    latLngList = [];
    bounds = new google.maps.LatLngBounds();
    setTimeout(function(){google.maps.event.trigger(map, 'resize')},2000);

  } // closes resizemap


var drawMarkers = function(e) {
  if (typeof e !== "undefined") {
     e.preventDefault();
  }

  for (var i = 0; i < markersArray.length; i++ ) {
    markersArray[i].setMap(null);
  }




  function toggleBounce(marker) {
      marker.setAnimation(google.maps.Animation.BOUNCE);
      setTimeout(function(){
            marker.setAnimation(null)
          }, 5000);
    }

    // get the public networks
    $.getJSON('/user_networks.json', {"postcode": $('#postcode').val(), "distance":$('#distance').val()},  function(data){
      var currentUser = data.current_user_boolean;
      // get the public networks
      var networks_array = data.public_networks;
      for(var i = 0; i < networks_array.length; i++){
        var marker = new google.maps.Marker({
          position: new google.maps.LatLng(networks_array[i].latitude, networks_array[i].longitude),
          map: map,
          title: 'Public Network [SSID: ' + networks_array[i].ssid + ', Password: ' + networks_array[i].password + ']',
          wifi_network_id: networks_array[i].wifi_network_id,
          ssid: networks_array[i].ssid,
          password: networks_array[i].password,
          password_required: networks_array[i].password_required,
          address: networks_array[i].address,
          longitude: networks_array[i].longitude,
          latitude: networks_array[i].latitude,
          average_user_rating: networks_array[i].average_user_rating,
          updated_at: networks_array[i].updated_at,
          // animation: google.maps.Animation.DROP
        })//closes google maps marker


        markersArray.push(marker);
        latLngList.push(marker.position);

        marker.setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
        //create an event to happen on clicking each marker
        google.maps.event.addListener(marker, 'click', function() {
         //content string
          infowindow.content = '<div id="content">' +
            '<a href="/wifi_networks/' + this.wifi_network_id +'">' +
            '<h4>Public Network [SSID: ' + this.ssid + ', Password: ' + this.password + ']</h4></a>' +
            '<img src="http://maps.googleapis.com/maps/api/streetview?size=450x250&location=' + this.latitude + ',' + this.longitude + '&heading=151.78&pitch=-0.76&sensor=false">' +
            '<ul>' +
            '<li>Address: ' + this.address + '</li>' +
            '<li>Average Uni-Fi user rating: ' + this.average_user_rating + ' out of 5</li>' +
            '</ul>' +
            '</div>';
          //finally, define what happens when we click the marker

          if(currentUser){
            infowindow.open(map, this);
          };

          toggleBounce(this);
        });  //closes the google maps listener event
      } //closes for loop

      // now get the user's networks
    var users_networks_array = data.users_networks
    for(var i = 0; i < users_networks_array.length; i++){
      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(users_networks_array[i].latitude, users_networks_array[i].longitude),
        map: map,
        title: users_networks_array[i].nickname +' [SSID: ' + users_networks_array[i].ssid + ', Password: ' + users_networks_array[i].password + ']',
        id: parseInt(users_networks_array[i].id),
        nickname: users_networks_array[i].nickname,
        user_score: users_networks_array[i].user_score,
        user_sharing_pref: users_networks_array[i].user_sharing_pref,
        user_name: users_networks_array[i].user_name,
        wifi_network_id: users_networks_array[i].wifi_network_id,
        ssid: users_networks_array[i].ssid,
        password: users_networks_array[i].password,
        password_required: users_networks_array[i].password_required,
        address: users_networks_array[i].address,
        longitude: users_networks_array[i].longitude,
        latitude: users_networks_array[i].latitude,
        average_user_rating: users_networks_array[i].average_user_rating,
        updated_at: users_networks_array[i].updated_at,
        // animation: google.maps.Animation.DROP
      })//closes google maps marker

      markersArray.push(marker);
      latLngList.push(marker.position);

      //create an event to happen on clicking each marker
      google.maps.event.addListener(marker, 'click', function() {
        //content string
        infowindow.content = '<div id="content">' +
          '<a href="/user_networks/' + this.id +'">' +
          '<h4>' + this.nickname + ' [SSID: ' + this.ssid + ', Password: ' + this.password + ']</h4></a>' +
          '<img src="http://maps.googleapis.com/maps/api/streetview?size=450x250&location=' + this.latitude + ',' + this.longitude + '&heading=151.78&pitch=-0.76&sensor=false">' +
          '<ul>' +
          '<li>Address: ' + this.address + '</li>' +
          '<li>Your rating: ' + this.user_score + ' out of 5 (average Uni-Fi user rating: ' + this.average_user_rating + ')</li>' +
          '<li>Sharing level: ' + this.user_sharing_pref + '</li>' +
          '</ul>' +
          '</div>';
        //finally, define what happens when we click the marker
        infowindow.open(map, this);
         toggleBounce(this);
      });  //closes the google maps listener event
    } //closes for loop

    // now get the user's friend's networks
    var networks_array = data.users_friends_networks
    for(var i = 0; i < networks_array.length; i++){
      var marker = new google.maps.Marker({
        position: new google.maps.LatLng(networks_array[i].latitude, networks_array[i].longitude),
        map: map,
        title: 'Shared Network [SSID: ' + networks_array[i].ssid + ', Password: ' + networks_array[i].password + ']',
        wifi_network_id: networks_array[i].wifi_network_id,
        ssid: networks_array[i].ssid,
        password: networks_array[i].password,
        password_required: networks_array[i].password_required,
        address: networks_array[i].address,
        longitude: networks_array[i].longitude,
        latitude: networks_array[i].latitude,
        average_user_rating: networks_array[i].average_user_rating,
        updated_at: networks_array[i].updated_at,
        shared_by: networks_array[i].shared_by,
        // animation: google.maps.Animation.DROP
      })//closes google maps marker

      markersArray.push(marker);
      latLngList.push(marker.position);

      marker.setIcon('http://maps.google.com/mapfiles/ms/icons/blue-dot.png');
      //create an event to happen on clicking each marker



       google.maps.event.addListener(marker, 'click', function() {
        //content string
        infowindow.content = '<div id="content">' +
          '<a href="/wifi_networks/' + this.wifi_network_id +'">' +
          '<h4>Shared Network [SSID: ' + this.ssid + ', Password: ' + this.password + ']</h4></a>' +
          '<img src="http://maps.googleapis.com/maps/api/streetview?size=450x250&location=' + this.latitude + ',' + this.longitude + '&heading=151.78&pitch=-0.76&sensor=false" id="streetviewstatic">' +
          '<ul>' +
          '<li>Address: ' + this.address + '</li>' +
          '<li>Average Uni-Fi user rating: ' + this.average_user_rating + ' out of 5</li>' +
          '<li>Shared by: ' + this.shared_by + '</li>' +
          '</ul>' +
          '</div>';
        //finally, define what happens when we click the marker
        infowindow.open(map, this);
         toggleBounce(this);

      });  //closes the google maps listener events


        google.maps.event.addListener(map, "click", function(){
            infowindow.close();
        });
    }; //closes for loop




  resizeMap();
  }) // closes getJSON

}


  drawMarkers();




  $('#submit').on('click', drawMarkers);



}); // closes document ready