import 'dart:convert';

import 'package:proyectofiberpluss/src/models/address.dart';
import 'package:proyectofiberpluss/src/models/product.dart';
import 'package:proyectofiberpluss/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {

  String? id;
  String? idClient;
  String? idTechnician;
  String? idAddress;
  String? status;
  double? lat;
  double? lng;
  int? timestamp;
  List<Product>? products = [];
  User? client;
  User? technician;
  Address? address;

  Order({
    this.id,
    this.idClient,
    this.idTechnician,
    this.idAddress,
    this.status,
    this.lat,
    this.lng,
    this.timestamp,
    this.products,
    this.address,
    this.client,
    this.technician
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    idClient: json["id_client"],
    idTechnician: json["id_technician"],
    idAddress: json["id_address"],
    status: json["status"],
    products: json["products"] != null ? List<Product>.from(json["products"].map((model) => model is Product ? model : Product.fromJson(model))) : [],
    lat: json["lat"],
    lng: json["lng"],
    timestamp: json["timestamp"],
    client: json['client'] is String ? userFromJson(json['client']) : json['client'] is User ? json['client'] : User.fromJson(json['client'] ?? {}),
    technician: json['technician'] is String ? userFromJson(json['technician']) : json['technician'] is User ? json['technician'] : User.fromJson(json['technician'] ?? {}),
    address: json['address'] is String ? addressFromJson(json['address']) : json['address'] is Address ? json['address'] : Address.fromJson(json['address'] ?? {}),
  );

  static List<Order> fromJsonList(List<dynamic> jsonList) {
    List<Order> toList = [];

    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "id_technician": idTechnician,
    "id_address": idAddress,
    "status": status,
    "lat": lat,
    "lng": lng,
    "timestamp": timestamp,
    "products": products,
    "client": client,
    "technician": technician,
    "address": address,
  };
}
