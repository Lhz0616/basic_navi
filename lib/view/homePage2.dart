import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocation/geolocation.dart' as geoLo;
import 'package:geolocator/geolocator.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {

  MapController controller = MapController();
  var latitude, longitude;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

  location() async{
    final geoPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = geoPosition.latitude;
      longitude = geoPosition.longitude;
    });
  }

  @override
  void initState(){
    super.initState();
    location();
  }


  getPermission() async{
    final geoLo.GeolocationResult result =
        await geoLo.Geolocation.requestLocationPermission(
          permission: const geoLo.LocationPermission(
            android: geoLo.LocationPermissionAndroid.fine,
            ios: geoLo.LocationPermissionIOS.always
          )
        );
    return result;
  }

  getLocation() {
    return getPermission().then((result) async{
      if(result.isSuccessful){
        final coords = await geoLo.Geolocation.currentLocation(accuracy: geoLo.LocationAccuracy.best);
        return coords;
      }
    });
  }

  buildMap(){
    getLocation().then((response){
      if(response.isSuccessful){
        print('$latitude, $longitude');
        response.listen((value) {
          controller.move(LatLng(value.location.latitude, value.location.longitude), 20);
        });
      }
    });
  }

/*  var points = <LatLng>[
    LatLng(35.72, -101.83),
    LatLng(32.77, -96.79),
    LatLng(29.76, -95.36),
    LatLng(29.42, -98.49),
    LatLng(35.22, -101.83)
  ];*/



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter MapView example')),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(
          center: LatLng(latitude, longitude), minZoom: 1.0),
        layers: [
          TileLayerOptions(
              urlTemplate: 'https://api.mapbox.com/styles/v1/616hz-lim/cklaut51x29iw17ns8n20v6jr/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiNjE2aHotbGltIiwiYSI6ImNrbGF0cXM3ejBhaG8ycG8zeWg0YXMxd3AifQ.gxf1_iBubsaQlFPK9hGvsg',
              additionalOptions: {
                'accessToken' : 'pk.eyJ1IjoiNjE2aHotbGltIiwiYSI6ImNrbGF0cXM3ejBhaG8ycG8zeWg0YXMxd3AifQ.gxf1_iBubsaQlFPK9hGvsg',
                'id' : 'mapbox.mapbox-streets-v7'
              }
              ),
          MarkerLayerOptions(
              markers: [
                Marker(
                  width: 45,
                  height: 45,
                  point: LatLng(latitude, longitude),
                  builder: (context) => Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45,
                      onPressed: (){
                        print('Marker tapped');
                      },
                    ),
                  )
                )
              ]
          )

          /*PolylineLayerOptions(
            polylines: [
              Polyline(
                points: points,
                strokeWidth: 5,
                color: Colors.red
              )
            ]
          )*/
        ],
        ),
      );

  }
}
