import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/orders/data/data/orders_data.dart';
import 'package:trade_mate/screens/home/tabs/orders/domain/repo/orders_data_source.dart';

import '../../../../../../utils/failures.dart';
import '../../../bill/domain/entity/bill_entity.dart';

class OrdersDataSourceImpl implements OrdersDataSource{
  OrdersDataSourceImpl({required this.ordersData});
  OrdersData ordersData;
  @override
  Stream<Either<Failures, List<BillEntity>>> getBills() {
    return ordersData.getBills().map((either) {
      return either.fold(
            (failure) => left(failure),
            (snapshot) {
          try {
            // Convert Firestore ProductModel to ProductEntity
            final entityList = snapshot.docs.map((doc) {
              final model = doc.data();
              return BillEntity(
                id: doc.id,
                totalBill: model.totalBill,
                paid: model.paid,
                remain: model.remain,
                discountBill: model.discountBill,
                products: model.products,
                customerName: model.customerName,
                supplierName: model.supplierName,
                billType: model.billType,
                paymentMethod: model.paymentMethod,
                retailOrWholesale: model.retailOrWholesale,

                date: model.date,
                userId: model.userId,
              );
            }).toList();
            print(entityList);
            return right<Failures, List<BillEntity>>(entityList);
          } catch (e) {
            return left<Failures, List<BillEntity>>(Failures(errorMsg: e.toString()));
          }
        },
      );
    });
  }

  @override
  Future<void> deleteBill(String id) {
    return ordersData.deleteBill(id);
  }

  @override
  Future<void> updateBill(String id, BillEntity bill) {
    return ordersData.updateBill(id, bill.fromEntity(bill));
  }
}