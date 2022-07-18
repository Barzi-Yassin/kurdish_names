// import 'dart:html';

// import 'dart:html';

// import 'dart:ui';

// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdish_names/src/kurdish_names/models/names_data_model.dart';
import 'package:kurdish_names/src/kurdish_names/services/kurdish_names_service.dart';

class KurdishNamesList extends StatefulWidget {
  const KurdishNamesList({Key? key}) : super(key: key);

  @override
  State<KurdishNamesList> createState() => _KurdishNamesListState();
}

class _KurdishNamesListState extends State<KurdishNamesList> {
  KurdishNamesService _namesService = KurdishNamesService();
  static List<String> genders = ["Male", "Female", "Both"];

  String gender = genders[0];
  // String _genderDropdownValue = genders[0]; // the error
  String _voteDropdownValue = "posative";
  String _limitDropdownValue = "10";

  String vote = "posative";
  String limit = "10";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: Text('نـاوی کــوردی',
            style: TextStyle(
                fontSize: 25, letterSpacing: 2, fontWeight: FontWeight.bold)),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                // hint: Text('Gender'),
                dropdownColor: Colors.white,
                value: gender,
                style: const TextStyle(color: Colors.blue),
                underline: const Divider(height: 0.7),
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      gender = newValue!;
                    },
                  );
                },
              ),
              DropdownButton<String>(
                // dropdownColor: Colors.blueAccent.shade200,
                dropdownColor: Colors.white,
                value: _voteDropdownValue,
                style: const TextStyle(color: Colors.blue),
                underline: const Divider(height: 0.7),
                items: <String>['posative', 'negative']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      _voteDropdownValue = newValue!;
                      switch (_voteDropdownValue) {
                        case 'posative':
                          {
                            vote = 'posative';
                            break;
                          }
                        case 'negative':
                          {
                            vote = 'negative';
                            break;
                          }
                      }
                    },
                  );
                },
              ),
              DropdownButton<String>(
                // dropdownColor: Colors.blueAccent.shade200,
                dropdownColor: Colors.white,
                value: _limitDropdownValue,
                style: const TextStyle(color: Colors.blue),
                underline: const Divider(height: 0.7),
                items: <String>['5', '10', '20', '50', '100']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(
                    () {
                      _limitDropdownValue = newValue!;
                      limit = newValue;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: FutureBuilder<KurdishNames>(
                future: _namesService.fetchListOfNames(
                  {
                    "limit": limit,
                    "gender": gender,
                    "offset": "0",
                    "sort": vote,
                  },
                ),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  } else if (snap.hasError) {
                    return SelectableText(snap.error.toString(),
                        style: const TextStyle(color: Colors.teal));
                  } else if (snap.data == null) {
                    return const Text('no data');
                  }
                  // return Text(snap.data.toString(), style: TextStyle(color: Color.fromARGB(255, 161, 134, 132)) );
                  return ListView.builder(
                    itemCount: snap.data!.names.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     border:
                        //         Border.all(color: Colors.white, width: 1)),
                        child: ListTile(
                          title: Text(
                            snap.data!.names[index].name,
                            style: const TextStyle(
                                fontSize: 20, letterSpacing: 2.0),
                          ),
                          leading: Text(
                            "${index + 1}",
                            style: TextStyle(
                                fontSize: 16.5,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.blue,
          height: 5,
          thickness: 5,
        ),
        SizedBox(
          height: 5,
        )
      ]),
    );
  }
}
