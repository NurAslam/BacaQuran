import 'package:flutter/foundation.dart';

class Quran {
  //DEFINISIKAN VARIABLENYA BESERTA TIPE DATANYA
  final int id;
  final String name;
  final String arab;
  final String translate;
  final int countAyat;

  //BUAT CONSTRUCTOR DIMANA KETIKA CLASS INI DI-LOAD
  //  MAKA WAJIB MENGIRIMKAN DATA YANG DIMINTA
  Quran(
      {@required this.id,
      @required this.name,
      @required this.arab,
      @required this.translate,
      @required this.countAyat});
}
