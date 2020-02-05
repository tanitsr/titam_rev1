import 'package:flutter/material.dart';
//import 'package:firebase_test/screens/input_user_screen.dart';
import '../components/responsive.dart';
//import 'package:firebase_test/screens/detail_user.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import '../widget/input_info_widget.dart';
import 'dart:convert';
import '../screen/datail_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> 
    with AutomaticKeepAliveClientMixin {
  UserProfile _userProfile;
  StoredAccessToken _accessToken;
  bool _isOnlyWebLogin = false;

  

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    UserProfile userProfile;
    StoredAccessToken accessToken;

    try {
      accessToken = await LineSDK.instance.currentAccessToken;
      if (accessToken != null) {
        userProfile = await LineSDK.instance.getProfile();
      }
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (!mounted) return;

    setState(() {
      _userProfile = userProfile;
      _accessToken = accessToken;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color.fromARGB(255, 10, 22, 37),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Stack(    
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: hight(context, 40) 
                  ,left: width(context, 31.0)
                  ),
                  child: Image.asset("images/logo.png"),
                ),
                Container(
                 margin: EdgeInsets.only(top: hight(context, 30) 
                  ,left: width(context, 24.0)),
                  child: Image.asset("images/tittam_logo.png"),
                ),
                GestureDetector(
                  onTap: (){
                    _signIn();
                  },                  
                  child: Container(
                  margin: EdgeInsets.only(top: hight(context, 41) 
                    ,left: width(context, 15)),
                  child: Image.asset("images/btn_login_press.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 70) 
                  ,left: width(context, 0)),
                  child: Image.asset("images/partner_logo.png"),
                ),                
              ],
            )
          ],
        )        
      )        
    );

  //else{
     //return InputInfoWidget(
      // userProfile: _userProfile, accessToken: _accessToken, onSignOutPressed: _signOut);
  // }// todo: return to datail_page 
  }
  void _signIn() async {
    try {
      /// requestCode is for Android platform only, use another unique value in your application.
      final loginOption = LoginOption(_isOnlyWebLogin, "normal", requestCode: 8192);
      final result = await LineSDK.instance.login(
          scopes: ["profile", "openid", "email"]);
      final accessToken = await LineSDK.instance.currentAccessToken;
      print(accessToken.data["access_token"]);
      setState(() {
        _userProfile = result.userProfile;
        _accessToken = accessToken;
      });
      //_verifyAccessToken();
      
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return InputInfoWidget(userProfile: _userProfile, accessToken: _accessToken, onSignOutPressed: _signOut);
      }));

    } on PlatformException catch (e) {
      _showDialog(context, e.toString());
    }
  }

  void _signOut() async {
    try {
      await LineSDK.instance.logout();
      setState(() {
        _userProfile = null;
        _accessToken = null;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _showDialog(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ข้อผิดพลาด !",
                    style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                    ),
                    textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromARGB(255, 10, 22, 37),
            content: Text("เข้าสู่ระบบไม่สำเร็จ",style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),),
            actions: <Widget>[
            FlatButton(
              child: Text('ปิด',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16,                        
                color: Colors.red,
                fontWeight: FontWeight.bold
                
              )),
              onPressed: () { Navigator.of(context).pop(); },
            ),
          ],
          );
        });
  }


}
