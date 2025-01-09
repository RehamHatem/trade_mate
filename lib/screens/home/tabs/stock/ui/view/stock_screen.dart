import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/product_item.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/product_view.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view_model/stock_view_model.dart';
import 'package:trade_mate/utils/app_colors.dart';
import 'package:trade_mate/utils/dialog_utils.dart';
import 'package:trade_mate/utils/text_field_item.dart';

import '../../../add_product/domain/entity/product_entity.dart';
import '../../domain/stock_di.dart';
import '../view_model/stock_states.dart';

class StockScreen extends StatelessWidget {
  static const String routeName = "stock";

  StockScreen({super.key});

  StockViewModel stockViewModel =
      StockViewModel(stockUseCases: injectStockUseCases());

  @override
  Widget build(BuildContext context) {
stockViewModel.getProducts();
    return

      Scaffold(
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
        ),
      ),
      body: Column(
        children: [
          Container(
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(color: AppColors.darkPrimaryColor),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                child: TextFieldItem(
                  controller: stockViewModel.search,

                  change: (query) {
                    stockViewModel.searchProducts(query);
                  },
                  hintText: "Search in stock ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
          Expanded(
            child: BlocListener(
              bloc: stockViewModel,
              listener: (context, state) {
                if (state is DeleteProductLoadingState) {
                  DialogUtils.showLoading(context, "Deleting product...");
                } else if (state is DeleteProductErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is DeleteProductSuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Product deleted successfully",
                      title: "Note");
                } else if (state is UpdateProductLoadingState) {
                  DialogUtils.showLoading(context, "Updating product...");
                } else if (state is UpdateProductErrorState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(context, state.error);
                } else if (state is UpdateProductSuccessState) {
                  DialogUtils.hideLoading(context);
                  DialogUtils.showMessage(
                      context, "Product updated successfully",
                      title: "Note");
                }

              },
              child: StreamBuilder<List<ProductEntity>>(
                  stream: stockViewModel.productStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
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

                    final products = snapshot.data ?? [];
                    if (products.isEmpty) {
                      return Center(child: Text("No Products Found"));
                    }


                    return Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 14.h),
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return InkWell(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.lightGreyColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    title: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Details",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: AppColors
                                                          .darkPrimaryColor),
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            IconButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      WidgetStatePropertyAll(
                                                          AppColors
                                                              .darkPrimaryColor),
                                                  shape: WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
                                                  ))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close,
                                                  size: 25.sp,
                                                  color: AppColors.whiteColor),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: AppColors.darkPrimaryColor,
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    content: ProductView(
                                      productEntity: product,
                                    ),
                                  );
                                },
                              );
                            },
                            child: ProductItem(
                              delete: (p0) {
                                stockViewModel.deleteProduct(product.id);
                              },
                              update: (p0, p1) {
                                stockViewModel.updateProduct(product.id, p1);
                              },
                              productModel: product,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(height: 5.h),
                        itemCount: products.length,
                      ),
                    );
                  }


                  ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 64.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductScreen.routeName);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
          child: Icon(
            Icons.add,
            size: 35.sp,
            color: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ),
    );
  }
}
