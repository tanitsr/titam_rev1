import 'dart:io';
import 'package:flutter/material.dart';
import '../components/responsive.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:tittam_rev1/utils/database_helper.dart';
import 'package:tittam_rev1/src/screen/datail_page.dart';
import 'package:tittam_rev1/src/screen/login_page.dart';
import 'package:tittam_rev1/src/screen/datail_page.dart';
import 'package:firebase_database/firebase_database.dart';


var resultFromCloudFuntion;
String firebaseTokenFromSQL = "";
String nameFromSQL = "";
String ageFromSQL = "";
String phonenumberFromSQL = "";
String uidLineFromSQL = "";
String timestampFromSQL = "";
String urlImagesFromSQL = "";
bool checkDataFromSQL = false;


class User{
  String name;
  String age;
  String phonenumber;

  User(Map<String, dynamic> data){
    name = data['name'];
    age = data['age'];
    phonenumber = data['phonenumber'];
  }
}

TextEditingController nameController = new TextEditingController();
TextEditingController ageController = new TextEditingController();
TextEditingController phoneumberController = new TextEditingController();

class InputInfoWidget extends StatelessWidget {

  const InputInfoWidget({
    Key key,
    this.userProfile,
    this.accessToken,
    this.onSignOutPressed
  }) : super(key: key);

