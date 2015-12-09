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
    <%--<spring:url value="/resources/js-res/map_js.js" var="map"/>--%>

    <link href="${bootstrap}" rel="stylesheet" media="screen">
    <link href="${bootstrap_theme}" rel="stylesheet" media="screen">

    <script src="${jquery}"></script>
    <script src="${bootstrap_js}"></script>
    <%--<script src="${map}"></script>--%>
</head>

<body>

Name: <input name="pointName" id="name"></body>
</br>
Address: <input name="pointDesc" id="desc"></body></br>
<button class="submit">submit</button>
</br>

</br>
<div class="pointList">
<c:forEach items="${points}" var="point">
    <a href="point/${point.id}">${point.description}</a>
</c:forEach>
</div>
</br>

<div id="map"></div>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap">
</script>

<script>
    var map;

    function initMap() {
        var myLatLng = {lat: 48.163, lng: 11.644};
        var points = [];
        points = "${points}";
        map = new google.maps.Map(document.getElementById('map'), {
            center: myLatLng,
            zoom: 8
        });

        <c:forEach items="${points}" var="point">
            addPoint(${point.latitude}, ${point.longitude}, "${point.description}")
        </c:forEach>
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
        var list = $(".pointList");
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
                    list.append('<a href="point/' + data.id + '">' + data.description + '</a>');
                }

            });
        });
    });
</script>

</body>
</html>