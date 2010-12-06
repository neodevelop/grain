<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- CSS Sheet  --> 

<link rel="stylesheet" href="${createLinkTo(dir:'themes/wb/css',file:'style.css')}" />

<!-- Lava Lamp Navigation  -->
<link rel="stylesheet" href="${createLinkTo(dir:'themes/wb/css',file:'lavalamp.css')}" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>

<script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js',file:'jquery.easing.min.js')}"></script>
<script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js',file:'jquery.lavalamp.min.js')}"></script>
    <script type="text/javascript">
        $(function() {
            $("#1, #2, #3").lavaLamp({
                fx: "backout",
                speed: 800,
                click: function(event, menuItem) {
                    return true;
                }
            });
        });
    </script>
    
<!-- Sliding Gallery Navigation  -->
	<script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js',file:'easySlider1.5.js')}"></script>
	<script type="text/javascript">
		$(document).ready(function(){	
			$("#slider").easySlider({
				auto: true,
				continuous: true 
			});
		});	
	</script>
    
    
</head>

<body>
<div id="container">
<div id="wrapper">
  <!-- Begin Top Bar  -->
<div id="topbar">

  <!-- Begin LavaLamp Navigation  -->
  <div id="nav"><ul class="lavaLampWithImage" id="1">
        <li class="current"><a href="index.html">Home</a></li>
        <li><a href="about.html">About</a></li>
        <li><a href="services.html">Services</a></li>
        <li><a href="events.html">Events</a></li>
        <li><a href="contacts.html">Contacts</a></li>
      </ul>
  </div>
  <!-- End LavaLamp Navigation  -->
  
</div>
<!-- End Top Bar  -->

<!-- Begin Header  -->
<div id="header"><div id="slider">
			<ul>				
				<li><a href="#"><img src="${createLinkTo(dir:'themes/wb/images',file:'header1.jpg')}" alt="" border="0" /></a></li>
				<li><a href="#"><img src="${createLinkTo(dir:'themes/wb/images',file:'header2.jpg')}" alt="" border="0" /></a></li>
			  <li><a href="#"><img src="${createLinkTo(dir:'themes/wb/images',file:'header3.jpg')}" alt="" border="0" /></a></li>	
			</ul>
  </div></div>
<!-- End Header  -->

<!-- Begin Icon Bar  -->
<div id="iconbar">
  <div class="iconbox">
    <img src="${createLinkTo(dir:'themes/wb/images',file:'icon1.png')}" alt="" width="48" height="47" class="leftimage" /><h1>Business</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>
 
   <div class="iconbox">
    <img src="${createLinkTo(dir:'themes/wb/images',file:'icon2.png')}" alt="" width="39" height="47" class="leftimage" />
    <h1>Security</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>
    
      <div class="iconbox">
    <img src="${createLinkTo(dir:'themes/wb/images',file:'icon3.png')}" alt="" width="43" height="47" class="leftimage" />
    <h1>License</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>
    
      <div class="iconbox">
    <img src="${createLinkTo(dir:'themes/wb/images',file:'icon4.png')}" alt="" width="46" height="47" class="leftimage" />
    <h1>Support</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></div>
</div>
<!-- End Icon Bar  -->

<!-- Begin Content  -->
<div id="content">
  <div id="welcome">
    <h2>Welcome to Buzto Comp</h2>
    <h3>The leader in corporate business world</h3>
    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdie. doming id quod. mazim placerat facer possim assum vel eum iriure dolor in hendrerit in vulputate velit esse molestie cons.<br />
      <br />
Equat, vel illum dolore eu feugiat nulla facilisis at vero autem vel eum iriure dolor in hendrerit in vulputate. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent. </p>
    <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdie. doming id quod. mazim placerat facer possim assum vel eum iriure dolor in hendrerit in vulputate velit esse molestie cons.</p>
  </div>
  <div id="latestnews">
    <h1>Latest News</h1><h4>What’s happening with us</h4>
    <p><img src="${createLinkTo(dir:'themes/wb/images',file:'pic01.gif')}" alt="" width="67" height="67" vspace="5" class="leftimage" /><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"> <a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></p>
    <p><img src="${createLinkTo(dir:'themes/wb/images',file:'pic02.gif')}" alt="" width="67" height="67" vspace="5" class="leftimage" /><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"> <a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></p>
    <p><img src="${createLinkTo(dir:'themes/wb/images',file:'pic08.jpg')}" alt="" width="67" height="67" vspace="5" class="leftimage" /><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"> <a href="#">More</a></span><img src="${createLinkTo(dir:'themes/wb/images',file:'arrow.png')}" width="11" height="10" alt="" /></p>
  </div>
</div>
<!-- End Content  -->
</div>
</div>

<!-- Begin Footer1  -->
<div id="footer1">
  <div id="footer1content">
    <div id="corporateinfo"><div style="width:60px; float:left;"><img src="${createLinkTo(dir:'themes/wb/images',file:'icon5.png')}" width="48" height="50" alt="" /></div>
    <div style="width:220px; float:left;"><h5>Corporate Info</h5>
    Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril.</div></div>
    <div id="recentnews">
      <div style="width:60px; float:left;"><img src="${createLinkTo(dir:'themes/wb/images',file:'icon5_.png')}" width="49" height="50" alt="" /></div>
    <div style="width:220px; float:left;">
      <h5>Recent News</h5>
    • <a href="#">Autem vel eum iriure dolor in henderit</a><br />
    • <a href="#">Vel illum dolore eu feugiat nula</a><br />
    •  <a href="#">Facilisis at vero eros et accumsan et</a><br />
    •  <a href="#">Lusto odio dignissim qui blandit</a><br />
    •     <a href="#">Praesent luptatum zzril in vulputate</a><br />
    • <a href="#">Velit esse molestie consequat.</a></div></div>
    <div id="connect">
      <h5>Connect With Us</h5>
      <br /><img src="${createLinkTo(dir:'themes/wb/images',file:'icon6.png')}" alt="" width="39" height="49" class="leftimage" /><img src="${createLinkTo(dir:'themes/wb/images',file:'icon7.png')}" alt="" width="46" height="49" class="leftimage" /><img src="${createLinkTo(dir:'themes/wb/images',file:'icon8.png')}" alt="" width="52" height="49" class="leftimage" /><img src="${createLinkTo(dir:'themes/wb/images',file:'icon9.png')}" alt="" width="34" height="49" class="leftimage" /> </div>
  </div>
</div>
<!-- End Footer1  -->

<!-- Begin Footer2  -->
<div id="footer2">
  <div id="footer2content">
    <div style="width:300px; float:left;">© Copyright Buzto Comp. All Rights Reserved </div><div style="width:400px; float:right; text-align: right;">•  <a href="index.html">Home</a> •  <a href="about.html">About</a> •  <a href="services.html">Services</a> •  <a href="events.html">Events</a> •  <a href="contacts.html">Contacts</a></div></div>
</div>
<!-- End Footer2  -->
</body>
</html>
