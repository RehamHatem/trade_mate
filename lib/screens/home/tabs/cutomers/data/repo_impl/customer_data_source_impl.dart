import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';

import '../../../../../../utils/failures.dart';
import '../../domain/repo/customer_data_source.dart';
import '../data/cutomer_data.dart';

class CustomerDataSourceImpl implements CustomerDataSource{
  CustomerDataSourceImpl({required this.customerData});
  CustomerData customerData;
  @override
  Future<Either<Failures, void>> addCustomer(SupplierEntity customer) async{
    try{
      var either= await customerData.addCustomer(customer.fromEntity(customer));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Stream<Either<Failures, List<SupplierEntity>>> getCustomer() {
    return customerData.getCustomers().map((either) {
      return either.fold(
            (failure) => left(failure),
            (snapshot) {
          try {
            // Convert Firestore ProductModel to ProductEntity
            final entityList = snapshot.docs.map((doc) {
              final model = doc.data();
              return SupplierEntity(
                id: doc.id,
                name: model.name,
                notes: model.notes,
                address: model.address,
                city: model.city,
                phone: model.phone,

                date: model.date,
                userId: model.userId,
              );
            }).toList();
            print(entityList);
            return right<Failures, List<SupplierEntity>>(entityList);
          } catch (e) {
            return left<Failures, List<SupplierEntity>>(Failures(errorMsg: e.toString()));
          }
        },
      );
    });
  }

  @override
  Future<void> deleteCustomer(String id) {
    return customerData.deleteCustomer(id);
  }

  @override
  Future<void> updateCustomer(String id, SupplierEntity customer) {
    return customerData.updateCustomer(id, customer.fromEntity(customer));
  }


}