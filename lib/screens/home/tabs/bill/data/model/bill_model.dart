import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_tab.dart';

import '../../../add_product/data/model/product_model.dart';


class BillModel extends BillEntity {
  BillModel({
    super.id = "",
    required super.billType,
    required super.paymentMethod,
    required super.products,
    required super.paid,
    required super.remain,
    required super.retailOrWholesale,
    required super.supplierName,
    required super.customerName,
    required super.discountBill,
    required super.totalBill,
    required super.date,
    required super.userId,
  });

  BillModel.fromJson(Map<String, dynamic> json)
      : this(
    supplierName: json['supplierName'] as String,
    customerName: json['customerName'] as String,
    retailOrWholesale: json['retailOrWholesale'] as String,
    products: (json['products'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    discountBill: (json['discountBill'] is int)
        ? (json['discountBill'] as int).toDouble()
        : json['discountBill'] as double,
    totalBill: (json['totalBill'] is int)
        ? (json['totalBill'] as int).toDouble()
        : json['totalBill'] as double,
    paid: (json['paid'] is int)
        ? (json['paid'] as int).toDouble()
        : json['paid'] as double,
    remain: (json['remain'] is int)
        ? (json['remain'] as int).toDouble()
        : json['remain'] as double,
    paymentMethod: json['paymentMethod'] as String,
    billType: BillType.values.firstWhere(
            (e) => e.toString().split('.').last == json['billType']),
    date: json['date'].toString(),
    id: json['id'].toString(),
    userId: json['userId'].toString(),
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "supplierName": supplierName,
      "customerName": customerName,
      "retailOrWholesale": retailOrWholesale,
      "products": products.map((product) => product.toJson()).toList(),
      "totalBill": totalBill,
      "remain": remain,
      "paid": paid,
      "discountBill": discountBill,
      "paymentMethod": paymentMethod,
      "billType": billType.toString().split('.').last,
      "date": date,
      "userId": userId,
    };
  }
}
