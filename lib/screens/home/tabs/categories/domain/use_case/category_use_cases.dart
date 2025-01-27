import 'package:dartz/dartz.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_repository.dart';

import '../../../../../../utils/failures.dart';
import '../entity/category_entity.dart';

class CategoryUseCases{
  CategoryUseCases({required this.categoryRepository});
  CategoryRepository categoryRepository;
  Future<Either<Failures,void>>addCategory(CategoryEntity category){
    return categoryRepository.addCategory(category);

  }
  Stream<Either<Failures,List<CategoryEntity>>>getCategories(){
    return categoryRepository.getCategories();

  }
  Future<void>deleteCategory(String id){
    return categoryRepository.deleteCategory(id);


  }
  Future<void>updateCategory(String id,CategoryEntity category){
    return categoryRepository.updateCategory(id, category);

  }
}