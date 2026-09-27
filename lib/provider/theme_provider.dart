import 'package:flutter/material.dart';

class SetTheme extends ChangeNotifier{
  Brightness bright = Brightness.light;

  void themeSet(){
    if(bright == Brightness.light){
      bright = Brightness.dark;
    }else{
      bright = Brightness.light;
    }
    notifyListeners();
  }
}
