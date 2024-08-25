
class UserModel {
  final int id;
  final String phrase;
  final String address;
  final String password;

  UserModel({
    required this.id,
    required this.phrase,
    required this.address,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] as int,
        phrase: json['phrase'] as String,
        address: json['address'] as String,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'phrase': phrase,
        'address': address,
        'password': password,
      };

  UserModel copyWith({
    int? id,
    String? phrase,
    String? address,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      phrase: phrase ?? this.phrase,
      address: address ?? this.address,
      password: password ?? this.password,
    );
  }
}
