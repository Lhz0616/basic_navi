import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'file:///C:/Lim/flutter%20projects/basic_navi/lib/util/googleSignIn.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey.shade900,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Logged in',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),

              SizedBox(height: 8),
              CircleAvatar(maxRadius: 25,
                backgroundImage: NetworkImage(user.photoURL),),

              SizedBox(height: 8),
              Text('Name : ' + user.displayName,
                style: TextStyle(color: Colors.white, fontSize: 12),),

              SizedBox(height: 8),
              Text('Email : ' + user.email, style: TextStyle(color: Colors.white, fontSize: 12),),

              SizedBox(height: 8),
              ElevatedButton(onPressed: (){
                signOutGoogle();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }
                  , child: Text('Logout')),

    ],
      ),
    ));
  }
}
