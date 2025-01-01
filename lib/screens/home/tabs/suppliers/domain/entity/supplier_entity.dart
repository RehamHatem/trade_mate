import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';


class SupplierEntity{

  String id;
  String name;
  String phone;
  String city;
  String address;
  String notes;
  String date;
  String userId;
  bool edited;
  SupplierEntity(
      {required this.id,
        required this.name,
        required this.notes,
        required this.phone,
        required this.address,
        required this.city,
        this.edited=false,
        required this.date, required this.userId,
      });


  factory SupplierEntity.fromJson(Map<String, dynamic> json) {
    return SupplierEntity(

      name: json['name'],
      notes: json['notes'],
      address: json['address'],
      edited: json['edited'],
      city: json['city'],
      phone: json['phone'],
      date: json['date'],
      id: json['id'],
      userId: json['userId'],
    );
  }

  SupplierEntity toEntity() {
    return SupplierEntity(
        phone:phone,
        address:address,
        city:city,
        id:id,
        edited:edited,
        name:name,
        userId:userId,
        date:date,
        notes:notes
    );
  }
  SupplierModel fromEntity(SupplierEntity entity) {
    return SupplierModel(
        phone:entity.phone,
        edited:entity.edited,
        address:entity.address,
        city:entity.city,
        id:entity.id,
        name:entity.name,
        userId:entity.userId,
        date:entity.date,
        notes:entity.notes
    );
  }




}