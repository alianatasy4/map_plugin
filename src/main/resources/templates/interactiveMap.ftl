<link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.map.InteractiveMap/css/leaflet.css" type="text/css" />
<style>
    #map { height: 300px; }
</style>
<script src="${request.contextPath}/plugin/org.joget.map.InteractiveMap/js/leaflet.js"></script>
<div id="map"></div>
<script type="text/javascript">
    $(function() {
        "use strict";

        var lat = ${element.properties.lat!};
        var lng = ${element.properties.lng!};
        var zoom = ${element.properties.zoom!};
        var maxZoom = ${element.properties.maxZoom!};

        var map = L.map('map').setView([lat, lng], zoom);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: maxZoom,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        // Marker
        var marker = L.marker([lat, lng]).addTo(map);

        // Popup as layers
        var popup = L.popup()
            .setLatLng([lat, lng])
            .setContent("We are here.")
            .openOn(map);

        // Event handling
        var popupClick = L.popup();

        function onMapClick(e) {
            popupClick
                .setLatLng(e.latlng)
                .setContent("You clicked the map at " + e.latlng.toString())
                .openOn(map);
        }

        map.on('click', onMapClick);
    });
</script>
