import 'package:trade_mate/screens/home/tabs/suppliers/data/data/supplier_data.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/repo/supplier_data_source.dart';

class SupplierDataSourceImpl implements SupplierDataSource{
  SupplierDataSourceImpl({required this.supplierData});
  SupplierData supplierData;
  @override
 void addSupplier(SupplierEntity supplier) {

    return supplierData.addSupplier(supplier.fromEntity(supplier));
  }

  @override
  Future<List<SupplierEntity>> getSuppliers() async{
    final models = await supplierData.getSuppliers();
    return models.map((model) => model.toEntity()).toList();
  }




}