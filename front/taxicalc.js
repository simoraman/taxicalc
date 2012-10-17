$('#distanceButton').click(function() { 
	initializeDistanceMatrix($('#from').val(), $('#to').val());
	return false;
});
$('#button').click(function() { 
	var dataobject=JSON.stringify({ distance:$('#distance').text(), passengers:$('#passengers').val() });

	$.ajax({
    	url: 'calculate',
    	type: 'POST',
		contentType: 'application/javascript; charset=utf-8',
		dataType: 'json',
    	data: dataobject,
    	success: function ( data ) {
        	$('#price').text(data.price);
    	},
		error: function (xhr, ajaxOptions, thrownError) {
        	$('#error').text(xhr.responseText);
    	}
	});
	return false;
});
function initializeMap() {
        var mapOptions = {
          center: new google.maps.LatLng(-34.397, 150.644),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);
}
function initializeDistanceMatrix(origin, destination){
	var service = new google.maps.DistanceMatrixService();
	service.getDistanceMatrix(
	  {
	    origins: [origin],
	    destinations: [destination],
	    travelMode: google.maps.TravelMode.DRIVING
	  }, distanceCallback);

	
}
function distanceCallback(response, status) {
	if (status == google.maps.DistanceMatrixStatus.OK) {
	    var origins = response.originAddresses;
	    var destinations = response.destinationAddresses;

	      var results = response.rows[0].elements;
	      for (var j = 0; j < results.length; j++) {
	        var element = results[j];
	        var distance = element.distance.text;
	        var duration = element.duration.text;
	        var from = origins[0];
	        var to = destinations[0];
	      	$('#distance').text(distance)
	    }
	  }
}