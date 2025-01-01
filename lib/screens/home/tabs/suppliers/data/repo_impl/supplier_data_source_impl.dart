import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/data/supplier_data.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';

import '../../../../../../utils/failures.dart';

class SupplierDataSourceImpl implements SupplierDataSource{
  SupplierDataSourceImpl({required this.supplierData});
  SupplierData supplierData;
  @override
  Future<Either<Failures, void>> addSupplier(SupplierEntity supplier) async{
    try{
      var either= await supplierData.addSupplier(supplier.fromEntity(supplier));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Stream<Either<Failures, List<SupplierEntity>>> getSuppliers() {
    return supplierData.getSuppliers().map((either) {
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
  Future<void> deleteSupplier(String id) {
    return supplierData.deleteSupplier(id);
  }

  @override
  Future<void> updateSupplier(String id, SupplierEntity product) {
    return supplierData.updateSupplier(id, product.fromEntity(product));
  }



  // @override
 // void addSupplier(SupplierEntity supplier) {
 //
 //    return supplierData.addSupplier(supplier.fromEntity(supplier));
 //  }
 //
 //  @override
 //  Future<List<SupplierEntity>> getSuppliers() async{
 //    final models = await supplierData.getSuppliers();
 //    return models.map((model) => model.toEntity()).toList();
 //  }
 //
 //  @override
 //  void removeSupplier(String index) {
 //    return supplierData.removeSupplier(index);
 //  }




}