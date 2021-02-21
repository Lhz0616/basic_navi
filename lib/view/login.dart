import 'package:basic_navi/view/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:basic_navi/util/googleSignIn.dart';
import 'homePage3.dart';
import 'homePage2.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Login(),
    );
  }
}

class Login extends StatefulWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  User user;
  
  Widget buildLoading() => Center(child: CircularProgressIndicator(),);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [/*TextField(
          controller: widget.usernameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person),
            labelText: 'Username',),
        ),*/

          /*TextField(
            obscureText: !this._visible,
            controller: widget.passwordController,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.security),
                labelText: 'Password',
                suffixIcon: IconButton(
                    icon : Icon(Icons.remove_red_eye) ,
                    color: this._visible ? Colors.blue : Colors.black,
                    onPressed: () {
                      setState(() {
                        this._visible = !this._visible;
                      });
                    })),
          ),*/

          /*ElevatedButton(
              child: Text('Login'),
              onPressed: null),*/
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 175,
              child: Text(
                  'Welcome to the basic Navi',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ),

          Spacer(),
          SizedBox(height: 12),

          Container(
            padding: EdgeInsets.all(20),
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  return OutlinedButton(
                  onPressed: () {
                    signInWithGoogle().then((user) => {
                      this.user = user,
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => HomePage2()))
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(image: AssetImage('assets/google_logo.png'),
                        height: 35,),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('Sign in with Google',
                          style: TextStyle(fontSize: 20),),
                        )
                      ],
                    ),
                  ));
                }
              )),

          /*TextButton(
              child: Text('Forgot your password?'),
              onPressed: null),*/

          Text('Login to continue'),
          Spacer(),
        ],
      ),
    );
  }
}

