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
    <spring:url value="/resources/js-res/map_js.js" var="map"/>

    <link href="${bootstrap}" rel="stylesheet" media="screen">
    <link href="${bootstrap_theme}" rel="stylesheet" media="screen">

    <script src="${jquery}"></script>
    <script src="${bootstrap_js}"></script>
    <script src="${map}"></script>
</head>

<body>


Name: <input name="pointName" id="name"></body></br>
Address: <input name="pointDesc" id="desc"></body></br>
<button class="submit">submit</button></br>

<div id="map"></div>

<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap">
</script>

</body>
</html>