<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>

    <style type="text/css">
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map {
            height: 60%;
            width: 70%
        }
    </style>

    <spring:url value="/resources/css-res/bootstrap.min.css" var="bootstrap"/>
    <spring:url value="/resources/css-res/bootstrap-theme.min.css" var="bootstrap_theme"/>

    <spring:url value="/resources/js-res/bootstrap.js" var="bootstrap_js"/>
    <spring:url value="/resources/js-res/jquery-validate.js" var="validate"/>
    <spring:url value="/resources/js-res/jquery.js" var="jquery"/>

    <link href="${bootstrap}" rel="stylesheet" media="screen">
    <link href="${bootstrap_theme}" rel="stylesheet" media="screen">

    <script src="${jquery}"></script>
    <script src="${bootstrap_js}"></script>
</head>

<body>

</br>
${point.description}
</br>
${point.address}
</br></br>

<div id="map"></div>

<script>
    var map;

    function initPoint() {
        var contentString = "${point.description}";
        var myLatLng = {lat: ${point.latitude}, lng: ${point.longitude}};
        map = new google.maps.Map(document.getElementById('map'), {
            center: myLatLng,
            zoom: 8
        });

        var infowindow = new google.maps.InfoWindow({
            content: contentString
        });

        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            label: contentString
        });

        marker.addListener('click', function () {
            infowindow.open(map, marker);
        });

    }
</script>

    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initPoint">
</script>

<a href="/mapgoogle">
    <button>Back</button>
</a>

</body>
<br/>
</html>