import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../domain/entity/supplier_entity.dart';

class SupplierModel extends SupplierEntity{



  SupplierModel(
      {super.id = "",
        required super.edited,
        required super.name,
        required super.notes,
        required super.address,
        required super.city,
        required super.phone,
        required super.date, required super.userId,
      });

  SupplierModel.fromJson(Map<String, dynamic> json)
      :this
      (
      name: json['name'],
      edited: json['edited'],
      notes: json['notes'],
      address: json['address'],
      city: json['city'],
      phone: json['phone'],
      date: json['date'],
      id: json['id'],
      userId: json['userId'],
    );


  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "edited":edited,
      "notes":notes,
      "address":address,
      "city":city,
      "phone":phone,
      "date":date,
      "userId":userId,
    };

  }


}