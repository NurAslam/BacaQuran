import 'package:flutter/foundation.dart';

class QuranAyatModel {
  final int ayatId;
  final int ayatNumber;
  final int surahId;
  final int juzId;
  final String ayatArab;
  final String ayatText;

  QuranAyatModel({
    @required this.ayatId,
    @required this.ayatNumber,
    @required this.surahId,
    @required this.juzId,
    @required this.ayatArab,
    @required this.ayatText,
  });
}