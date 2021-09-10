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
  var _isError = [-1];
  bool _check = false;

  dynamic res = <String, dynamic>{};
  var data;
  @override
  initState() {
    super.initState();
    read();
  }

  Future<void> read() async {
    res = await jsonToMap('data/teammates.json');
    setState(() {
      _check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _check ? data = res["data"]["getTeammates"]["items"] : data = null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casting'),
        backgroundColor: Color(0xff6A290F),
      ),
      body: _check
          ? ListView.builder(
              itemCount: int.parse(res["data"]["getTeammates"]["count"]),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        _isError.contains(index) ? Colors.grey : null,
                    backgroundImage: AssetImage(data[index]["profilPic"]),
                    child: _isError.contains(index)
                        ? Text(
                            data[index]["firstname"][0] +
                                data[index]["lastname"][0],
                            style: TextStyle(color: Colors.black),
                          )
                        : null,
                    onBackgroundImageError: (_, __) {
                      setState(() {
                        _isError.insert(_isError.length, index);
                      });
                    },
                  ),
                  title: Text(data[index]["firstname"]),
                  subtitle: Text(data[index]["lastname"]),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () async {
                    if (data[index]["url_link"] != null) {
                      await launch(data[index]["url_link"],
                          forceSafariVC: false);
                    }
                  },
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                "Loding",
                style: TextStyle(fontSize: 50),
              )),
    );
  }
}
