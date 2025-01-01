import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/domain/entity/supplier_entity.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/edit_supplier.dart';

import '../../../../../../utils/app_colors.dart';

class SupplierItem extends StatelessWidget {
  SupplierItem(
      {required this.supplierEntity,
      required this.delete,
      required this.update});

  SupplierEntity supplierEntity;
  void Function(String) delete;
  void Function(String, SupplierEntity) update;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: double.infinity,
          height: 110.h,
          margin:
              EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
          padding: EdgeInsets.only(left: 20.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60.h,
                width: 60.w,
                child: Text(
                  "${supplierEntity.name.substring(0, 1)}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 28.sp,
                      ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkPrimaryColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplierEntity.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.darkPrimaryColor,
                          fontSize: 22.sp,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      supplierEntity.phone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.darkPrimaryColor,
                          fontSize: 22.sp,
                          overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          supplierEntity.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 16.sp,
                                  overflow: TextOverflow.ellipsis),
                        ),
                        supplierEntity.edited == true
                            ? Text(
                                "Edited",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppColors.greyColor,
                                        fontSize: 16.sp,
                                        overflow: TextOverflow.ellipsis),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 88.h,
          left: 350.w,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.whiteColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryColor),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ))),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              delete(supplierEntity.id);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Delete",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.whiteColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(AppColors.redColor),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ))),
                          ),
                        ],
                      )
                    ],
                    backgroundColor: AppColors.lightGreyColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        side: BorderSide(color: AppColors.primaryColor)),
                    alignment: Alignment.center,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Do you want to delete ${supplierEntity.name}?",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            color: AppColors.redColor,
            icon: Icon(Icons.cancel),
          ),
        ),
        Positioned(
          top: 72.h,
          right: 15.w,
          child: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: AppColors.lightGreyColor,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Container(
                        margin: EdgeInsets.only(
                            left: 16.h, right: 16.h, bottom: 16.w, top: 16.w),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        decoration: BoxDecoration(
                            color: AppColors.lightGreyColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r))),
                        child: EditSupplier(
                            update:update,
                            supplierEntity: supplierEntity));
                  });
            },
            color: Colors.transparent,
            icon: Icon(
              Icons.edit,
              color: AppColors.greyColor,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
