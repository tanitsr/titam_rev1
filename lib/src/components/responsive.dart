import 'package:flutter/material.dart';

double width(BuildContext context,double size){
    double calWidth = MediaQuery.of(context).size.width;
    return (calWidth*size)/100;
} 
double hight(BuildContext context,double size){
    double calWidth = MediaQuery.of(context).size.height;
    return (calWidth*size)/100;
} 
