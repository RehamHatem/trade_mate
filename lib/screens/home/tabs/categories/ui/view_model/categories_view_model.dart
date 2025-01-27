import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';
import 'package:trade_mate/screens/home/tabs/categories/domain/use_case/category_use_cases.dart';
import 'package:trade_mate/screens/home/tabs/categories/ui/view_model/categories_states.dart';
import 'package:trade_mate/screens/home/tabs/stock/domain/stock_di.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_view_model.dart';

import '../../../../../../utils/app_colors.dart';
import '../../domain/entity/category_entity.dart';

class CategoriesViewModel extends Cubit<CategoriesStates>{
  CategoriesViewModel({required this.categoryUseCases}):super(CategoriesInitState());
var categoryNameController=TextEditingController();
var searchController=TextEditingController();
var productsInCategorySearchController=TextEditingController();
  var selectedColor=Colors.transparent;
  StockViewModel stockViewModel =StockViewModel(stockUseCases: injectStockUseCases());

CategoryUseCases categoryUseCases;
  StreamController<List<CategoryEntity>> categoryStreamController = StreamController.broadcast();
  StreamController<List<ProductEntity>> productStreamController = StreamController.broadcast();
  List<CategoryEntity>categories=[];

  void addCategory(CategoryEntity category) async {
    emit(AddCategoryLoadingState(load: "Loadin..."));
    var either = await categoryUseCases.addCategory(category);
    return either.fold((l) {
      emit(AddCategoryErrorState(error: l.errorMsg!));
    }, (r) {
      emit(AddCategorySuccessState(entity: category));
    },);
  }

  void getCategorys() async {
    emit(GetCategoryLoadingState(load: "loading..."));

    categoryUseCases.getCategories().listen((either) {
      either.fold(
            (failure) {
          print(failure.errorMsg);
          emit(GetCategoryErrorState(error: failure.errorMsg!));
        },
            (Categories) {
          categoryStreamController.add(Categories);
          this.categories=Categories;

          emit(GetCategorySuccessState(entity: categories));
        },
      );
    }, onError: (error) {
      print(error.toString());
      emit(GetCategoryErrorState(error: error));
    });
  }

  void searchCategoryies(String query) async {
    emit(GetCategoryLoadingState(load: "Searching categories..."));

    try {
      categoryUseCases.getCategories().listen((either) {
        either.fold(
              (failure) {
            emit(GetCategoryErrorState(error: failure.errorMsg!));
          },
              (categories) {
            var filteredCategories = categories
                .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
                .toList();

            categoryStreamController.add(
                filteredCategories);
            emit(GetCategorySuccessState(
                entity: filteredCategories));
          },
        );
      });
    } catch (e) {
      emit(GetCategoryErrorState(
          error: e.toString()));
    }
  }

  void deleteCategory(String id) async {
    emit(RemoveCategoryLoadingState(load: "loading..."));
    try {
      await categoryUseCases.deleteCategory(id);
      emit(RemoveCategorySuccessState(success: "success"));
    } catch (e) {
      emit(RemoveCategoryErrorState(error: e.toString()));

    }
  }

  void updateCategory(String id, CategoryEntity category) {

    emit(UpdateCategoryLoadingState(load: "loading..."));
    try {
      categoryUseCases.updateCategory(id, category);
      emit(UpdateCategorySuccessState(success: "success"));

    } catch (e) {
      emit(UpdateCategoryErrorState(error: e.toString()));
      print(e.toString());
    }
  }

  void getProductsByCategory(CategoryEntity category) async {
    emit(GetProductsByCategoryLoadingState(load: "Loading products for the selected category..."));

    try {
      stockViewModel.stockUseCases.getProducts().listen((either) {
        either.fold(
              (failure) {
            emit(GetProductsByCategoryErrorState(error: failure.errorMsg!));
          },
              (products) {
            // Filter products by the selected category
            var filteredProducts = products
                .where((product) => product.category== category.name)
                .toList();

            productStreamController.add(filteredProducts);
            emit(GetProductsByCategorySuccessState(success: "filteredProducts"));
          },
        );
      });
    } catch (e) {
      emit(GetProductsByCategoryErrorState(error: e.toString()));
    }
  }}