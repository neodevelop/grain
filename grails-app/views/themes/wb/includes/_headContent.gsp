<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- CSS Sheet  --> 

<link rel="stylesheet" href="${createLinkTo(dir:'themes/wb/css',file:'style.css')}" />

<!-- Lava Lamp Navigation  -->
<link rel="stylesheet" href="${createLinkTo(dir:'themes/wb/css',file:'lavalamp.css')}" />
<script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js',file:'jquery.js')}"></script>
<script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js',file:'jquery-1.2.3.min.js')}"></script>

<%--
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>
--%>

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