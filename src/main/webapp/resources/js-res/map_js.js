var map;

function initMap() {
    var myLatLng = {lat: 48.163, lng: 11.644};
    map = new google.maps.Map(document.getElementById('map'), {
        center: myLatLng,
        zoom: 8
    });
}

function addPoint(lat, long, description) {
    var newLatLng = {lat: lat, lng: long};
    var contentString = description;
    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    var marker = new google.maps.Marker({
        position: newLatLng,
        map: map,
        label: contentString
    });

    marker.addListener('click', function () {
        infowindow.open(map, marker)
    })
}

$(document).ready(function () {
    var add_button = $(".submit");
    var name = $("#name");
    var desc = $("#desc");
    add_button.click(function (e) {
        $.ajax({
            type: 'POST',
            url: '/add',
            data: ({
                pointName: name.val(),
                pointDesc: desc.val()
            }),
            success: function (data) {
                addPoint(data.latitude, data.longitude, data.description)
            }

        });
    });
});
