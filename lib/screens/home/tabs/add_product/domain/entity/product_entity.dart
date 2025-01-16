import '../../data/model/product_model.dart';

class ProductEntity{

  String id;
  String name;
  String notes;
  String category;
  String supplier;
  double quantity;
  String quantityType;
  double price;
  double total;
  double discount;
  double totalAfterDiscount;
  String discountType;

  String date;
  String userId;

  ProductEntity(
  {this.id = "",
  required this.name,
  required this.notes,
  required this.quantity,
    this.discount=0,
    this.discountType="%",
    this.totalAfterDiscount=0,
    required this.quantityType,
  required this.price,
  required this.total, required this.supplier,
    required this.category,
  required this.date, required this.userId,
  });



  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "notes": notes,
      "category": category,
      "supplier": supplier,
      "quantity": quantity,
      "quantityType": quantityType,
      "price": price,
      "total": total,
      "discount": discount,
      "totalAfterDiscount": totalAfterDiscount,
      "discountType": discountType,
      "date": date,
      "userId": userId,
    };
  }

  ProductEntity toEntity() {
  return ProductEntity(
      category:category,
      supplier:supplier,
      total:total,
      price:price,
      discount:discount,
      totalAfterDiscount:totalAfterDiscount,
      discountType:discountType,
      quantity:quantity,
      quantityType:quantityType,
      id:id,
      name:name,
      userId:userId,
      date:date,
      notes:notes
  );
}
  ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
        category:entity.category,
        supplier:entity.supplier,
        total:entity.total,
        price:entity.price,
        discount:entity.discount,
        totalAfterDiscount:entity.totalAfterDiscount,
        discountType:entity.discountType,
        quantity:entity.quantity,
        quantityType:entity.quantityType,
        id:entity.id,
        name:entity.name,
        userId:entity.userId,
        date:entity.date,
        notes:entity.notes
    );
  }




}