class CustomerModel {
  String email;
  String userName;
  String password;

  CustomerModel({
    this.email,
    this.userName,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.addAll({
      'email': email,
      'password': password,
      'username': email,
    });

    return map;
  }
}