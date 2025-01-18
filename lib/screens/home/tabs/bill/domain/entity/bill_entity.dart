import 'package:trade_mate/screens/home/tabs/bill/ui/view/add_bill_screen.dart';

import '../../../add_product/domain/entity/product_entity.dart';
import '../../../suppliers/domain/entity/supplier_entity.dart';
import '../../data/model/bill_model.dart';
import '../../ui/view/bill_tab.dart';

class BillEntity{

  String id;
  String supplierName;
  String customerName;
  BillType billType;
  String paymentMethod;
  String retailOrWholesale;
  String date;
  String userId;
  double totalBill;
  double paid;
  double remain;
  double discountBill;

  List<ProductEntity>products;

  BillEntity(
      {required this.id,
        required this.supplierName,
        required this.customerName,
        required this.billType,
        required this.paymentMethod,
        required this.retailOrWholesale,
        required this.products,
        required this.paid,
        required this.remain,
        required this.discountBill,
        required this.totalBill,

        required this.date, required this.userId,
      });


  factory BillEntity.fromJson(Map<String, dynamic> json) {
    return BillEntity(

      supplierName: json['supplierName'],
      customerName: json['customerName'],
      billType: json['billType'],
      paymentMethod: json['paymentMethod'],
      retailOrWholesale: json['retailOrWholesale'],
      products: json['products'],
      discountBill: json['discountBill'],
      totalBill: json['totalBill'],
      paid: json['paid'],
      remain: json['remain'],
      date: json['date'],
      id: json['id'],
      userId: json['userId'],
    );
  }

  BillEntity toEntity() {
    return BillEntity(
        supplierName:supplierName,
        customerName:customerName,
        billType:billType,
        discountBill:discountBill,
        totalBill:totalBill,
        remain:remain,
        paid:paid,
        id:id,
        paymentMethod:paymentMethod,
        products:products,
        userId:userId,
        date:date,
        retailOrWholesale:retailOrWholesale
    );
  }
  BillModel fromEntity(BillEntity entity) {
    return BillModel(
        supplierName:entity.supplierName,
        customerName:entity.customerName,
        billType:entity.billType,
        paymentMethod:entity.paymentMethod,
        totalBill:entity.totalBill,
        remain:entity.remain,
        paid:entity.paid,
        discountBill:entity.discountBill,
        id:entity.id,
        products:entity.products,
        userId:entity.userId,
        date:entity.date,
        retailOrWholesale:entity.retailOrWholesale
    );
  }
}