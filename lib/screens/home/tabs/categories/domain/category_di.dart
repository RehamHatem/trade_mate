import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_data_source.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/repo/category_repository.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/use_case/category_use_cases.dart';

import '../data/data/category_data.dart';
import '../data/repo_impl/category_data_source_impl.dart';
import '../data/repo_impl/category_repository_impl.dart';

CategoryUseCases injectCategoryUseCases(){
  return CategoryUseCases(categoryRepository: injectCategoryRepository());
}
CategoryRepository injectCategoryRepository(){
  return CategoryRepositoryImpl(categoryDataSource: injectCategoryDataSource());
}
CategoryDataSource injectCategoryDataSource(){
  return CategoryDataSourceImpl(categoryData: injectCategoryData());
}
CategoryData injectCategoryData(){
  return CategoryData();
}