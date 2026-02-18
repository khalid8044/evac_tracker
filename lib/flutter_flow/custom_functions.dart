import 'dart:convert';
import 'dart:math' as math;

import 'lat_lng.dart';

dynamic convertStringtoJSON(String? stringData) {
  // is there any error in my code?
  if (stringData == null) {
    return null;
  }
  try {
    return json.decode(stringData.replaceAll("'", '"'));
  } catch (e) {

    return null;
  }
}

int calculateRemainingTime(DateTime timeout) {
  // Get the current time
  final currentTime = DateTime.now();

  // Calculate the remaining time in milliseconds
  final remainingMilliseconds = timeout.difference(currentTime).inMilliseconds;

  // Return the remaining time in milliseconds, ensuring it's not negative
  return remainingMilliseconds > 0 ? remainingMilliseconds : 0;
}

List<LatLng>? convertStringToLatLng(
  List<String> latList,
  List<String> lngList,
) {
  List<LatLng> latLngList = [];

  for (int i = 0; i < math.min(latList.length, lngList.length); i++) {
    double latitude = double.tryParse(latList[i]) ?? 0.0;
    double longitude = double.tryParse(lngList[i]) ?? 0.0;
    latLngList.add(LatLng(latitude, longitude));
  }

  return latLngList;
}

String generateAddress(
  String? building,
  String? floor,
  String? apartment,
) {
  String address = '';
  if (building != null && building != 'null') {
    address += building;
  }

  if (floor != null && floor != 'null') {
    if (address.isNotEmpty) {
      address += ', ';
    }
    address += floor;
  }

  if (apartment != null && apartment != 'null') {
    if (address.isNotEmpty) {
      address += ', ';
    }
    address += apartment;
  }
  return address;
}

int calculateLogoutTimeInMS(
  DateTime loginTime,
  DateTime expectedTimeout,
) {
  int timeDifference =
      expectedTimeout.millisecondsSinceEpoch - loginTime.millisecondsSinceEpoch;

  // Return the time difference
  return timeDifference;
}

int calculatePopupTime(
  int expectedTimeoutInMS,
  int popupBeforeLogoutInMin,
) {
  return expectedTimeoutInMS - (popupBeforeLogoutInMin * 60000);
}

List<dynamic>? filteredAddressResults(
  String? selectedUserType,
  List<dynamic> addresses,
) {
  if (selectedUserType == null) {
    // If selectedUserType is null, return all addresses
    return addresses;
  }

  List<dynamic> filteredResults = addresses.where((item) {
    // Ensure that the item contains the 'user_type' key and it matches the selectedUserType
    return item['user_type'] == selectedUserType;
  }).toList();

  // Return the filtered results
  return filteredResults;
}

bool? isPasswordCompliant(String password, [int minLength = 6]) {
  if (password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasSpecialCharacters =
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits &
      hasUppercase &
      hasLowercase &
      hasSpecialCharacters &
      hasMinLength;
}

String? convertListToCommaSeparatedString(List<String>? list) {
  // Check if the list is null
  if (list == null || list.isEmpty) {
    return '';
  }
  return list.join(',');
}

List<String>? mapPinColors(List<String> slist) {
// Initialize an empty list to store the mapped items
  List<String> mappedList = [];

  // Loop through each item in the input list
  for (String item in slist) {
    // Check if the item is 'Primary' or 'Secondary'
    if (item == 'Primary') {
      mappedList.add('map-pin-red.png');
    } else if (item == 'Secondary') {
      mappedList.add('map-pin-green.png');
    }
  }

  return mappedList;
}
