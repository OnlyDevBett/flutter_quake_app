import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Map _quakes;
List _features;

void main() async {
  _quakes = await getQuakes();
  _features = _quakes['features'];
  print(_quakes['features']);
  runApp(new MaterialApp(
    color: Colors.white,
    title: 'Quakes App',
    home: new Quakes(),
  ));
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Quakes'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index = position ~/ 2;
              return new ListTile(
                title: new Text(
                  "${_features[index]['properties']['title']}",
                  style: new TextStyle(fontSize: 19.5, color: Colors.black),
                ),
                subtitle: new Text(
                  "${_features[index]['properties']['place']}",
                  style: new TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
                leading: new CircleAvatar(
                  backgroundColor: Colors.red,
                  child: new Text("${_features[index]['properties']['mag']}",
                  style: new TextStyle(color: Colors.white ),),
                ),
              );
            }),
      ),
    );
  }
}

Future<Map> getQuakes() async {
  String apiUrl =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiUrl);
  return jsonDecode(response.body);
}