  final UserProfile userProfile;
  final StoredAccessToken accessToken;
  final Function onSignOutPressed;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: hight(context, 4) 
                  ,left: width(context, 4)
                  ),
                  child: Text("ลงทะเบียนครั้งแรก !",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  )
                ),
                // Container(
                //   padding: EdgeInsets.only(top: hight(context, 13),
                //   left: width(context, 22)),
                //   child: Image.network(
                //     userProfile.pictureUrl,
                //     width: 200,
                //     height: 200,                    
                //   ),
                // ), 
                Container(
                  padding: EdgeInsets.only(top: hight(context, 14),
                  left: width(context, 28)),
                  child: new Stack(
                    children: <Widget>[
                      Container(
                      decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 4,color: Colors.lightGreen)
                      ),
                      child : new ClipRRect(
                      borderRadius: new BorderRadius.circular(100.0),
                      child: Image.network(
                        userProfile.pictureUrl,
                        height: 150.0,
                        width: 150.0,
                          ),
                        ),                  
                      ),
                      Container(
                        padding: EdgeInsets.only(top: hight(context, 17.5),
                        left: width(context, 30)),
                        width: 150,
                        child: Image.asset('images/line_logo.png'),
                        ),
                      
                    ],                
                  )
                ),              
                Container(
                  padding: EdgeInsets.only(top: hight(context, 48),
                  left: width(context, 5)),
                  child: Text("ชื่อ - นามสกุล",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 148, 154, 163)
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 53.5),
                  left: width(context, 7)),
                  width: 320,
                  height: 50,
                  child: TextField(
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.black
                      ),
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'กรุณาใส่ข้อมูล',
                      hintStyle: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 148, 154, 163)
                      )
                    ),                    
                  )
                ),Container(
                  padding: EdgeInsets.only(top: hight(context, 62),
                  left: width(context, 5)),
                  child: Text("อายุ",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 148, 154, 163)
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 67.5),
                  left: width(context, 7)),
                  width: 85,
                  height: 50,
                  child: TextField(
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.black
                    ),
                    controller: ageController,
                    decoration: InputDecoration(                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'กรุณาใส่ข้อมูล',
                      hintStyle: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 148, 154, 163)
                      )
                    ),                    
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: hight(context, 62),
                  left: width(context, 33)),
                  child: Text("เบอร์โทรศัพท์",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 148, 154, 163)
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 67.5),
                  left: width(context, 35)),
                  width: 210,
                  height: 50,
                  child: TextField(
                    style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.black
                      ),
                    controller: phoneumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'กรุณาใส่ข้อมูล',
                      hintStyle: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 148, 154, 163)
                      )
                    ),                    
                  )
                ),
                Container(
                  padding: EdgeInsets.only(top: hight(context, 77),
                  left: width(context, 9)),
                  child: Text("*ตรวจเช็คข้อมูลให้เรียบร้อย มีผลต่อการใช้งานเครื่องฯ",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 39),
                  left: width(context, 32.5)),
                  child: RaisedButton(                  
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text("ไม่ใช่บัญชีฉัน !",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  ),
                  onPressed: () async{
                    onSignOutPressed();
                    await _delete();
                    nameController.clear();
                    phoneumberController.clear();
                    ageController.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    }
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: hight(context, 83),
                  left: width(context, 17)),
                  width: 250,
                  height: 50,
                  child :RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.blue)
                  ),                  
                  textColor: Colors.blue,
                  color: Colors.blue,
                  child: Text("สำเร็จ, ต่อไป",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                  ),
                  onPressed: (){
                    var jsonData = '{"name":"' + nameController.text
                    +'","age":"' + ageController.text + '","phonenumber":"'
                    + phoneumberController.text+'"}';
                    var parsedJson = json.decode(jsonData);
                    var user = User(parsedJson);
                    _showDialog(context,user,accessToken,userProfile);
                    }
                  ),
                )                          
              ],
            )
          ],
        ),
      )
    );
    
    }
}
void _showDialog(BuildContext context,text,StoredAccessToken accessToken,UserProfile userProfile) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ข้อความเหล่านี้ถูกต้อง !",
                    style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                    ),
                    textAlign: TextAlign.center,
                    ),
            backgroundColor: Color.fromARGB(255, 10, 22, 37),
            content: Text('ชื่อ-นามสกุล : '  + '${text.name}\n' + 'อายุ : '
            + '${text.age}\n' + 'เบอร์โทรศัพท์ : ' + '${text.phonenumber}'
            ,style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16,
                    color: Colors.white
                    ),),
            actions: <Widget>[
            FlatButton(
              child: Text('ยอมรับ',style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.green,
                        fontWeight: FontWeight.bold
              )),
              onPressed: () async {
                _loading(context);               
                final payloadfromJWT = decodeJWT(accessToken);
                //print(payloadfromJWT["sub"]);
                await getHttpOnCloudFuntion(accessToken, payloadfromJWT);
                var result = json.decode(resultFromCloudFuntion.body);
                String date = DateTime.now().toString();  
                await _save(result["firebase_token"], nameController.text, ageController.text,
                phoneumberController.text, payloadfromJWT["sub"], date, userProfile.pictureUrl);
                await _read();
                await _addDataToFirebase();
                if (checkDataFromSQL == true){
                   await Future.delayed(Duration(seconds: 3));              
                   Navigator.pop(context);
                   Navigator.pop(context);                   
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return DetailPage();
                  }));                 
                }
                 // if(result != null){
                //    final payload = UserSQL(
                //      id: 0,
                //      tokenFirebase: result["firebase_token"],
                //      name : nameController.text,
                //      age: ageController.text,
                //      phonenumber: phoneumberController.text,
                //      uidLine: payloadfromJWT["sub"],
                //      timestamp: DateTime.now().toString()
                //    );
                //   databaseHelper.insertUserSQL(payload);
            
                
                //print(item.firebaseToken);
                // _save();
                // _read();
                
                



                                 // }  
                
              },
            ),
            FlatButton(
              child: Text('ไม่ถูกต้อง',style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.red,
                        fontWeight: FontWeight.bold
              )),
              onPressed: () { 
                _delete();
                Navigator.of(context).pop();
              },
            )
          ],
          );
        });
 }




void _loading(BuildContext context){
  showDialog(
    context: context,
    //barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("กำลังดำเนินการ...",
                    style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                    ),
                    textAlign: TextAlign.center,
                    ),
            backgroundColor: Color.fromARGB(255, 10, 22, 37),       
            content:
              Container(
                child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                ]              
                )
              )          
        );  
      }
  );
}




