# as3geolocation
as3geolocation is ActionScript wrapper utility that can easily use HTML5 Geolocation API with Flash/Flex.


## Samples
 * [Geolocation Sample](http://dl.dropbox.com/u/227786/code/flex/as3geolocation/as3geolocation.html) - [Source code](http://code.google.com/p/as3geolocation/source/browse/trunk/samples/src/as3geolocation.mxml)

## How to use

### HTML
	<head>
	  ...
	  <script type="text/javascript" src="as3geolocation-0.1.0.js"></script>
	  ...
	</head>

## Flash/Flex
	import com.google.code.as3geolocation.Geolocation;
	
	protected function getPositionButton_clickHandler(event:MouseEvent):void
	{
	  Geolocation.getCurrentPosition(setPosition);
	}
	
	private function setPosition(position:*):void
	{
	  var latitude:Number = position.coords.latitude;
	  var longitude:Number = position.coords.longitude;
	  var altitude:Number = position.coords.altitude;
	  var accuracy:Number = position.coords.accuracy;
	  var altitudeAccuracy:Number = position.coords.altitudeAccuracy;
	  var heading:Number = position.coords.heading;
	  var speed:Number = position.coords.speed;
	  
	  map.clearOverlays();
	  map.setCenter(new LatLng(latitude, longitude), 14, MapType.NORMAL_MAP_TYPE);
	  var markerA:Marker = new Marker(
	    new LatLng(latitude, longitude),
	    new MarkerOptions({
	      radius: 12,
	      hasShadow: true
	    })
	  );
	  map.addOverlay(markerA);
	  
	  latLngText.text = "latitude: " + latitude + "\r"
	    + "longitude: " + longitude + "\r"
	    + "altitude: " + altitude + "\r"
	    + "accuracy: " + accuracy + "\r"
	    + "altitudeAccuracy: " + altitudeAccuracy + "\r"
	    + "heading: " + heading + "\r"
	    + "speed: " + speed;
	}