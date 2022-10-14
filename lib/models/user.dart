import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

import 'cart.dart';

User UserFromJson(String str) => User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.id,
    required this.token,
    required this.cart,
  });

  String name;
  String email;
  String password;
  String address;
  String type;
  String id;
  String token;
  List<dynamic> cart;

  factory User.fromMap(Map<String, dynamic> json) {
    print(json['cart'].length);
    return User(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      address: json["address"],
      type: json["type"],
      id: json["_id"],
      token: json["token"],
      cart: (json['cart'].isNotEmpty)
          ? json['cart']
              .map((e) => Cart.fromMap({
                    'product': Product.fromMap(e['product']),
                    'quantity': e['quantity'],
                  }))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "_id": id,
        "token": token,
        "cart": cart,
      };
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
