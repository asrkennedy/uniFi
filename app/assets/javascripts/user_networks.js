

$(function() {

  // adds and removes the password entry field from form as appropriate
  $( "#user_network_wifi_network_attributes_password_required" ).change(function() {
    if($( "#user_network_wifi_network_attributes_password_required").val() == "false"){
      $( "#password_input" ).fadeOut('slow');
      }else{
      $( "#password_input" ).fadeIn('slow');
      }
    })

  $("#user_network_user_sharing_pref").change(function(){
    switch($("#user_network_user_sharing_pref").val()){
      case "public":
        $("#sharing_warning").html("<p>Everyone will be able to see this network</p>");
        break;
      case "close friend":
        $("#sharing_warning").html("<p>Only close friends will be able to see this network</p>");
        break;
      case "friend":
        $("#sharing_warning").html("<p>Friends and close friends will be able to see this network</p>");
        break;
      case "acquaintance":
        $("#sharing_warning").html("<p>Acquaintances, friends and close friends will be able to see this network</p>");
        break;
      case "private":
        $("#sharing_warning").html("<p>Only you will be able to see this network</p>");
        break;
      }
     })





  });