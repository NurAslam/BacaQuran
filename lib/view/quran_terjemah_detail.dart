import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../viewmodel/quran_model.dart'; //IMPORT QURAN MODEL UNTUK MENGAMBIL DATA SURAH
import '../viewmodel/quran_ayat_model.dart'; //IMPORT MODEL BARU YANG NANTINYA AKAN KITA BUAT
import '../widget/terjemahan_read.dart';

class TerjemahDetail extends StatefulWidget {
  @override
  _TerjemahDetailState createState() => _TerjemahDetailState();
}

class _TerjemahDetailState extends State<TerjemahDetail> {
  //VARIABLE INI UNTUK MENG-HANDLE BOTTOM NAVIGATION (PREVIOUS = 0, PLAY = 1 DAN NEXT = 2)
  //VALUE DEFAULTNYA KITA SET 2 (NEXT)
  int bottomIndex = 2;
  int offset = 0; //OFFSET UNTUK MENANDAI BERAPA DATA YANG SUDAH DI-LOAD
  int totalData = 0; //UNTUK MENYIMPAN INFORMASI ID DATA TERAKHIR YANG DI-LOAD
  int id; //ID SURAH

  //KETIKA BOTTOM NAVIGATION DI-TAP MAKA AKAN MENJALANKAN FUNGSI INI

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments
        as int; //DAPATKAN ARGUMEN YANG DIKIRIMKAN DARI PAGE SEBELUMNYA
    //KEMUDIAN CARI DATA BERDASARKAN ID SURAH YANG DITERIMA
    final data = Provider.of<QuranData>(context, listen: false).findById(id);

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Aplikasi AlQuran"),
              Text(
                '${data.name} - ${data.arab}',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          //PERHATIKAN BAGIAN SEBELUMNYA, KITA TIDAK MENGGUNAKAN FUNGSI getDetail()
          //KARENA FUTURE BUILDER SECARA OTOMATIS AKAN BERJALAN KETIKA SCREEN DI-LOAD
          //DAN KETIKA USER TAP NEXT / PREVIOUS, KITA MENGGUNAKAN SET STATE YANG BERARTI WIDGET DI RE-RENDER, MAKA FUTURE BUILDER AKAN DIJALANKAN KEMBALI
          child: FutureBuilder(
            future: Provider.of<QuranAyat>(context, listen: false).getDetail(
                id,
                bottomIndex,
                offset,
                totalData), //SECARA OTOMATIS FUNGSI INI AKAN DIJALANKAN SETIAP KALI WIDGET BERUBAH UNTUK MENGAMBIL DATA BERDASARKAN ID SURAH, INDEX BOTTOM NAVIGATION DAN OFFSET YANG DI-REQUEST
            builder: (context, snapshot) {
              //KETIKA PROSES REQUEST BERLANGSUNG
              if (snapshot.connectionState == ConnectionState.waiting) {
                //MAKA PROGRESS LOADING DIJALANKAN
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //JIKA TERJADI ERROR
                if (snapshot.hasError) {
                  //MAKA INFORMASI ERROR DI RENDER
                  return Center(
                    child: Text("Error! Periksa Koneksi Anda"),
                  );
                } else {
                  //SELAIN ITU MAKA KITA RENDER ISI SURAH TERKAIT
                  return Consumer<QuranAyat>(
                    //MENGGUNAKAN CONSUMER UNTUK MENGAMBIL DATA STATE DAN LIST VIEW UNTUK RENDER CONTENT-NYA
                    builder: (ctx, data, _) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.items
                          .length, //LIST VIEW AKAN DIJALANKAN BERDASARKAN JUMLAH DATA
                      //LAGI LAGI KITA GUNAKAN CUSTOM WIDGET AGAR CODINGAN DIFILE INI TIDAK PANJANG, CLASS QuranRead() AKAN DIBUAT SELANJUTNYA.
                      itemBuilder: (ctx, i) => TerjemahanRead(
                        data.items[i].ayatNumber,
                        data.items[i].ayatText,
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ),
   );
  }
}
