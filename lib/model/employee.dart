class Employee {
  int? id;
  String name;
  String email;
  String password;
  String phone;
  Employee({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  // fromMap
  Employee.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'].toString(),
        email = map['email'].toString(),
        password = map['password'].toString(),
        phone = map['phone'].toString();
}
