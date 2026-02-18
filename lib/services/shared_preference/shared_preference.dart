import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreference {

 Future<int?>? readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getInt(key) == null){
      return null;
    }else{
      return prefs.getInt(key)!;
    }
  }
  Future<String> readIntString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getInt(key) == null){
      return "";
    }else{
      return prefs.getInt(key)!.toString();
    }
  }

  Future readJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString(key)==null){
      return null;
    }else{
      return json.decode(prefs.getString(key)!);
    }
  }

  Future<void> saveJson(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<void> saveInt(String key, value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  Future<void> saveString(String key, value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
  Future<void> saveBool(String key, value) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(key, value);
  }
  Future<String> readString(String key) async {
    final pref = await SharedPreferences.getInstance();
    if(pref.getString(key) != null) {
      return pref.getString(key)??"";
    }
    else{
      return "";
    }
  }
  Future<bool> readBool(String key) async {
    final pref = await SharedPreferences.getInstance();
    if(pref.getBool(key) != null) {
      return pref.getBool(key)??false;
    }
    else{
      return false;
    }
  }

 Future<void> addBuildingId(String key, String buildingId) async {
   List<String> buildingIds = await readStringList(key);
   String idString = buildingId.toString();
   if (!buildingIds.contains(idString)) {
     buildingIds.add(idString);
     await saveStringList(key, buildingIds);
   }
 }

 Future<void> removeBuildingId(String key, String buildingId) async {
   List<String> buildingIds = await readStringList(key);
   String idString = buildingId.toString();
   if (buildingIds.contains(idString)) {
     buildingIds.remove(idString);
     await saveStringList(key, buildingIds);
   }
 }

 Future<void> saveStringList(String key, List<String> value) async {
   final prefs = await SharedPreferences.getInstance();
   prefs.setStringList(key, value);
 }

 Future<List<String>> readStringList(String key) async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getStringList(key) ?? [];
 }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}