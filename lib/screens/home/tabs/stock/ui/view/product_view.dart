import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/add_product/domain/entity/product_entity.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../widgets/add_product_text_field.dart';

class ProductView extends StatelessWidget {
   ProductView({required this.productEntity});
  ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return
    Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,

children: [

  Row(
    children: [
      Text("Product name: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
          ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
      Text("${productEntity.name}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
          ,fontSize: 20.sp,overflow: TextOverflow.ellipsis ),),
    ],
  ),

  Row(
    children: [
      Text("Price: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
      Text("${double.parse(productEntity.price.toString()).toStringAsFixed(2)
          ??"0.00"} EGP",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),

    ],
  ),

  Row(
    children: [
      Text("Quantity: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Text("${productEntity.quantity}",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.primaryColor
            ,fontSize: 20.sp),),
    ],
  ),
  Row(
    children: [
      Text("Total: ",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
      Text("${double.parse(productEntity.total.toString()).toStringAsFixed(2)
          ??"0.00"} EGP",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
        ,fontSize: 20.sp,overflow: TextOverflow.ellipsis,),),
    ],
  ),
  Row(
    children: [
      Text("Category: ",style: Theme.of(context)
          .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
          ,fontSize: 20.sp),),
      Text("${productEntity.category??"N/A"}",style: Theme.of(context)
          .textTheme.titleMedium!.copyWith(color: AppColors.primaryColor
          ,fontSize: 20.sp),),
    ],
  ),
  Row(
    children: [
      Text("Supplier: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Text("${productEntity.supplier??"N/A"}",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.primaryColor
            ,fontSize: 20.sp),),
    ],
  ),
  Row(
    children: [
      Text("Notes: ",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.greyColor
            ,fontSize: 20.sp),),
      Text("${productEntity.notes??"N/A"}",
        style: Theme.of(context).textTheme.titleMedium!.
        copyWith(color: AppColors.primaryColor
            ,fontSize: 20.sp),),
    ],
  ),


],);









  }
}

// Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Row(
// children: [
// Expanded(
// flex: 2,
// child: AddProductTextField(
// controller: productName,
//
// fieldName: "Product Name",
// hintText: "ex: USB-C",
// validator: (value) {
// if (value == null || value.trim().isEmpty) {
// return 'please enter product name';
// }
// return null;
// },
// isEnabled: true,
// ),
// ),
// SizedBox(
// width: 5.w,
// ),
// Expanded(
// child: AddProductTextField(
// hintText: "1.0",
// controller:productQuantity,
// fieldName: "Quantity",
// isEnabled: true,
// keyboardType: TextInputType.number,
// validator: (value) {
// if (value == null || value.trim().isEmpty  ) {
// return 'please enter product quantity';
// }
// return null;
// },
// ),
// ),
// ],
// ),
// SizedBox(
// height: 10.h,
// ),
// AddProductTextField(
// fieldName: "Category",
// hintText: "select category",
// isEnabled: true,
// isDropdown: true,
// controller: productCat,
// validator: (value) {
// if(value==null|| productCat.text.isEmpty){
// productCat.text = value ?? "";
// return("please select a category");
// }
// return null;
// },
// dropdownItems: ["cat1", "cat2", "cat3", "cat4", "cat5"],
// onChanged: (value) {
// productCat.text = value ?? "";
// print("Selected Category: $value");
// },
// // dropdownValue: "cat1",
// ),
// SizedBox(
// height: 10.h,
// ),
// AddProductTextField(
// fieldName: "Supplier",
// hintText: "select supplier",
// isEnabled: true,
// isDropdown: true,
// controller: productSup,
// validator: (value) {
// if(value==null|| productSup.text.isEmpty ){
// productCat.text = value ?? "";
// return("please select a supplier");
// }
//
// },
// dropdownItems: ["sup1", "sup2", "sup3", "sup4", "sup5"],
// onChanged: (value) {
// productSup.text = value ?? "";
// print("Selected Supplier: $value");
// },
// ),
// SizedBox(
// height: 10.h,
// ),
// Row(
// children: [
// Expanded(
// child: AddProductTextField(
// fieldName: "Price",
// hintText: "for one item",
// controller: productPrice,
// isEnabled: true,
// validator: (value) {
// if (value == null || value.trim().isEmpty) {
// return 'please enter product name';
// }
// return null;
// },
// keyboardType: TextInputType.number,
// suffix: Text(
// "EGP",
// style: Theme.of(context)
//     .textTheme
//     .titleMedium!
//     .copyWith(
// color: AppColors.primaryColor,
// fontSize: 16.sp),
// ),
// )),
// SizedBox(
// width: 5.w,
// ),
// Expanded(
// child: AddProductTextField(
// controller: productTotal,
// fieldName: "Total",
// isEnabled: false,
// hintText: "${total.toStringAsFixed(2)} EGP",
// )),
// ],
// ),
// SizedBox(
// height: 25.h,
// ),
// AddProductTextField(
// fieldName: "Notes",
// hintText: "Leave note about the product ...",
// isEnabled: true,
// controller:productNotes,
// ),
// SizedBox(
// height: 10.h,
// ),
//
// ],
// );


// Column(
//
// crossAxisAlignment: CrossAxisAlignment.start,
//
// children: [
//
//   Text("productModel.name",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.darkPrimaryColor
//       ,fontSize: 30.sp,overflow: TextOverflow.ellipsis ),),
//   SizedBox(height: 5.h,),
//
//   Text("price:  EGP",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
//     ,fontSize: 14.sp,overflow: TextOverflow.ellipsis,),),
//
//   Row(
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("quantity:",
//             style: Theme.of(context).textTheme.titleMedium!.
//             copyWith(color: AppColors.greyColor
//                 ,fontSize: 14.sp),),
//           Text("category: ",style: Theme.of(context)
//               .textTheme.titleMedium!.copyWith(color: AppColors.greyColor
//               ,fontSize: 14.sp),)
//         ],
//       ),
//       SizedBox(width: 20.w,),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("total: EGP",
//             style: Theme.of(context).textTheme.titleMedium!.
//             copyWith(color: AppColors.greyColor,overflow:TextOverflow.ellipsis
//                 ,fontSize: 14.sp),),
//           Text("supplier:  ",
//             style: Theme.of(context).textTheme.titleMedium!.
//             copyWith(color: AppColors.greyColor
//                 ,fontSize: 14.sp),),
//         ],
//       ),
//     ],
//   ),
//   Row(
//
//     children: [
//       ElevatedButton(onPressed: () {
//         //ToDo: edit
//       },
//           style: ButtonStyle(
//
//
//
//             minimumSize: WidgetStatePropertyAll(Size(50.w,30.h)),
//             backgroundColor: WidgetStateColor.transparent,side: WidgetStatePropertyAll(BorderSide(color: AppColors.primaryColor)),
//             elevation: WidgetStatePropertyAll(0),),
//           child: Row(
//             children: [
//               Container(
//                   height: 20.h,width: 20.w,
//
//                   decoration:BoxDecoration(
//
//                       borderRadius: BorderRadius.circular(25.r),
//                       color: AppColors.primaryColor),
//
//                   child: Icon(Icons.edit,size: 10.sp,color: AppColors.whiteColor,)),
//               SizedBox(width: 10.w,),
//               Text("Edit",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.greyColor
//                   ,fontSize: 14.sp),),
//             ],)),
//       SizedBox(width:85.w,),
//       IconButton(onPressed: () {
//
//       }, icon: Icon(Icons.delete,size: 30.sp,color: AppColors.redColor,))
//     ],
//   )
//
// ],);