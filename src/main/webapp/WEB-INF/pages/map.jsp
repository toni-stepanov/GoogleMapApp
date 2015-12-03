<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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

<input name="pointName" id="name"></body>
</br>
<input name="pointDesc" id="desc"></body></br>
<button class="submit">submit</button>
</br>

<div id="map"></div>

<script type="text/javascript">
    var map;

    function initMap() {
        var myLatLng = {lat: -25.363, lng: 131.044};
        map = new google.maps.Map(document.getElementById('map'), {
            center: myLatLng,
            zoom: 8
        });

        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            label: 'A'
        });
    }

    $(document).ready(function () {
        var add_button = $(".submit");
        var name = $("#name");
        var desc = $("#desc");
        add_button.click(function (e) {
            $.ajax({
                type: 'POST',
                url: '/map',
                data: ({
                    pointName: name.val(),
                    pointDesc: desc.val()
                }),
                success: function (data) {
                    alert(data);
                }
            });
        });
    });

</script>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap">
</script>

</body>
</html>