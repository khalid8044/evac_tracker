class FlatApiResponsePermanentContractorModel {
  final dynamic next;
  final dynamic prev;
  final int count;
  final int totalPages;
  final int pageNumber;
  final int perPage;
  final int from;
  final int to;
  final List<PermanentContractorResult> results;

  FlatApiResponsePermanentContractorModel({
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

  factory FlatApiResponsePermanentContractorModel.fromJson(
      Map<String, dynamic> json) {
    return FlatApiResponsePermanentContractorModel(
      next: json['next'],
      prev: json['prev'],
      count: json['count'],
      totalPages: json['total_pages'],
      pageNumber: json['page_number'],
      perPage: json['per_page'],
      from: json['from'],
      to: json['to'],
      results: (json['results'] as List)
          .map((result) => PermanentContractorResult.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'next': next,
      'prev': prev,
      'count': count,
      'total_pages': totalPages,
      'page_number': pageNumber,
      'per_page': perPage,
      'from': from,
      'to': to,
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class PermanentContractorResult {
  final int id;
  final UserData userData;
  final FlatData? flatData;
  final FloorData floorData;
  final BuildingData buildingData;
  final List<String>? days;
  final String userType;
  final bool isCurrent;
  final String? arrivalTime;
  final String departureTime;
  final bool isApproved;
  final String createdAt;
  final String updatedAt;
  final int user;
  final int? flat;
  final int floor;
  final int updatedBy;
  final bool isLoading; // New property with default value

  PermanentContractorResult({
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
    this.isLoading = false, // Default value
  });

  factory PermanentContractorResult.fromJson(Map<String, dynamic> json) {
    return PermanentContractorResult(
      id: json['id'],
      userData: UserData.fromJson(json['user_data']),
      flatData: json['flat_data'] != null
          ? FlatData.fromJson(json['flat_data'] as Map<String, dynamic>)
          : null,
      floorData: FloorData.fromJson(json['floor_data']),
      buildingData: BuildingData.fromJson(json['building_data']),
      days: List<String>.from(json['days']),
      userType: json['user_type'],
      isCurrent: json['is_current'],
      arrivalTime: json['arrival_time'],
      departureTime: json['departure_time'],
      isApproved: json['is_approved'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
      flat: json['flat'],
      floor: json['floor'],
      updatedBy: json['updated_by'],
      isLoading: json['is_loading'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_data': userData.toJson(),
      'flat_data': flatData?.toJson(),
      'floor_data': floorData.toJson(),
      'building_data': buildingData.toJson(),
      'days': days,
      'user_type': userType,
      'is_current': isCurrent,
      'arrival_time': arrivalTime,
      'departure_time': departureTime,
      'is_approved': isApproved,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
      'flat': flat,
      'floor': floor,
      'updated_by': updatedBy,
      'is_loading': isLoading,
    };
  }

  // Implementation of the copyWith method
  PermanentContractorResult copyWith({
    int? id,
    UserData? userData,
    FlatData? flatData,
    FloorData? floorData,
    BuildingData? buildingData,
    List<String>? days,
    String? userType,
    bool? isCurrent,
    String? arrivalTime,
    String? departureTime,
    bool? isApproved,
    String? createdAt,
    String? updatedAt,
    int? user,
    int? flat,
    int? floor,
    int? updatedBy,
    bool? isLoading,
  }) {
    return PermanentContractorResult(
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'mobile_number': mobileNumber,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'building': building,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'building': building,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
