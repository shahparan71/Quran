import 'package:quran/db/DbManager.dart';
import 'package:quran/models/models.dart';

class CommonOperation {
  DBManage dbManage = new DBManage();

  Future<List<SuraName>> getData() async {
    List<Map> list = await dbManage.execute('SELECT * FROM surah_name');
    List<SuraName> listSuraName = [];

    for (var value in list) {
      print("Shah " + value['name_bangla'].toString());
      print("Shah " + value['name_arabic']);

      SuraName suraName = new SuraName();

      suraName.id = value['_id'];
      suraName.surah_no = value['surah_no'];
      suraName.arabic = value['name_arabic'];
      suraName.bangla = value['name_bangla'];
      suraName.english = value['name_english'];
      suraName.sura_mean_english = value['surah_mean_english'];
      suraName.ayah = value['ayah_number'].toString();
      suraName.type = value['type'];
      listSuraName.add(suraName);
    }
    print("shah333");
    return listSuraName;
  }

  Future<List<Quran>> suraDetails(SuraName? suraId) async {

    print(suraId?.surah_no);

    List<Map> list = await dbManage.execute('SELECT * FROM quran where surah_id=${suraId?.surah_no}');
    List<Quran> listSuraName = [];

    for (var value in list) {

      print("Shah " + value['verse_id'].toString());
      print("Shah " + value['arabic']);

      Quran quran = new Quran();

      quran.id = value['_id'];
      quran.surah_id = value['surah_id'];
      quran.verse_id = value['verse_id'];
      quran.arabic = value['arabic'];
      quran.bangla = value['bangla'];
      quran.english = value['english'];
      listSuraName.add(quran);
    }
    return listSuraName;
  }

}
