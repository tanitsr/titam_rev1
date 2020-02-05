import 'package:tittam_rev1/utils/database_helper.dart';
import 'package:tittam_rev1/src/components/responsive.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';


String firebaseTokenFromSQL = "";
String nameFromSQL = "";
String ageFromSQL = "";
String phonenumberFromSQL = "";
String uidLineFromSQL = "";
String timestampFromSQL = "";
String urlImagesFromSQL = "";
String nameFromFirebase = "";
String ageFromFirebase = "";
String weightFromFirebase = "";
String heightFromFirebase = "";
String bmiFromFirebase = "25.5";
String bodyfatFromFirebase = "";
String waterFromFirebase = "";
String bmrFromFirebase = "";
String vfatFromFirebase = "";
String boneFromFirebase = "";
String musclemassFromFirebase = "";


class DetailPage extends StatefulWidget {
  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage>{
  Map<dynamic, dynamic> list_user;
  void getToFirebase() async{
    await FirebaseDatabase.instance.reference().child('/teacher/${phonenumberFromSQL}').once().then((DataSnapshot dataSnapshot){
      list_user = dataSnapshot.value;
    });
    setState(() {
      nameFromFirebase = list_user['name'];
      ageFromFirebase = list_user['age'].toString();
      weightFromFirebase = list_user['last_weight'].toString();
      heightFromFirebase = list_user['last_height'].toString();
      bmiFromFirebase = list_user['last_bmi'].toString();
      bodyfatFromFirebase = list_user['last_body_fat'].toString();
      waterFromFirebase = list_user['last_water'].toString();
      bmrFromFirebase = list_user['last_basal_metabolism'].toString();
      vfatFromFirebase = list_user['last_visceral_fat'].toString();
      boneFromFirebase = list_user['last_bone_mass'].toString();
      musclemassFromFirebase = list_user['last_muscle_mass'].toString();
    });
  }


  @override
  void initState(){
    getToFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _read();
    getToFirebase();
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: () async{
          getToFirebase();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 5) 
                          ,left: width(context, 28)
                          ),
                          child: Text("ยินดีต้อนรับ",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  GestureDetector(
                    onTap: (){
                      _delete();
                    },
                    child: Container(
                    padding: EdgeInsets.only(top: hight(context, 7.5) 
                    ,left: width(context, 89)),
                    child: Image.asset('images/icon_share.png'),
                    ),
                  ),             
                  Container(
                    padding: EdgeInsets.only(top: hight(context, 8)
                    ,left: width(context, 6)),
                    child: Image.asset('images/icon_manu.png'),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: hight(context, 14),
                    left: width(context, 6)),
                    child: new Stack(
                      children: <Widget>[
                        Container(
                        decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2,color: Colors.grey)
                        ),
                        child : new ClipRRect(
                        borderRadius: new BorderRadius.circular(100.0),
                        child: Image.network(
                          urlImagesFromSQL,
                          height: 70.0,
                          width: 70.0,
                            ),
                          ),                  
                        ),
                        
                            ])
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 15) 
                          ,left: width(context, 30)
                          ),
                          child: Text("คุณ ${nameFromFirebase}",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 19) 
                          ,left: width(context, 30)
                          ),
                          child: Text("อายุ ${ageFromFirebase} ปี",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 29) 
                          ,left: width(context, 5)
                          ),
                          child: Text("น้ำหนัก",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 35) 
                          ,left: width(context, 5)
                          ),
                          child: Text('${weightFromFirebase} กก',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 43) 
                          ,left: width(context, 5)
                          ),
                          child: Text("ส่วนสูง",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 49) 
                          ,left: width(context, 5)
                          ),
                          child: Text('${heightFromFirebase} ซม',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 57) 
                          ,left: width(context, 5)
                          ),
                          child: Text("ดัชนีมวลกาย",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 63) 
                          ,left: width(context, 5)
                          ),
                          child: Text(bmiFromFirebase,
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 63) 
                          ,left: width(context, 40)
                          ),
                          child: Text("ม/กก",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 64) 
                          ,left: width(context, 48)
                          ),
                          child: Text("2",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 75) 
                          ,left: width(context, 5)
                          ),
                          child: Text("กระดูก",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 80) 
                          ,left: width(context, 5)
                          ),
                          child: Text('${boneFromFirebase} กก',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 75) 
                          ,left: width(context, 32)
                          ),
                          child: Text("กล้ามเนื้อ",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 80) 
                          ,left: width(context, 32)
                          ),
                          child: Text('${musclemassFromFirebase} กก',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 75) 
                          ,left: width(context, 65)
                          ),
                          child: Text("ไขมัน",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 80) 
                          ,left: width(context, 65)
                          ),
                          child: Text('${bodyfatFromFirebase} %',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 85) 
                          ,left: width(context, 5)
                          ),
                          child: Text("ไขมันใต้พุง",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 90) 
                          ,left: width(context, 5)
                          ),
                          child: Text(vfatFromFirebase,
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 85) 
                          ,left: width(context, 42)
                          ),
                          child: Text("BMR",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ))
                  ),
                  Container(
                          margin: EdgeInsets.only(top: hight(context, 90) 
                          ,left: width(context, 42)
                          ),
                          child: Text('${bmrFromFirebase} แคล',
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  ),
                  
                  Container(
                    padding: EdgeInsets.only(left: width(context, 75),
                    top: hight(context, 25)),
                    child: Image.asset(_showbmi(bmiFromFirebase),scale: 1.5,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: hight(context, 51) 
                          ,left: width(context, 74.5)
                          ),
                          child: Text(_detailbmi(bmiFromFirebase),
                          style: TextStyle(
                            fontFamily: 'Kanit',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ))
                  )
                ]
          ),
            ] 
        ),
        )
      )
      );
    }

String _showbmi(String data){
    var bmi = double.parse(data);
    String path="";  
    if (bmi < 18.5){
      path='images/body_under.png';
      return path;
    }
    else if (bmi > 18.5 && bmi <= 22.9){
      path='images/body_healthy.png';
      return path;
    }
    else if (bmi >= 23  && bmi <= 29.9){
      path='images/body_over.png';
      return path;
    }
    else if (bmi > 29.9){
      path='images/body_obese.png';
      return path;
    }
  }

  String _detailbmi(String data){
    var bmi = double.parse(data);
    String detail_bmi="";    
    if (bmi < 18.5){
      detail_bmi='ผอมไป';
      return detail_bmi;
    }
    else if (bmi > 18.5 && bmi <= 22.9){
      detail_bmi='สุขภาพดี';
      return detail_bmi;
    }
    else if (bmi >= 23  && bmi <= 29.9){
      detail_bmi='เริ่มอ้วน';
      return detail_bmi;
    }
    else if (bmi > 29.9){
      detail_bmi='อ้วนมาก';
      return detail_bmi;
    }
  }

  
}






_read() async {
        DatabaseHelper helper = DatabaseHelper.instance;
        int rowId = 1;
        UserSQL user = await helper.queryUser(rowId);
        if (user == null) {
          print('read row $rowId: empty');
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
          return true;
        }

  
}
_delete() async{
    DatabaseHelper helper = DatabaseHelper.instance;
    int user = await helper.deleteUser();
    print('delete !');
    return user;
}












