import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Map<String, dynamic>> jsonToMap(String path) async {
  Map<String, dynamic> localizedStrings;
  final String jsonString = await rootBundle.loadString(path);
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  localizedStrings = jsonMap.map((String key, dynamic value) {
    return MapEntry<String, dynamic>(key, value);
  });
  return localizedStrings;
}

class TeammatesModel extends StatefulWidget {
  TeammatesModel({Key? key}) : super(key: key);
  @override
  TeammatesModelState createState() => TeammatesModelState();
}

class TeammatesModelState extends State<TeammatesModel> {
  bool _isError = false;
  var res;
  var data;
  @override
  initState() {
    super.initState();
    read();
  }

  read() async {
    var read = await jsonToMap('data/teammates.json');
    setState(() {
      res = read;
    });
    data = res["data"]["getTeammates"]["items"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casting'),
        backgroundColor: Color(0xff6A290F),
      ),
      body: ListView.builder(
        itemCount: int.parse(res["data"]["getTeammates"]["count"]),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(data[index]["profilPic"]),
              backgroundColor: Colors.grey,
              onBackgroundImageError: (_, __) {
                setState(() {
                  this._isError = true;
                });
              },
            ),
            title: Text(data[index]["firstname"]),
            subtitle: Text(data[index]["lastname"]),
            trailing: Icon(Icons.chevron_right),
            onTap: () async {
              if (data[index]["url_link"] != null) {
                await launch(data[index]["url_link"], forceSafariVC: false);
              }
            },
          );
        },
      ),
    );
  }
}
