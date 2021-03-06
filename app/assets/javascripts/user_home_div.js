$(function(){

var drawBox = function(){

setTimeout(function(){


  var sign_inLink = false;
  var link_sign_in_text = "Sign In";
  var sign_in_link_x = 50;
  var sign_in_link_y = 290;
  var sign_in_linkWidth;
  var sign_in_linkHeight = 20;

  var sign_upLink = false;
  var link_sign_up_text = "Sign Up";
  var sign_up_link_x = 210;
  var sign_up_link_y = 290;
  var sign_up_linkWidth;
  var sign_up_linkHeight = 20;

if ($('#overlay').length != 0) {
  function on_mousemove (ev) {
    var s_i_x, s_i_y;
    var rect = canvas.getBoundingClientRect();
    s_i_x = ev.clientX - rect.left;
    s_i_y = ev.clientY - rect.top;

    var s_u_x, s_u_y;
    var rect = canvas.getBoundingClientRect();
    s_u_x = ev.clientX - rect.left;
    s_u_y = ev.clientY - rect.top;

    //is the mouse over the link?
    if( (s_i_x>=sign_in_link_x) && (s_i_x <= (sign_in_link_x + sign_in_linkWidth) ) &&
       (s_i_y<=sign_in_link_y) && (s_i_y>= (sign_in_link_y-sign_in_linkHeight) )){
        console.log("in condition")
        document.body.style.cursor = "pointer";
        sign_inLink=true;
    }
    else if ( (s_u_x>=sign_up_link_x) && (s_u_x <= (sign_up_link_x + sign_up_linkWidth) ) &&
       (s_u_y<=sign_up_link_y) && (s_u_y>= (sign_up_link_y-sign_up_linkHeight) )){
        console.log("in condition")
        document.body.style.cursor = "pointer";
        sign_upLink=true;
    }
    else {
        document.body.style.cursor = "";
        sign_inLink=false;
    }
    console.log(s_i_x, s_i_y)
  }


  function on_click(){
      if(sign_inLink){
        document.location.href= "/users/sign_in"
      } else if (sign_upLink) {
        document.location.href= "/users/sign_up"
      }
  }

  // Get a handle to our canvas
  var canvas =document.getElementById('overlay')
  var ctx = canvas.getContext("2d");

  // Choose font

  ctx.font = "Bold 24px 'TrendSansFive' ";

  var grd = ctx.createLinearGradient(0, 0, canvas.width, canvas.height);
      // light blue
      grd.addColorStop(0, 'rgba(255, 255, 255, 0.8)');
      // dark blue
      grd.addColorStop(1, 'rgba(255, 255, 255, 0.8)');
      ctx.fillStyle = grd;
      ctx.fill();
      // Draw rectangle
      ctx.fillRect(0,0,500,500);

  // Punch out the text!
  ctx.globalCompositeOperation = 'destination-out';
  ctx.fillText("________________", 30, 30);
  ctx.fillText("Welcome to Unifi", 40, 80);
  ctx.fillText("________________", 30, 120);
  ctx.fillText(link_sign_in_text, 50, 290);
  sign_in_linkWidth=ctx.measureText(link_sign_in_text).width;
  ctx.fillText(link_sign_up_text, 210, 290);
  sign_up_linkWidth=ctx.measureText(link_sign_up_text).width;


  canvas.addEventListener('mousemove', on_mousemove, false)
  canvas.addEventListener('click', on_click, false)

  $('#overlay').css('box-shadow', '10px 15px 15px #333')
}
}, 1000);
}

drawBox();

})