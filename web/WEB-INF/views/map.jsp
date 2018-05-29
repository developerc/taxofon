<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Taxofon</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" integrity="sha512-Rksm5RenBEKSKFjgI3a41vrjkw4EVPlJ3+OiI65vTjIdo9brlAacEuKOiQ5OFh7cOI1bkDwLqdLw3Zg0cRJAAQ==" crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js" integrity="sha512-/Nsx9X4HebavoBvEBuyp3I7od5tA0UzAxs+j83KgC8PU0kgB4XiK4Lfe4y4cgBtaRJQEIFCW+oC506aPT2L1zw==" crossorigin=""></script>
</head>
<body>

<div id="mapid" style="width: 100%; height: 100%;"></div>
<script>
    var service = 'http://localhost:8080/';
    var mymap = L.map('mapid').setView([45.852717, 40.131683], 12);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
        maxZoom: 20,
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
        '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        id: 'mapbox.streets'
    }).addTo(mymap);

    /*L.marker([45.852717, 40.131683]).addTo(mymap)
        .bindPopup("<b>41256</b><br />Октябрьская 24А");
    L.marker([45.849608, 40.104218]).addTo(mymap)
        .bindPopup("<b>41256</b><br />Октябрьская 24А");
    L.marker([45.803435, 40.103188]).addTo(mymap)
        .bindPopup("<b>41256</b><br />Октябрьская 24А");
    L.marker([45.770995, 40.159492]).addTo(mymap)
        .bindPopup("<b>41256</b><br />Октябрьская 24А");
    L.marker([45.906853, 40.160179]).addTo(mymap)
        .bindPopup("<b>41256</b><br />Октябрьская 24А");*/
    GetMarkerCoords();

    var popup = L.popup();

    function onMapClick(e) {
        popup
            .setLatLng(e.latlng)
            .setContent("You clicked the map at " + e.latlng.toString())
            .openOn(mymap);
    }

    function  GetMarkerCoords() {
        var output = '';

        $.ajax({
            type: 'GET',
            url: service + 'taxofon/all',
            dataType: 'json',
            async: false,
            success: function (result) {
                var greenIcon = new L.Icon({
                    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34],
                    shadowSize: [41, 41]
                });
                var redIcon = new L.Icon({
                    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
                    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34],
                    shadowSize: [41, 41]
                });
                var latlng;
                var stringData = JSON.stringify(result);
                var arrData = JSON.parse(stringData);
                for (i in arrData) {
                    var troubleNotOpen = true;
                    latlng = L.latLng(arrData[i].lat, arrData[i].lon);
                    // L.marker([arrData[i].lat, arrData[i].lon]).addTo(mymap)
                    var arDaLi = [];
                        arDaLi = arrData[i].damageLists;
                    if (arDaLi.length == 0){
                        alert('нет записей о неисправности')
                    } else {
                        alert(arrData[i].damageLists);
                        for (i in arDaLi){
                            if (arDaLi[i].dateTimeEnd == null){
                                alert('arDaLi.dateTimeEnd == null' + arDaLi.dateTimeEnd.toString());
                                troubleNotOpen = false;
                            } else {
                                alert('arDaLi.dateTimeEnd !== null' + arDaLi.dateTimeEnd.toString());
                            }
                        }
                    }
                    if (troubleNotOpen == true) {
                        L.marker(latlng, {icon: greenIcon}).addTo(mymap)
                            .bindPopup("<b>" + arrData[i].tlfnum + "</b><br />" + arrData[i].adres);
                    } else {
                        L.marker(latlng, {icon: redIcon}).addTo(mymap)
                            .bindPopup("<b>" + arrData[i].tlfnum + "</b><br />" + arrData[i].adres);
                    }
                    /*if(CheckTroubleOpen(arrData[i].damageLists)) {
                        L.marker(latlng, {icon: greenIcon}).addTo(mymap)
                            .bindPopup("<b>" + arrData[i].tlfnum + "</b><br />" + arrData[i].adres);
                    } else {
                        L.marker(latlng, {icon: redIcon}).addTo(mymap)
                            .bindPopup("<b>" + arrData[i].tlfnum + "</b><br />" + arrData[i].adres);
                    }*/
                }
                // alert(stringData);
            },
            error: function (jqXHR, testStatus, errorThrown) {
                alert('Ошибка получения координат таксофонов')
            }
        });
    };

    var CheckTroubleOpen = function (arrDamageList) {
        //если возвращает true значит нет открытых заявок на неисправность
        var troubleNotOpen = true;
        var arDaLi = [];
        arDaLi = arrDamageList;
        if (arDaLi.length == 0){
            // alert('arDaLi = []')
            return true;
        } else {
            for (i in arDaLi){
                if (arDaLi.dateTimeEnd == null){
                    // alert('arDaLi.dateTimeEnd == null');
                    troubleNotOpen = false;
                } else {
                    // alert('arDaLi.dateTimeEnd !== null');
                }
            }
            return troubleNotOpen;
        }

    };

    mymap.on('click', onMapClick);
    // window.onload = GetMarkerCoords;
</script>

</body>
</html>
