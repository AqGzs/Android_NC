class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String gender;
  final String dob;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.gender,
    required this.dob,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'gender': gender,
      'dob': dob,
    };
  }
}
