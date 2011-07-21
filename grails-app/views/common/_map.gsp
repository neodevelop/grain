<div id="map_canvas" style="width:${width}px; height:${height}px"></div>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=true"></script>
<script type="text/javascript" src="http://code.google.com/apis/gears/gears_init.js"></script>
<script type="text/javascript">

  var alreadyLocation = $("#${refField}").val();
  var initialLocation;
  var siberia = new google.maps.LatLng(60, 105);
  var newyork = new google.maps.LatLng(40.69847032728747, -73.9514422416687);
  var browserSupportFlag =  new Boolean();
  var map;

  function initialize() {
    var myOptions = {
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    if(alreadyLocation){
      var currentLatLng = alreadyLocation.split( "," );
      initialLocation = new google.maps.LatLng(currentLatLng[0],currentLatLng[1]);
      map.setCenter(initialLocation);
      putMarker();
    }else{
      if(navigator.geolocation) {
      browserSupportFlag = true;
      navigator.geolocation.getCurrentPosition(function(position) {
        initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
        map.setCenter(initialLocation);
        putMarker();
      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
    } else if (google.gears) {
      browserSupportFlag = true;
      var geo = google.gears.factory.create('beta.geolocation');
      geo.getCurrentPosition(function(position) {
        initialLocation = new google.maps.LatLng(position.latitude,position.longitude);
        map.setCenter(initialLocation);
        putMarker();
      }, function() {
        handleNoGeolocation(browserSupportFlag);
      });
    } else {
      // Browser doesn't support Geolocation
      browserSupportFlag = false;
      handleNoGeolocation(browserSupportFlag);
    }
    }
  }

  function putMarker(){
    var marker = new google.maps.Marker({
      position: initialLocation,
      map: map,
      draggable:true
    });
    google.maps.event.addListener(marker, "dragend", function (mEvent) {
      var latLng = mEvent.latLng.lat()+","+mEvent.latLng.lng();
      $("input[name='${refField}']").val(latLng);
    });
  }

  function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
      initialLocation = newyork;
      contentString = "Error: El servicio de Geolocalización ha fallado.";
    } else {
      initialLocation = siberia;
      contentString = "Error: Tu navegador no soporta geolocalización. Estás en Siberia?";
    }
    map.setCenter(initialLocation);
    infowindow.setContent(contentString);
    infowindow.setPosition(initialLocation);
    infowindow.open(map);
  }

  initialize();
</script>
