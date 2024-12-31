import 'dart:async';

import 'package:hive/hive.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';

import '../../../../../../utils/shared_preference.dart';

class SupplierData {
  static const String boxName = 'suppliers';
  Box? box;
  final StreamController<List<SupplierModel>> supplierStreamController =
  StreamController.broadcast();

  Future<Box> getBox() async {
    box ??= await Hive.openBox(boxName);
    return box!;
  }

  void addSupplier(SupplierModel supplier) async {
    final box = await getBox();
    List<dynamic> suppliers = (box.get('suppliers') as List<dynamic>?) ?? [];
    suppliers.add(supplier.toJson());
    await box.put('suppliers', suppliers);

  }

  Future<List<SupplierModel>> getSuppliers() async {
    try {
      var box = await getBox();
      final suppliersData = box.get('suppliers', defaultValue: []);
      await SharedPreference.init();
      var user=SharedPreference.getData(key: 'email' );

      if (suppliersData is List<dynamic>) {
        return suppliersData
            .whereType<Map>().where((supplier) => supplier['id'] == user)
            .map((json) {
          try {

            final correctedJson = Map<String, dynamic>.from(json);
            return SupplierModel.fromJson(correctedJson);
          } catch (e) {
            print("Error parsing supplier data: $e");
            return null;
          }
        })
            .whereType<SupplierModel>()
            .toList();

      }
      return [];
    } catch (e, stackTrace) {
      print("Error accessing Hive: $e\n$stackTrace");
      throw Exception("Failed to fetch suppliers: $e");
    }


  }
  void removeSupplier(String index) async{
    final box = await getBox();
    return box.delete(index);
  }


}