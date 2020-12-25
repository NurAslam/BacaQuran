import 'package:flutter/material.dart';

class TerjemahanRead extends StatelessWidget {
  //DEFINISIKAN VARIABLE DARI INFORMAIS YANG DIBUTUHKAN
  final int ayatNumber;
  final String ayatText;

  //BUAT CONSTRUCTOR UNTUK MEMINTA DATA
  TerjemahanRead(this.ayatNumber, this.ayatText);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Text('$ayatNumber'), 
      subtitle: Text('$ayatText', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    );
  }
}
