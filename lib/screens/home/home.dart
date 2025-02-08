import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/auth/login/ui/view/login_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/add_bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/home_tab/ui/view/home_tab.dart';
import 'package:trade_mate/screens/home/tabs/more_tab/ui/view/more_tab.dart';
import 'package:trade_mate/utils/app_colors.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightGreyColor,
      endDrawer:  MoreTab(),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
          Navigator.pushNamed(context, BillScreen.routeName);


        },
        child: Text("bill",textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.whiteColor)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
color: AppColors.whiteColor,
        child: BottomNavigationBar(

          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.blackColor,
backgroundColor: Colors.transparent,
          elevation: 0,

          type: BottomNavigationBarType.fixed,


          currentIndex: index,
          onTap: (value) {
            // index = value;
            // setState(() {});
            if (value == 1) {
              _scaffoldKey.currentState?.openEndDrawer();
            } else {
              setState(() {
                index = value;
              });
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home,size: 22.sp), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu,size: 22.sp), label: "More"),

          ],
        ),
      ),
    );
  }

  List<Widget> tabs = [HomeTab()];
}
