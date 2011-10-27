<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<g:javascript library="jquery" plugin="jquery"/>
<!-- Hoja de estilo y js para jquery-ui -->
<jqui:resources plugin="jquery-ui" themeCss="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/themes/overcast/jquery-ui.css" />

<!-- CSS Sheet  -->

<link rel="stylesheet" href="${resource(dir: 'themes/wb/css', file: 'style.css')}"/>

<!-- Lava Lamp Navigation  -->
<link rel="stylesheet" href="${resource(dir: 'themes/wb/css', file: 'lavalamp.css')}"/>

<!-- Hoja de estilo para el WYSIWYG  -->
<link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>

<script type="text/javascript" src="${resource(dir: 'themes/wb/js', file: 'jquery.easing.compatibility.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'themes/wb/js', file: 'jquery.lavalamp.min.js')}"></script>
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
<script type="text/javascript" src="${resource(dir: 'themes/wb/js', file: 'easySlider1.5.js')}"></script>
<script type="text/javascript">
  $(document).ready(function() {
    $("#slider").easySlider({
      auto: true,
      continuous: true
    });
  });
</script>

<!-- Script para el WYSIWYG -->
<script type="text/javascript" src="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.js"></script>
<!-- Aplicamos el wysiwyg a los textarea y button al menu -->
<script language="javascript">
  $(function(){
    $('textarea.wysiwyg').wysiwyg({
      controls:{
        html  : { visible: true }
      }
    });
    $("div.nav a").button();
  });
</script>
