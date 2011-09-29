<div id="map_canvas" style="width:${width}px; height:${height}px"></div>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
<script type="text/javascript">

  var courseGeolocation = "${courseGeolocation}";
  var meGeolocation = "${meGeolocation}";
  var initialLocation;

  var browserSupportFlag =  new Boolean();
  var map;

  function initialize() {
    var myOptions = {
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    var currentLatLng = courseGeolocation.split( "," );
    initialLocation = new google.maps.LatLng(currentLatLng[0],currentLatLng[1]);
    map.setCenter(initialLocation);

    var marker1 = new google.maps.Marker({
      position: initialLocation,
      map: map,
      draggable:false,
      icon:'${resource(dir:'themes/wb/icon',file:'university.png')}'
    });

    var metLatLng = meGeolocation.split( "," );
    var meLocation = new google.maps.LatLng(metLatLng[0],metLatLng[1]);
    var marker2 = new google.maps.Marker({
      position: meLocation,
      map: map,
      draggable:false,
      icon:'${resource(dir:'themes/wb/icon',file:'home.png')}'
    });

  }

  initialize();
</script>
