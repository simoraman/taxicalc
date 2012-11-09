$(document).ready(function() {
	initializeMap();
});

$('#to').focusout(calculateDistance);
$('#from').focusout(calculateDistance);

function calculateDistance() {
	var from=$('#from').val();
	var to=$('#to').val();
	if(from!=''&&to!=''){
		initializeDistanceMatrix(from, to);
	}
	return false;
}

$('#button').click(function() {
	var dataobject = JSON.stringify({
		distance: $('#distance').text(),
		passengers: $('#passengers').val()
	});

	$.ajax({
		url: 'calculate',
		type: 'POST',
		contentType: 'application/javascript; charset=utf-8',
		dataType: 'json',
		data: dataobject,
		success: function(data) {
			$('#price').text(data.price + " €");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$('#error').text(xhr.responseText);
		}
	});
	return false;
});

var markersArray = [];
var map;
var directionsDisplay;

function initializeMap() {
	if (navigator.geolocation){
		navigator.geolocation.getCurrentPosition(function(position){
			createMap(position.coords.latitude, position.coords.longitude);
		});
	}
	else{
		createMap(60.168058, 24.94169);
	}
	new google.maps.places.Autocomplete($('#from')[0]);
	new google.maps.places.Autocomplete($('#to')[0]);
}

function createMap(latitude, longitude){

	var mapOptions = {
		center: new google.maps.LatLng(latitude, longitude),
		zoom: 15,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	var canvas = $('#map_canvas')[0];
	map = new google.maps.Map(canvas, mapOptions);
	directionsDisplay = new google.maps.DirectionsRenderer();
	directionsDisplay.setMap(map);
}
function initializeDistanceMatrix(origin, destination) {
	var service = new google.maps.DistanceMatrixService();
	service.getDistanceMatrix({
		origins: [origin],
		destinations: [destination],
		travelMode: google.maps.TravelMode.DRIVING
	}, distanceCallback);

	var directionsService = new google.maps.DirectionsService();
	var request = {
		origin: origin,
		destination: destination,
		travelMode: google.maps.TravelMode.DRIVING
	};
	directionsService.route(request, function(result, status) {
		if (status == google.maps.DirectionsStatus.OK) {
			directionsDisplay.setDirections(result);
		}
	});

}

function distanceCallback(response, status) {
	if (status == google.maps.DistanceMatrixStatus.OK) {
		var results = response.rows[0].elements;
		var element = results[0];
		
		var distance = element.distance.text;
		var duration = element.duration.text;
		
		var from = response.originAddresses[0];
		var to = response.destinationAddresses[0];
		
		$('#distance').text(distance)
		$('#time').text(duration)
		
		var dataobject = JSON.stringify({
			distance: distance,
			passengers: $('#passengers').val()
		});

		$.ajax({
			url: 'calculate',
			type: 'POST',
			contentType: 'application/javascript; charset=utf-8',
			dataType: 'json',
			data: dataobject,
			success: function(data) {
				$('#price').text(data.price + " €");
			},
			error: function(xhr, ajaxOptions, thrownError) {
				$('#error').text(xhr.responseText);
			}
		});
		return false;
	}
}
