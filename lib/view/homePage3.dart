import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  String locationMessage = "";

  void getCurrentLocation() async{
    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    var lastPosition = await Geolocator.getLastKnownPosition();

    print(lastPosition);

    setState(() {
      locationMessage = '${position.latitude}, ${position.longitude}';
    });
  }

  @override
  void initState(){
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Service'),
      ),
      body: Center(
        child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(Icons.location_on, size: 46.0, color: Colors.blue),
              Text('Get User Location', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Text(locationMessage),
              ElevatedButton(
                  onPressed: getCurrentLocation,
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text("Get Current Location", style: TextStyle(color: Colors.white)) )
            ],
          ),
      ),
    );
  }
}
