// ignore_for_file: unnecessary_getters_setters

import '../../../flutter_flow/nav/serialization_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BuildingStruct extends BaseStruct {
  BuildingStruct({
    int? buildingID,
    String? buildingName,
    int? floorID,
    String? floorName,
    int? roomID,
    String? roomName,
  })  : _buildingID = buildingID,
        _buildingName = buildingName,
        _floorID = floorID,
        _floorName = floorName,
        _roomID = roomID,
        _roomName = roomName;

  // "buildingID" field.
  int? _buildingID;
  int get buildingID => _buildingID ?? 0;
  set buildingID(int? val) => _buildingID = val;

  void incrementBuildingID(int amount) => buildingID = buildingID + amount;

  bool hasBuildingID() => _buildingID != null;

  // "buildingName" field.
  String? _buildingName;
  String get buildingName => _buildingName ?? '';
  set buildingName(String? val) => _buildingName = val;

  bool hasBuildingName() => _buildingName != null;

  // "FloorID" field.
  int? _floorID;
  int get floorID => _floorID ?? 0;
  set floorID(int? val) => _floorID = val;

  void incrementFloorID(int amount) => floorID = floorID + amount;

  bool hasFloorID() => _floorID != null;

  // "floorName" field.
  String? _floorName;
  String get floorName => _floorName ?? '';
  set floorName(String? val) => _floorName = val;

  bool hasFloorName() => _floorName != null;

  // "roomID" field.
  int? _roomID;
  int get roomID => _roomID ?? 0;
  set roomID(int? val) => _roomID = val;

  void incrementRoomID(int amount) => roomID = roomID + amount;

  bool hasRoomID() => _roomID != null;

  // "roomName" field.
  String? _roomName;
  String get roomName => _roomName ?? '';
  set roomName(String? val) => _roomName = val;

  bool hasRoomName() => _roomName != null;

  static BuildingStruct fromMap(Map<String, dynamic> data) => BuildingStruct(
        buildingID: castToType<int>(data['buildingID']),
        buildingName: data['buildingName'] as String?,
        floorID: castToType<int>(data['FloorID']),
        floorName: data['floorName'] as String?,
        roomID: castToType<int>(data['roomID']),
        roomName: data['roomName'] as String?,
      );

  static BuildingStruct? maybeFromMap(dynamic data) =>
      data is Map ? BuildingStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'buildingID': _buildingID,
        'buildingName': _buildingName,
        'FloorID': _floorID,
        'floorName': _floorName,
        'roomID': _roomID,
        'roomName': _roomName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'buildingID': serializeParam(
          _buildingID,
          ParamType.int,
        ),
        'buildingName': serializeParam(
          _buildingName,
          ParamType.String,
        ),
        'FloorID': serializeParam(
          _floorID,
          ParamType.int,
        ),
        'floorName': serializeParam(
          _floorName,
          ParamType.String,
        ),
        'roomID': serializeParam(
          _roomID,
          ParamType.int,
        ),
        'roomName': serializeParam(
          _roomName,
          ParamType.String,
        ),
      }.withoutNulls;

  static BuildingStruct fromSerializableMap(Map<String, dynamic> data) =>
      BuildingStruct(
        buildingID: deserializeParam(
          data['buildingID'],
          ParamType.int,
          false,
        ),
        buildingName: deserializeParam(
          data['buildingName'],
          ParamType.String,
          false,
        ),
        floorID: deserializeParam(
          data['FloorID'],
          ParamType.int,
          false,
        ),
        floorName: deserializeParam(
          data['floorName'],
          ParamType.String,
          false,
        ),
        roomID: deserializeParam(
          data['roomID'],
          ParamType.int,
          false,
        ),
        roomName: deserializeParam(
          data['roomName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'BuildingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BuildingStruct &&
        buildingID == other.buildingID &&
        buildingName == other.buildingName &&
        floorID == other.floorID &&
        floorName == other.floorName &&
        roomID == other.roomID &&
        roomName == other.roomName;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([buildingID, buildingName, floorID, floorName, roomID, roomName]);
}

BuildingStruct createBuildingStruct({
  int? buildingID,
  String? buildingName,
  int? floorID,
  String? floorName,
  int? roomID,
  String? roomName,
}) =>
    BuildingStruct(
      buildingID: buildingID,
      buildingName: buildingName,
      floorID: floorID,
      floorName: floorName,
      roomID: roomID,
      roomName: roomName,
    );
