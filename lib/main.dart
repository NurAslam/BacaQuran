import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './view/quran_list.dart';
import './view/quran_detail.dart';

import './view/quran_terjemah_detail.dart';
import './viewmodel/quran_model.dart';
import './viewmodel/quran_ayat_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: QuranData(),
        ),
        ChangeNotifierProvider.value(
          value: QuranAyat(),
        )
      ],
      child: MaterialApp(
        title: 'Al Quran List ',
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DefaultTabController(length: 2, child: QuranList()),
        routes: {
          '/detail': (ctx) => QuranDetail(),
          '/terjemah' : (ctx) => TerjemahDetail(),
        },
      ),
    );
  }
}
