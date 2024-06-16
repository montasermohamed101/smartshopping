class HandleWishlistAddRemoveResponseModel {
  final String message;
  final Results results;

  HandleWishlistAddRemoveResponseModel({
    required this.message,
    required this.results,
  });

  factory HandleWishlistAddRemoveResponseModel.fromJson(
          Map<String, dynamic> json) =>
      HandleWishlistAddRemoveResponseModel(
        message: json["message"],
        results: Results.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "results": results.toJson(),
      };
}

class Results {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String role;
  final bool isActive;
  final List<String> wishList;
  final bool verified;
  final List<dynamic> address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Results({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.isActive,
    required this.wishList,
    required this.verified,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
        isActive: json["isActive"],
        wishList: List<String>.from(json["wishList"].map((x) => x)),
        verified: json["verified"],
        address: List<dynamic>.from(json["address"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "role": role,
        "isActive": isActive,
        "wishList": List<dynamic>.from(wishList.map((x) => x)),
        "verified": verified,
        "address": List<dynamic>.from(address.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
