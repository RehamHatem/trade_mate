import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity{



  ProductModel(
  {super.id = "",
  required super.name,
    super.notes="N/A",
  required super.quantity,
  required super.price,
  required super.total,
   super.supplier="N/A",
   super.category="N/A",
  required super.date, required super.userId,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
      :this
  (
      name: json['name'],
      notes: json['notes'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      category: json['category'],
  date: json['date'],
  id: json['id'],
      supplier: json['supplier'],
  userId: json['userId'],
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