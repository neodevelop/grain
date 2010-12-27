<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<g:javascript library="jquery" plugin="jquery"/>
<jqval:resources/>
<jqvalui:resources />


<!-- CSS Sheet  -->

<link rel="stylesheet" href="${createLinkTo(dir: 'themes/wb/css', file: 'style.css')}"/>

<!-- Lava Lamp Navigation  -->
<link rel="stylesheet" href="${createLinkTo(dir: 'themes/wb/css', file: 'lavalamp.css')}"/>

<script type="text/javascript" src="${createLinkTo(dir: 'themes/wb/js', file: 'jquery.easing.min.js')}"></script>
<script type="text/javascript" src="${createLinkTo(dir: 'themes/wb/js', file: 'jquery.lavalamp.min.js')}"></script>
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
<script type="text/javascript" src="${createLinkTo(dir: 'themes/wb/js', file: 'easySlider1.5.js')}"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $("#slider").easySlider({
      auto: true,
      continuous: true
    });
  });
</script>