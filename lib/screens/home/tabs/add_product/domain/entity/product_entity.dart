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

  String date;
  String userId;

  ProductEntity(
  {this.id = "",
  required this.name,
  required this.notes,
  required this.quantity,
  required this.quantityType,
  required this.price,
  required this.total, required this.supplier,
    required this.category,
  required this.date, required this.userId,
  });




  ProductEntity toEntity() {
  return ProductEntity(
      category:category,
      supplier:supplier,
      total:total,
      price:price,
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