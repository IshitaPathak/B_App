import "dart:convert";
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadData() async {
  var jsonData = await rootBundle.loadString("assets/data.json");
  Map<String, dynamic> data = jsonDecode(jsonData);
  return data;
}
