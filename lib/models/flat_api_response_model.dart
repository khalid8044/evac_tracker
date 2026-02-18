

class FlatApiResponseModel {
  final int? next;
  final int? prev;
  final int count;
  final int totalPages;
  final int pageNumber;
  final int perPage;
  final int from;
  final int to;
  final List<ResultResident> results;

  FlatApiResponseModel({
    required this.next,
    required this.prev,
    required this.count,
    required this.totalPages,
    required this.pageNumber,
    required this.perPage,
    required this.from,
    required this.to,
    required this.results,
  });

  factory FlatApiResponseModel.fromJson(Map<String, dynamic> json) {
    return FlatApiResponseModel(
      next: json['next'],
      prev: json['prev'],
      count: json['count'],
      totalPages: json['total_pages'],
      pageNumber: json['page_number'],
      perPage: json['per_page'],
      from: json['from'],
      to: json['to'],
      results: List<ResultResident>.from(
          json['results'].map((result) => ResultResident.fromJson(result))),
    );
  }
}

class ResultResident {
  final int id;
  final UserData userData;
  final FlatData flatData;
  final FloorData floorData;
  final BuildingData buildingData;
  final List<dynamic> days;
  final String userType;
  final bool isCurrent;
  final DateTime? arrivalTime;
  final DateTime? departureTime;
  final bool isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int user;
  final int flat;
  final int floor;
  final int updatedBy;
  bool isLoading;

  ResultResident({
    required this.id,
    required this.userData,
    required this.flatData,
    required this.floorData,
    required this.buildingData,
    required this.days,
    required this.userType,
    required this.isCurrent,
    required this.arrivalTime,
    required this.departureTime,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.flat,
    required this.floor,
    required this.updatedBy,
    this.isLoading = false,
  });

  factory ResultResident.fromJson(Map<String, dynamic> json) {
    return ResultResident(
      id: json['id'],
      userData: UserData.fromJson(json['user_data']),
      flatData: FlatData.fromJson(json['flat_data']),
      floorData: FloorData.fromJson(json['floor_data']),
      buildingData: BuildingData.fromJson(json['building_data']),
      days: json['days'],
      userType: json['user_type'],
      isCurrent: json['is_current'],
      arrivalTime: json['arrival_time'] != null
          ? DateTime.parse(json['arrival_time'])
          : null,
      departureTime: json['departure_time'] != null
          ? DateTime.parse(json['departure_time'])
          : null,
      isApproved: json['is_approved'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'],
      flat: json['flat'],
      floor: json['floor'],
      updatedBy: json['updated_by'],
      isLoading: false,
    );
  }

  // copyWith method for creating a copy with modified fields
  ResultResident copyWith({
    int? id,
    UserData? userData,
    FlatData? flatData,
    FloorData? floorData,
    BuildingData? buildingData,
    List<dynamic>? days,
    String? userType,
    bool? isCurrent,
    DateTime? arrivalTime,
    DateTime? departureTime,
    bool? isApproved,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? user,
    int? flat,
    int? floor,
    int? updatedBy,
    bool? isLoading,
  }) {
    return ResultResident(
      id: id ?? this.id,
      userData: userData ?? this.userData,
      flatData: flatData ?? this.flatData,
      floorData: floorData ?? this.floorData,
      buildingData: buildingData ?? this.buildingData,
      days: days ?? this.days,
      userType: userType ?? this.userType,
      isCurrent: isCurrent ?? this.isCurrent,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureTime: departureTime ?? this.departureTime,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      flat: flat ?? this.flat,
      floor: floor ?? this.floor,
      updatedBy: updatedBy ?? this.updatedBy,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class UserData {
  final int id;
  final String username;
  final String name;
  final String mobileNumber;

  UserData({
    required this.id,
    required this.username,
    required this.name,
    required this.mobileNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      mobileNumber: json['mobile_number'],
    );
  }
}

class FlatData {
  final int id;
  final String name;
  final String building;

  FlatData({
    required this.id,
    required this.name,
    required this.building,
  });

  factory FlatData.fromJson(Map<String, dynamic> json) {
    return FlatData(
      id: json['id'],
      name: json['name'],
      building: json['building'],
    );
  }
}

class FloorData {
  final int id;
  final String name;
  final String building;

  FloorData({
    required this.id,
    required this.name,
    required this.building,
  });

  factory FloorData.fromJson(Map<String, dynamic> json) {
    return FloorData(
      id: json['id'],
      name: json['name'],
      building: json['building'],
    );
  }
}

class BuildingData {
  final int id;
  final String name;

  BuildingData({
    required this.id,
    required this.name,
  });

  factory BuildingData.fromJson(Map<String, dynamic> json) {
    return BuildingData(
      id: json['id'],
      name: json['name'],
    );
  }
}
