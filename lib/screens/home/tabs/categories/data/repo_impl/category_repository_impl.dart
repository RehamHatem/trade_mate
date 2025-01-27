import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_data_source.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_repository.dart';

import '../../../../../../utils/failures.dart';
import '../../domain/entity/category_entity.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  CategoryRepositoryImpl({required this.categoryDataSource});
  CategoryDataSource categoryDataSource;
  @override
  Future<Either<Failures, void>> addCategory(CategoryEntity category)async {
    try{
      var either= await categoryDataSource.addCategory(category.fromEntity(category));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Future<void> deleteCategory(String id) {
    return categoryDataSource.deleteCategory(id);
  }

  @override
  Stream<Either<Failures, List<CategoryEntity>>> getCategories() {
    return categoryDataSource.getCategories();
  }

  @override
  Future<void> updateCategory(String id, CategoryEntity category) {
    return categoryDataSource.updateCategory(id, category);
  }
}