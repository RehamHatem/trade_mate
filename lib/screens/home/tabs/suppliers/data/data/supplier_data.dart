import 'package:hive/hive.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/data/model/supplier_model.dart';

class SupplierData {
  static const String boxName = 'suppliers';


  Box? _box;


  Future<Box> _getBox() async {
    _box ??= await Hive.openBox(boxName);
    return _box!;
  }

  void addSupplier(SupplierModel supplier) async {
    final box = await _getBox();
    List<dynamic> suppliers = (box.get('suppliers') as List<dynamic>?) ?? [];
    suppliers.add(supplier.toJson());
    await box.put('suppliers', suppliers);
  }

  Future<List<SupplierModel>> getSuppliers() async {
    try {
      var box = await _getBox();
      final suppliersData = box.get('suppliers', defaultValue: []);
      if (suppliersData is List<dynamic>) {
        return suppliersData
            .whereType<Map>() // Ensure only maps are processed
            .map((json) {
          try {
            // Convert dynamic keys to String keys
            final correctedJson = Map<String, dynamic>.from(json);
            return SupplierModel.fromJson(correctedJson);
          } catch (e) {
            print("Error parsing supplier data: $e");
            return null; // Skip invalid entries
          }
        })
            .whereType<SupplierModel>() // Remove nulls from invalid entries
            .toList();
      }
      return [];
    } catch (e, stackTrace) {
      print("Error accessing Hive: $e\n$stackTrace");
      throw Exception("Failed to fetch suppliers: $e");
    }
  }


}