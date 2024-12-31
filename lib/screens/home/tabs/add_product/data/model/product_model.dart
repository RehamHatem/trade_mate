import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity{



  ProductModel(
  {super.id = "",
  required super.name,
    required super.notes,
  required super.quantity,
  required super.price,
  required super.total,
    required super.supplier,
    required super.category,
  required super.date, required super.userId,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      :this
  (
      id: json['id'].toString(), // Ensure 'id' is always a String
      name: json['name'] as String,
      notes: json['notes'] as String,
      category: json['category'] as String,
      supplier: json['supplier'] as String,
      quantity: (json['quantity'] is int)
          ? (json['quantity'] as int).toDouble()
          : json['quantity'] as double,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] as double,
      total: (json['total'] is int)
          ? (json['total'] as int).toDouble()
          : json['total'] as double,
      date: json['date'].toString(), // Ensure 'date' is always a String
      userId: json['userId'].toString(),
  );


  Map<String,dynamic> toJson(){
  return {
  "category": category,
  "id":id,
  "name":name,
  "notes":notes,
  "quantity":quantity,
  "price":price,
  "total":total,
  "supplier":supplier,
  "date":date,
  "userId":userId,
  };

  }


}