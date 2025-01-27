import 'package:dartz/dartz.dart';

import '../../../../../../utils/failures.dart';
import '../entity/category_entity.dart';

abstract class CategoryDataSource{
  Future<Either<Failures,void>>addCategory(CategoryEntity category);
  Stream<Either<Failures,List<CategoryEntity>>>getCategories();
  Future<void>deleteCategory(String id);
  Future<void>updateCategory(String id,CategoryEntity category);
}