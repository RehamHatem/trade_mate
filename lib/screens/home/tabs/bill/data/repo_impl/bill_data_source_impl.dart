import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/bill/data/data/bill_data.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/entity/bill_entity.dart';
import 'package:trade_mate/screens/home/tabs/bill/domain/repo/bill_data_source.dart';

import '../../../../../../utils/failures.dart';

class BillDataSourceImpl implements BillDataSource{
  BillDataSourceImpl({required this.billData});
  BillData billData;
  @override
  Future<Either<Failures, void>> addBill(BillEntity bill) async{
    try{
     await billData.addBill(bill.fromEntity(bill));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Stream<Either<Failures, List<BillEntity>>> getBills() {
    return billData.getBills().map((either) {
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
    return billData.deleteBill(id);
  }

  @override
  Future<void> updateBill(String id, BillEntity bill) {
    return billData.updateBill(id, bill.fromEntity(bill));
  }
}