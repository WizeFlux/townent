(-> $.widget "custom.gmap",
  options:
    lat: 0
    lng: 0
  
  _create: ->
    latLng = new google.maps.LatLng(@options.lat, @options.lng)
    
    options =
      center: latLng
      zoom: 13
      mapTypeId: google.maps.MapTypeId.ROADMAP
    
    map = new google.maps.Map(@element.get(0), options)
    
    marker = new google.maps.Marker(
      position: latLng
      map: map
    )  
) jQuery
