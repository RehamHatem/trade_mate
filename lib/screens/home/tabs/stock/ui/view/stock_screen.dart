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
                    return BlocListener(
                      listener: (context, state) {
    if (state is DeleteProductLoadingState) {
                          DialogUtils.showLoading(
                              context, "Deleting product...");
                        } else if (state is DeleteProductErrorState) {
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(context, state.error);
                        } else if (state is DeleteProductSuccessState) {
                          DialogUtils.hideLoading(context);
                          DialogUtils.showMessage(
                              context, "Product deleted successfully");
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Something went wrong"),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<StockViewModel>().getProducts(),
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
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
                          return InkWell(
                            onTap: () {
                              showDialog(barrierDismissible: false,context: context, builder: (context) {
                                return  AlertDialog(
                                  backgroundColor: AppColors.lightGreyColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r),side: BorderSide(color: AppColors.primaryColor)),
                                  title: Row(

                                    children: [
                                      Text("Details",style:
                                      Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: AppColors.darkPrimaryColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      Spacer(),
                                      IconButton(style: ButtonStyle(
                                          backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
                                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius:
                                          BorderRadius.circular(50.r),))
                                      ),onPressed: () {
                                        Navigator.pop(context);

                                      }, icon: Icon(Icons.close,size: 25.sp,color: AppColors.whiteColor),),
                                    ],
                                  ),

                                  alignment: Alignment.center,
                                  content:
                                  ProductView(productEntity: product,)
                                  ,
                                );
                              },);


                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   builder: (context) {
                              //     return Container(
                              //       margin: EdgeInsets.only(
                              //         left: 16.h,right: 16.h,bottom: 16.w,top:16.w
                              //       ),
                              //
                              //
                              //         padding: EdgeInsets.only(
                              //
                              //             bottom: MediaQuery.of(context).viewInsets.bottom),
                              //         decoration: BoxDecoration(color: AppColors.whiteColor,borderRadius:
                              //         BorderRadius.only(topLeft: Radius.circular(15.r),topRight:
                              //         Radius.circular(15.r))),
                              //         child: ProductView(productEntity: product,));
                              //   },
                              // );

                            },
                            child: ProductItem(
                              delete: (p0) {
                                stockViewModel.deleteProduct(product.id);

                                // stockViewModel.stream.listen((state) {
                                //   if (state is DeleteProductLoadingState) {
                                //     DialogUtils.showLoading(context, "Deleting product...");
                                //   } else if (state is DeleteProductErrorState) {
                                //     DialogUtils.hideLoading(context);
                                //     DialogUtils.showMessage(context, state.error);
                                //   } else if (state is DeleteProductSuccessState) {
                                //     DialogUtils.hideLoading(context);
                                //     DialogUtils.showMessage(context, "Product deleted successfully");
                                //   }
                                // });
                              },
                             productModel: product,
                            ),
                          );
                        },
                        separatorBuilder: (_, __) =>  SizedBox(height: 10.h),
                        itemCount: products.length,
                      ),
                    );
                  }

                  return  Center(child: Text("No Products Available"));
                },
              ),
            ),
          ),      ],
      ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(right: 16.w,bottom: 64.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddProductScreen.routeName);

          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
          child: Icon(Icons.add,size:35.sp,color: AppColors.whiteColor,),
        backgroundColor: AppColors.darkPrimaryColor,
          elevation: 0,


        ),

      ),
    );
  }
}
