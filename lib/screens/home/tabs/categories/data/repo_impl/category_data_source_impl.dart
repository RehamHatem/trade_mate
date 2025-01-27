import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/categories/data/data/category_data.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_data_source.dart';

import '../../../../../../utils/failures.dart';
import '../../domain/entity/category_entity.dart';

class CategoryDataSourceImpl implements CategoryDataSource{
  CategoryDataSourceImpl({required this.categoryData});
  CategoryData categoryData;
  @override
  Future<Either<Failures, void>> addCategory(CategoryEntity category)async {
    try{
      var either= await categoryData.addCategory(category.fromEntity(category));
      return right(null);
    }catch(e){
      return left(Failures(errorMsg: e.toString()));
    }
  }
  @override
  Future<void> deleteCategory(String id) {
    return categoryData.deleteCategory(id);
  }

  @override
  Stream<Either<Failures, List<CategoryEntity>>> getCategories() {
    return categoryData.getCategories().map((either) {
      return either.fold(
            (failure) => left(failure),
            (snapshot) {
          try {
            final entityList = snapshot.docs.map((doc) {
              final model = doc.data();
              return CategoryEntity(
                id: doc.id,
                name: model.name,
                color: model.color,


                date: model.date,
                userId: model.userId,
              );
            }).toList();
            print(entityList);
            return right<Failures, List<CategoryEntity>>(entityList);
          } catch (e) {
            return left<Failures, List<CategoryEntity>>(Failures(errorMsg: e.toString()));
          }
        },
      );
    });
  }

  @override
  Future<void> updateCategory(String id, CategoryEntity category) {
    return categoryData.updateCategory(id, category.fromEntity(category));
  }
}