void _errorDialog(BuildContext context){
  showDialog(
    context: context,
    //barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("เกิดข้อผิดพลาด !",
                    style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                    ),
                    textAlign: TextAlign.center,
                    ),
            backgroundColor: Color.fromARGB(255, 10, 22, 37),
            content: Text('การลงทะเบียนผิดพลาด',style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: 16,
                    color: Colors.white
                    ),),
            actions: <Widget>[
            FlatButton(
              child: Text('ยกเลิก',style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,                        
                        color: Colors.red,
                        fontWeight: FontWeight.bold
              )),
              onPressed: (){ Navigator.of(context).pop(); },
          )
        ]
        );
      } 
  );
}


getHttpOnCloudFuntion(StoredAccessToken accessToken,payload) async{
  var client = http.Client();
  //print(payload);
  try{
    resultFromCloudFuntion = await client.post('https://us-central1-pty7skusrc.cloudfunctions.net/createCustomToken',
    body: {
      'access_token' : accessToken.data["access_token"],
      'email' : payload["email"],
      'name' : payload["name"],
      'picture' : payload["picture"],
      'id' : payload["sub"]
    });
  }finally{    
    client.close();
  }
}

decodeJWT(StoredAccessToken accessToken){
  final parts = accessToken.data["id_token"].split('.');
  //print(phoneumberController.text);
  final payload = parts[1];
  final decoded = json.decode(B64urlEncRfc7515.decodeUtf8(payload));
  return decoded;
}

_read() async {
        DatabaseHelper helper = DatabaseHelper.instance;
        int rowId = 1;
        UserSQL user = await helper.queryUser(rowId);
        if (user == null) {
          print('read row $rowId: empty');
          checkDataFromSQL = false;
          return;
        } else {
          firebaseTokenFromSQL = user.firebaseToken;
          nameFromSQL = user.name;
          ageFromSQL = user.age;
          phonenumberFromSQL = user.phonenumber;
          uidLineFromSQL = user.uidLine;
          timestampFromSQL = user.timestamp;
          urlImagesFromSQL = user.urlImages;
          print('row $rowId: ${user.firebaseToken} ${user.name} ${user.age} ${user.uidLine} ${user.timestamp} ${user.urlImages}');
          checkDataFromSQL = true;
          return;
        }
}

_save(String firebaseToken, String name, String age, String phonenumber, String uidLine, String timestamp, String urlImages) async {
        UserSQL user = UserSQL();
        user.firebaseToken = firebaseToken;
        user.name = name;
        user.age = age;
        user.phonenumber = phonenumber;
        user.uidLine = uidLine;
        user.timestamp = timestamp;
        user.urlImages = urlImages;
        DatabaseHelper helper = DatabaseHelper.instance;
        int id = await helper.insert(user);
        //print('inserted row: $id');
}

_delete() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    int user = await helper.deleteUser();
    print('delete !');
    return user;
}

_addDataToFirebase() async{
  await FirebaseDatabase.instance.reference().child('/teacher/${phonenumberFromSQL}').set({
    'name':nameFromSQL,
    'age':ageFromSQL,
    'phonumber':int.parse(phonenumberFromSQL),
    'sex':'male',
    'last_weight':0,
    'last_height':0,
    'last_bmi':0,
    'last_body_fat':0,
    'last_basal_metabolism':0,
    'last_muscle_mass':0,
    'last_bone_mass':0,
    'last_water':0,
    'last_visceral_fat':0
  });
}


// void saveUserSQL(payload) async{
//   usersql.tokenFirebase = payload.tokenfirebase;
//   usersql.name = payload.name;
//   usersql.age = payload.age;
//   usersql.phonenumber = payload.phonenumber;
//   usersql.uidLine = payload.sub; 
//   usersql.date =  DateFormat.yMMMd().format(DateTime.now());

// }
