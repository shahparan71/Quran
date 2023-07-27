import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:quran/util/Constant.dart';
import 'package:quran/util/SharedPreferencesRepository.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({Key? key}) : super(key: key);

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
        ),
      ),
      body: SwitchExample(),
    );
  }
}

class SwitchExample extends StatefulWidget {
  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {

  bool bangla = SharedPreferencesRepository.getBool(Constant.BANGLA) ;

  bool arabic = SharedPreferencesRepository.getBool(Constant.ARABIC);

  bool english = SharedPreferencesRepository.getBool(Constant.ENGLISH) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text(
          "Select Language",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bangla",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
            ),
            Switch(
              splashRadius: 20,
              // This bool value toggles the switch.
              value: bangla,
              activeColor: Colors.amber,
              inactiveThumbColor: Colors.black38,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  bangla = value;
                  SharedPreferencesRepository.putBool(Constant.BANGLA, bangla);
                });
              },
              activeTrackColor: Colors.green,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "English",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
            ),
            Switch(
              splashRadius: 20,
              // This bool value toggles the switch.
              value: english,
              activeColor: Colors.amber,
              inactiveThumbColor: Colors.black38,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  english = value;
                  SharedPreferencesRepository.putBool(Constant.ENGLISH, english);
                });
              },
              activeTrackColor: Colors.green,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Arabic",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
            ),
            Switch(
              splashRadius: 20,
              // This bool value toggles the switch.
              value: arabic,
              activeColor: Colors.amber,
              inactiveThumbColor: Colors.black38,
              inactiveTrackColor: Colors.black12,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  arabic = value;
                  SharedPreferencesRepository.putBool(Constant.ARABIC, arabic);
                });
              },
              activeTrackColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}
