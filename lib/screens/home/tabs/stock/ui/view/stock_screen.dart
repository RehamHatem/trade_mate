import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/product_item.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';
import 'package:trade_mate/utils/text_field_item.dart';

import '../../../add_product/domain/entity/product_entity.dart';
import '../../domain/stock_di.dart';
import '../view_model/stock_states.dart';

class StockScreen extends StatelessWidget {
  static const String routeName="stock";
   StockScreen({super.key});
  StockViewModel stockViewModel=StockViewModel(stockUseCases: injectStockUseCases());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        title: Text(
        'Stock',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: AppColors.whiteColor),
      ),),
      body: Column(
        children: [
          Container(
            width: double.infinity,
              height: 105.h,
              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),

              child: Padding(
                padding:  EdgeInsets.only(left: 15.w,right: 15.w,),
                child: TextFieldItem(controller: stockViewModel.search,hintText: "Search in stock ",suffixIcon: Icon(Icons.search,),),
              )),

          Expanded(
            child: BlocProvider(
              create: (_) => stockViewModel..getProducts(),
              child: BlocBuilder<StockViewModel, StockStates>(
                builder: (context, state) {
                  if (state is StockLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is StockErrorState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Something went wrong"),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<StockViewModel>().getProducts(),
                          child: const Text("Try Again"),
                        ),
                      ],
                    );
                  }

                  if (state is StockSuccessState) {
                    final products = state.products;

                    if (products.isEmpty) {
                      return const Center(child: Text("No Products Found"));
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductItem(
                            name: product.name,
                            quantity: product.quantity,
                            price: product.price != null
                                ? double.parse(product.price.toString()).toStringAsFixed(2)
                                : '0.00',
                            totalPrice: product.total != null
                                ? double.parse(product.total.toString()).toStringAsFixed(2)
                                : '0.00',
                            supplier: product.supplier,
                            category: product.category,
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemCount: products.length,
                      ),
                    );
                  }

                  return const Center(child: Text("No Products Available"));
                },
              ),
            ),
          ),      ],
      ),
    );
  }
}
