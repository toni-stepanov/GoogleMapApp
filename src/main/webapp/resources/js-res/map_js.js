var map;

function initMap() {
    var myLatLng = {lat: 48.163, lng: 11.644};
    map = new google.maps.Map(document.getElementById('map'), {
        center: myLatLng,
        zoom: 8
    });
    var contentString = '<b>Munich</b>';

    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        label: 'A'
    });

    marker.addListener('click', function () {
        infowindow.open(map, marker);
    });

}

function newPoint(lat, long, description) {
    var newLatLng = {lat: lat, lng: long};
    var contentString = '<b>'+description+'</b>';
    var infowindow = new google.maps.InfoWindow({
        content: contentString
    });

    var marker = new google.maps.Marker({
        position: newLatLng,
        map: map,
        label: 'B'
    });

    marker.addListener('click', function (){
        infowindow.open(map, marker)
    })

}

$(document).ready(function () {
    var add_button = $(".submit");
    var name = $("#name");
    var desc = $("#desc");
    add_button.click(function (e) {
        alert(name.length);
        if(name === "" || desc === ""){
            alert("Hui");
        } else{
            $.ajax({
                type: 'POST',
                url: '/map',
                data: ({
                    pointName: name.val(),
                    pointDesc: desc.val()
                }),
                success: function (data) {
                    newPoint(data.latitude, data.longitude, data.description)
                }

            });
        }
    });
});
