class UserModel {
  int? id;

  String name;
  String email;
  String mobile;
  String dob;
  String gender;
  String city;
  String password;
  bool isFavorite;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.gender,
    required this.city,
    required this.password,
    this.isFavorite = false,
  });

  // Convert UserModel into Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'gender': gender,
      'city': city,
      'password': password,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  // Convert SQLite Map into UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      dob: map['dob'],
      gender: map['gender'],
      city: map['city'],
      password: map['password'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}