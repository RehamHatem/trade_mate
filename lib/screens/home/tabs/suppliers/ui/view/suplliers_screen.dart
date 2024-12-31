import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_item.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/supplier_view.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view_model/supplier_view_model.dart';

import '../../../../../../main.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/dialog_utils.dart';
import '../../../../../../utils/text_field_item.dart';
import '../../../../home.dart';
import '../../../home_tab/ui/view/home_tab.dart';
import '../../domain/supplier_di.dart';
import '../view_model/supplier_states.dart';
import 'add_supplier_screen.dart';

class SuplliersScreen extends StatefulWidget {
  static const String routeName="supplier";
   SuplliersScreen({super.key});

  @override
  State<SuplliersScreen> createState() => _SuplliersScreenState();
}

class _SuplliersScreenState extends State<SuplliersScreen>with RouteAware {
late SupplierViewModel supplierViewModel;
@override
void initState() {
  super.initState();
  supplierViewModel = SupplierViewModel(supplierUseCases: injectSupplierUseCases());
  supplierViewModel.getSuppliers();
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  routeObserver.subscribe(this, ModalRoute.of(context)!);
}

@override
void didPopNext() {
  // Trigger when coming back to this screen
  supplierViewModel.getSuppliers();
}

@override
void dispose() {
  routeObserver.unsubscribe(this);
  supplierViewModel.close();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    supplierViewModel.getSuppliers();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        backgroundColor: AppColors.darkPrimaryColor,
        leading: IconButton(onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) {
            return false;
          },);

        },icon: Icon(Icons.arrow_back),),
        title: Text(
          'Suppliers',
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
                  controller: supplierViewModel.search,
                  change: (query) {
                    supplierViewModel.searchSuppliers(query);
                  },
                  hintText: "Search in suppliers ",
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              )),
          Expanded(
            child: BlocListener(
              bloc: supplierViewModel,
              listener: (context, state) {

                if (state is RemoveSupplierSuccessState){
                  DialogUtils.showMessage(context, "supplier removed successfully");
                }
              },
              child: StreamBuilder<List<SupplierEntity>>(
                stream:  supplierViewModel.supplierStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No Suppliers Found"));
                  }
                  final suppliers = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      itemBuilder: (context, index) {

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
                                            style: Theme
                                                .of(context)
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
                                  content: SupplierView(
                                    supplierEntity: suppliers [index],
                                  ),

                                );
                              },
                            );
                          },
                          child: SupplierItem(supplierEntity:suppliers[index] ,delete: (p0) {
                            supplierViewModel.removeSupplier(p0);
                          },),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 1.h),
                      itemCount: suppliers.length,
                    ),
                  );
                },

              ),
            ),
          ),


        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 16.w, bottom: 64.h),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddSupplierScreen.routeName);
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
