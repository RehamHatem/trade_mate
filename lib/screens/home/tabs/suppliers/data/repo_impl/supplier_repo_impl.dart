import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_repository.dart';
import 'package:trade_mate/utils/failures.dart';

class SupplierRepoImpl implements SupplierRepository{
  SupplierDataSource supplierDataSource;
  SupplierRepoImpl({required this.supplierDataSource});

  @override
  Future<Either<Failures, void>> addSupplier(SupplierEntity supplier)async {
    try{
      var either= await supplierDataSource.addSupplier(supplier.fromEntity(supplier));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Future<void> deleteSupplier(String id) {
    return supplierDataSource.deleteSupplier(id);
  }

  @override
  Stream<Either<Failures, List<SupplierEntity>>> getSuppliers() {
    return supplierDataSource.getSuppliers();
  }

  @override
  Future<void> updateSupplier(String id, SupplierEntity supplier) {
    return supplierDataSource.updateSupplier(id, supplier);
  }


  }

  // @override
  // void addSupplier( SupplierEntity supplier) {
  //   return supplierDataSource.addSupplier(supplier);
  // }
  //
  // @override
  // Future<List<SupplierEntity>> getSuppliers() {
  //
  //  return supplierDataSource.getSuppliers();
  // }
  //
  // @override
  // void removeSupplier(String index) {
  //   return supplierDataSource.removeSupplier(index);
  // }


