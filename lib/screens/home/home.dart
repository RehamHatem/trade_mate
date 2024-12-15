import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/login/ui/view/login_screen.dart';
import 'package:trade_mate/screens/home/tabs/bills_tab/bills.dart';
import 'package:trade_mate/screens/home/tabs/categories_tab/categories.dart';
import 'package:trade_mate/screens/home/tabs/products_tab/products.dart';
import 'package:trade_mate/screens/home/tabs/suppliers_tab/suppliers.dart';
import 'package:trade_mate/utils/app_colors.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // flexibleSpace: Container(
        //   decoration: ShapeDecoration(
        //     color: Colors.red,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.vertical(
        //         bottom: Radius.circular(50.r), // Curved Bottom
        //       ),
        //     ),
        //   ),
        // ),


        title: Text(
          "trade mate",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 30.sp),
        ),
        actions: [
          IconButton(
              onPressed: () {
                // FirebaseFunctions.logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.routeName, (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: tabs[index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,


        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.sp)),
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (context) {
          //     return Container(
          //         padding: EdgeInsets.only(
          //             bottom: MediaQuery.of(context).viewInsets.bottom),
          //         child: TaskModelSheet());
          //   },
          // );
        },
        child: index==0?Text("bill",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor)):index==1?Text("sup",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor)):index==2?Text("cat",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor)):Text("pro",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),

        child: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.blackColor,
backgroundColor: Colors.transparent,
          elevation: 0,

          type: BottomNavigationBarType.fixed,



          currentIndex: index,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.shopify,size: 22.sp), label: "Bills"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle,size: 22.sp), label: "Suppliers"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category,size: 22.sp), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.store_rounded,size: 22.sp), label: "Products"),
          ],
        ),
      ),
    );
  }

  List<Widget> tabs = [Bills(),Suppliers(),Categories(),Products()];
}
