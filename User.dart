class User {
  int? id;
  String name;
  String email;

  User({this.id, required this.name, required this.email});

  User.fromMap(Map<String, dynamic> res)
    : id = res['id'],
      name = res['name'],
      email = res['email'];

  Map<String, Object?> toMap(){
    return {'id': id, 'name': name, 'email': email};
  }

  
}
