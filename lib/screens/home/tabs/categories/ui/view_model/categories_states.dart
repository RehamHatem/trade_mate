import '../../domain/entity/category_entity.dart';

abstract class CategoriesStates{

}
class CategoriesInitState extends CategoriesStates{

}

class AddCategoryLoadingState extends CategoriesStates{
  AddCategoryLoadingState({required this.load});
  String load;
}
class AddCategoryErrorState extends CategoriesStates{
  AddCategoryErrorState({required this.error});
  String error;
}
class AddCategorySuccessState extends CategoriesStates{
  AddCategorySuccessState({required this.entity});
  CategoryEntity  entity;
}
class GetCategoryLoadingState extends CategoriesStates{
  GetCategoryLoadingState({required this.load});
  String load;
}
class GetCategoryErrorState extends CategoriesStates{
  GetCategoryErrorState({required this.error});
  String error;
}
class GetCategorySuccessState extends CategoriesStates{
  GetCategorySuccessState({required this.entity});
  List<CategoryEntity>  entity;
}
class RemoveCategoryLoadingState extends CategoriesStates{
  RemoveCategoryLoadingState({required this.load});
  String load;
}
class RemoveCategoryErrorState extends CategoriesStates{
  RemoveCategoryErrorState({required this.error});
  String error;
}
class RemoveCategorySuccessState extends CategoriesStates{
  RemoveCategorySuccessState({required this.success});
  String success;
}

class UpdateCategoryLoadingState extends CategoriesStates{
  UpdateCategoryLoadingState({required this.load});
  String load;
}
class UpdateCategoryErrorState extends CategoriesStates{
  UpdateCategoryErrorState({required this.error});
  String error;
}
class UpdateCategorySuccessState extends CategoriesStates{
  UpdateCategorySuccessState({required this.success});
  String success;
}

class GetProductsByCategoryLoadingState extends CategoriesStates{
  GetProductsByCategoryLoadingState({required this.load});
  String load;
}
class GetProductsByCategoryErrorState extends CategoriesStates{
  GetProductsByCategoryErrorState({required this.error});
  String error;
}
class GetProductsByCategorySuccessState extends CategoriesStates{
  GetProductsByCategorySuccessState({required this.success});
  String success;
}