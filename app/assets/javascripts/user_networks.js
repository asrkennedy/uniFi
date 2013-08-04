

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

// create a google map
  var mapOptions = {
    zoom:6,
    center: new google.maps.LatLng(51.512769700000000000,-0.128924099999949250),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var infowindow = new google.maps.InfoWindow({
          content: ""
        });

  // now get the networks



  });