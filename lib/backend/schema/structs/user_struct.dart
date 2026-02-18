// ignore_for_file: unnecessary_getters_setters

import '../../../flutter_flow/nav/serialization_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserStruct extends BaseStruct {
  UserStruct({
    String? displayName,
    String? mobileNumber,
    String? emailAddress,
    bool? isPeep,
    String? photo,
    bool? isVisitor,
    int? uid,
    String? userType,
    DateTime? arrivalTime,
    DateTime? departureTime,
    String? createTime,
  })  : _displayName = displayName,
        _mobileNumber = mobileNumber,
        _emailAddress = emailAddress,
        _isPeep = isPeep,
        _photo = photo,
        _isVisitor = isVisitor,
        _uid = uid,
        _userType = userType,
        _arrivalTime = arrivalTime,
        _departureTime = departureTime,
        _createTime = createTime;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  set displayName(String? val) => _displayName = val;

  bool hasDisplayName() => _displayName != null;

  // "mobileNumber" field.
  String? _mobileNumber;
  String get mobileNumber => _mobileNumber ?? '';
  set mobileNumber(String? val) => _mobileNumber = val;

  bool hasMobileNumber() => _mobileNumber != null;

  // "emailAddress" field.
  String? _emailAddress;
  String get emailAddress => _emailAddress ?? '';
  set emailAddress(String? val) => _emailAddress = val;

  bool hasEmailAddress() => _emailAddress != null;

  // "isPeep" field.
  bool? _isPeep;
  bool get isPeep => _isPeep ?? false;
  set isPeep(bool? val) => _isPeep = val;

  bool hasIsPeep() => _isPeep != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  set photo(String? val) => _photo = val;

  bool hasPhoto() => _photo != null;

  // "isVisitor" field.
  bool? _isVisitor;
  bool get isVisitor => _isVisitor ?? false;
  set isVisitor(bool? val) => _isVisitor = val;

  bool hasIsVisitor() => _isVisitor != null;

  // "uid" field.
  int? _uid;
  int get uid => _uid ?? 0;
  set uid(int? val) => _uid = val;

  void incrementUid(int amount) => uid = uid + amount;

  bool hasUid() => _uid != null;

  // "userType" field.
  String? _userType;
  String get userType => _userType ?? '';
  set userType(String? val) => _userType = val;

  bool hasUserType() => _userType != null;

  // "arrival_time" field.
  DateTime? _arrivalTime;
  DateTime? get arrivalTime => _arrivalTime;
  set arrivalTime(DateTime? val) => _arrivalTime = val;

  bool hasArrivalTime() => _arrivalTime != null;

  // "departure_time" field.
  DateTime? _departureTime;
  DateTime? get departureTime => _departureTime;
  set departureTime(DateTime? val) => _departureTime = val;

  bool hasDepartureTime() => _departureTime != null;

  // "create_time" field.
  String? _createTime;
  String get createTime => _createTime ?? '';
  set createTime(String? val) => _createTime = val;

  bool hasCreateTime() => _createTime != null;

  static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
        displayName: data['display_name'] as String?,
        mobileNumber: data['mobileNumber'] as String?,
        emailAddress: data['emailAddress'] as String?,
        isPeep: data['isPeep'] as bool?,
        photo: data['photo'] as String?,
        isVisitor: data['isVisitor'] as bool?,
        uid: castToType<int>(data['uid']),
        userType: data['userType'] as String?,
        arrivalTime: data['arrival_time'] as DateTime?,
        departureTime: data['departure_time'] as DateTime?,
        createTime: data['create_time'] as String?,
      );

  static UserStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'display_name': _displayName,
        'mobileNumber': _mobileNumber,
        'emailAddress': _emailAddress,
        'isPeep': _isPeep,
        'photo': _photo,
        'isVisitor': _isVisitor,
        'uid': _uid,
        'userType': _userType,
        'arrival_time': _arrivalTime,
        'departure_time': _departureTime,
        'create_time': _createTime,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'display_name': serializeParam(
          _displayName,
          ParamType.String,
        ),
        'mobileNumber': serializeParam(
          _mobileNumber,
          ParamType.String,
        ),
        'emailAddress': serializeParam(
          _emailAddress,
          ParamType.String,
        ),
        'isPeep': serializeParam(
          _isPeep,
          ParamType.bool,
        ),
        'photo': serializeParam(
          _photo,
          ParamType.String,
        ),
        'isVisitor': serializeParam(
          _isVisitor,
          ParamType.bool,
        ),
        'uid': serializeParam(
          _uid,
          ParamType.int,
        ),
        'userType': serializeParam(
          _userType,
          ParamType.String,
        ),
        'arrival_time': serializeParam(
          _arrivalTime,
          ParamType.DateTime,
        ),
        'departure_time': serializeParam(
          _departureTime,
          ParamType.DateTime,
        ),
        'create_time': serializeParam(
          _createTime,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserStruct(
        displayName: deserializeParam(
          data['display_name'],
          ParamType.String,
          false,
        ),
        mobileNumber: deserializeParam(
          data['mobileNumber'],
          ParamType.String,
          false,
        ),
        emailAddress: deserializeParam(
          data['emailAddress'],
          ParamType.String,
          false,
        ),
        isPeep: deserializeParam(
          data['isPeep'],
          ParamType.bool,
          false,
        ),
        photo: deserializeParam(
          data['photo'],
          ParamType.String,
          false,
        ),
        isVisitor: deserializeParam(
          data['isVisitor'],
          ParamType.bool,
          false,
        ),
        uid: deserializeParam(
          data['uid'],
          ParamType.int,
          false,
        ),
        userType: deserializeParam(
          data['userType'],
          ParamType.String,
          false,
        ),
        arrivalTime: deserializeParam(
          data['arrival_time'],
          ParamType.DateTime,
          false,
        ),
        departureTime: deserializeParam(
          data['departure_time'],
          ParamType.DateTime,
          false,
        ),
        createTime: deserializeParam(
          data['create_time'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserStruct &&
        displayName == other.displayName &&
        mobileNumber == other.mobileNumber &&
        emailAddress == other.emailAddress &&
        isPeep == other.isPeep &&
        photo == other.photo &&
        isVisitor == other.isVisitor &&
        uid == other.uid &&
        userType == other.userType &&
        arrivalTime == other.arrivalTime &&
        departureTime == other.departureTime &&
        createTime == other.createTime;
  }

  @override
  int get hashCode => const ListEquality().hash([
        displayName,
        mobileNumber,
        emailAddress,
        isPeep,
        photo,
        isVisitor,
        uid,
        userType,
        arrivalTime,
        departureTime,
        createTime
      ]);
}

UserStruct createUserStruct({
  String? displayName,
  String? mobileNumber,
  String? emailAddress,
  bool? isPeep,
  String? photo,
  bool? isVisitor,
  int? uid,
  String? userType,
  DateTime? arrivalTime,
  DateTime? departureTime,
  String? createTime,
}) =>
    UserStruct(
      displayName: displayName,
      mobileNumber: mobileNumber,
      emailAddress: emailAddress,
      isPeep: isPeep,
      photo: photo,
      isVisitor: isVisitor,
      uid: uid,
      userType: userType,
      arrivalTime: arrivalTime,
      departureTime: departureTime,
      createTime: createTime,
    );
