import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quran/common_operation.dart';
import 'package:quran/models/SuraDetails.dart' as suraDt;
import 'package:quran/models/models.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:quran/util/Constant.dart';
import 'package:quran/util/SharedPreferencesRepository.dart';

class SuraDetails extends StatefulWidget {
  SuraName? suraN;

  SuraDetails({Key? key, this.suraN}) : super(key: key);

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> {
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = true; //

  bool bangla = SharedPreferencesRepository.getBool(Constant.BANGLA);

  bool arabic = SharedPreferencesRepository.getBool(Constant.ARABIC);

  bool english = SharedPreferencesRepository.getBool(Constant.ENGLISH);

  @override
  initState() {
    // this is called when the class is initialized or called for the first time
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print(widget.suraN!.surah_no);

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.

          title: Text(
            widget.suraN!.english.toString(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /*Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            onChanged: (value){

                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter ayah number',

                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text("Go"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),*/
              Container(
                height: MediaQuery.of(context).size.height - 130,
                child: FutureBuilder<List<Quran>?>(
                  future: CommonOperation().suraDetails(widget.suraN!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              color: index % 2 == 0 ? Colors.green.shade50 : Colors.green.shade100,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('assets/index_banner.png'),
                                              fit: BoxFit.fill,
                                            ),
                                            //shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                snapshot.data?[index].verse_id.toString() ?? "got null",
                                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                        ),

                                        /*Container(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                snapshot.data?[index].verse_id.toString() ?? "got null",
                                                style: TextStyle(fontSize: 18, color: Colors.white),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),

                                          decoration:  BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0.0),
                                                  bottomRight: Radius.circular(40.0),
                                                  topLeft: Radius.circular(0.0),
                                                  bottomLeft: Radius.circular(40.0)),
                                              color: Colors.green),
                                        ),*/
                                        arabic == false
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        snapshot.data?[index].arabic ?? "got null",
                                                        //"ABC",
                                                        style: TextStyle(fontSize: 18),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        bangla == false
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /*Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 10.0),
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if (isPlaying) {
                                                          var url = Uri.https('api.quran.gading.dev', '/surah/${widget.suraN!.surah_no}');

                                                          var response = await http.get(url);
                                                          if (response.statusCode == 200) {
                                                            var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
                                                            var itemCount = jsonResponse['message'];

                                                            suraDt.SurahDetails ss = suraDt.SurahDetails.fromJson(jsonResponse);

                                                            print('Number of books about http: ${index.toString()}');
                                                            String url = ss.data!.verses![index].audio!.primary!;

                                                            print('Number of books about http: ${url}');

                                                            await audioPlayer.play(UrlSource(url));
                                                            //await audioPlayer.play(AssetSource(url));

                                                            setState(() {});
                                                          }
                                                        } else {
                                                          if (audioPlayer != null) {
                                                            audioPlayer.stop();
                                                            isPlaying = false;
                                                            setState(() {});
                                                          }
                                                        }
                                                      },
                                                      child: Icon(Icons.volume_down)),
                                                ),
                                              ),
                                              */ /*decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(0.0),
                                                      bottomRight: Radius.circular(40.0),
                                                      topLeft: Radius.circular(0.0),
                                                      bottomLeft: Radius.circular(0.0)),
                                                  color: Colors.green),*/ /*
                                            ),*/
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        snapshot.data?[index].bangla ?? "got null",
                                                        //"ABC",
                                                        style: TextStyle(fontSize: 18),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        english == false
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  /*Container(
                                              width: 40,
                                              height: 40,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 10.0),
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                        if (isPlaying) {
                                                          var url = Uri.https('api.quran.gading.dev', '/surah/${widget.suraN!.surah_no}');

                                                          var response = await http.get(url);
                                                          if (response.statusCode == 200) {
                                                            var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
                                                            var itemCount = jsonResponse['message'];

                                                            suraDt.SurahDetails ss = suraDt.SurahDetails.fromJson(jsonResponse);

                                                            print('Number of books about http: ${index.toString()}');
                                                            String url = ss.data!.verses![index].audio!.primary!;

                                                            print('Number of books about http: ${url}');

                                                            await audioPlayer.play(UrlSource(url));
                                                            //await audioPlayer.play(AssetSource(url));

                                                            setState(() {});
                                                          }
                                                        } else {
                                                          if (audioPlayer != null) {
                                                            audioPlayer.stop();
                                                            isPlaying = false;
                                                            setState(() {});
                                                          }
                                                        }
                                                      },
                                                      child: Icon(Icons.volume_down)),
                                                ),
                                              ),
                                              */ /*decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(0.0),
                                                      bottomRight: Radius.circular(40.0),
                                                      topLeft: Radius.circular(0.0),
                                                      bottomLeft: Radius.circular(0.0)),
                                                  color: Colors.green),*/ /*
                                            ),*/
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        snapshot.data?[index].english ?? "got null",
                                                        //"ABC",
                                                        style: TextStyle(fontSize: 18),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      );
                    }

                    /// handles others as you did on question
                    else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
