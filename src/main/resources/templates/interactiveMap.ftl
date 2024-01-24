<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" type="text/css" />
<style>
    #map { height: 300px; }
</style>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
<div id="map"></div>
<script type="text/javascript">
    $(function() {
        "use strict";
        var lat = ${element.properties.lat!};
        var lng = ${element.properties.lng!};
        var zoom = ${element.properties.zoom!};
        var maxZoom = ${element.properties.maxZoom!};
        var message = "${element.properties.message!}";
        var onClickMessage = "${element.properties.onClickMessage!}";

        var map = L.map('map').setView([lat, lng], zoom);

        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: maxZoom,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        // Marker for initial coordinates
        var marker = L.marker([lat, lng]).addTo(map);

        // Popup for initial coordinates
        if (message) {
            marker.bindPopup(message);
        }
        
        // Additional markers
        <#list element.properties.addMarker as marker>
            var markerData = {
                latitude: ${marker.latitude!},
                longitude: ${marker.longitude!},
                addMessage: "${marker.addMessage!}"
            };

            // Marker for each grid item
            var markerAdd = L.marker([markerData.latitude, markerData.longitude]).addTo(map);
            if (markerData.addMessage) {
                markerAdd.bindPopup(markerData.addMessage);
            }
        </#list>

        // Event handling
        var popupClick = L.popup();

        function onMapClick(e) {
            popupClick
                .setLatLng(e.latlng)
                .setContent(onClickMessage + " " + e.latlng.toString())
                .openOn(map);
            console.log(e.latlng.toString());
        }
        map.on('click', onMapClick);

        map.on('popupopen', function (e) {
            var closeBtn = document.querySelector('.leaflet-popup-close-button');
            if (closeBtn) {
                closeBtn.addEventListener('click', function (event) {
                    event.stopPropagation(); // Prevent the click event from propagating
                    e.popup._source._close(); // Close the popup without triggering page navigation
                });
            }
        });
    });
</script>

