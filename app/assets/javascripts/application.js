// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require_tree .



// jquery Dropdowns

$(document).ready(function(){

	//Retailer dropdown change
	$('#dd_audit_id').change(function(){
		
		var data = $('#dd_audit_id').val();
		$.ajax({
			type: "POST",
			url: "http://" + location.host + "/dynamic_stores/" + data,
			data: data
		})
		
		
	})
});


// Snapshot Map

var snapshotMap;
/*------------------------------------------------------- map data array */
var snapshotMapData = new Array();
/*------------------------------------------------------- mapMarkerCluster object */
var mapMarkerCluster;
/*------------------------------------------------------- map styling object */
var snapshotMapStyles = [
	{
		featureType: 'water',
		stylers: [
			{ hue: '#77bbdd' },
			{ saturation: -27 },
			{ lightness: 12 },
			{ visibility: 'on' }
		]
	}
];
/*------------------------------------------------------- map variables */
var mapReady = false;
var zoomLevel = 5;
/*------------------------------------------------------- create map */
function createMap() {
	// Use snapshot map style
	var snapshotMapType = new google.maps.StyledMapType(
			snapshotMapStyles,
			{ name: 'Snapshot' }
	);
	// map options
	var mapOptions = {
		center: new google.maps.LatLng(51.508129,0),
		mapTypeControl: false,
		mapTypeControlOptions: {
			mapTypeIds: [google.maps.MapTypeId, 'snapshotMapStyles']
		},
		minZoom: 1,
		streetViewControl: false,
		panControl: false,
		zoom: zoomLevel,
		zoomControlOptions: {
			position: google.maps.ControlPosition.LEFT_BOTTOM
		}
	};
	// create map
	snapshotMap = new google.maps.Map(
			document.getElementById('map_canvas'),
			mapOptions
	);
	snapshotMap.mapTypes.set('snapshotMapStyles', snapshotMapType);
	snapshotMap.setMapTypeId('snapshotMapStyles');
	// show markers onload
	setTimeout(
			function() {
				google.maps.event.addDomListener(
						window,
						'load',
						// live
						showMapMarkers('get_markers.php')
						// local
//						showMapMarkers('get_markers.json')
				);
			},
			986
	);
	// allow interaction
	mapReady = true;
}