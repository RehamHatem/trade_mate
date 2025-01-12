import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/tab_bar_item.dart';

import '../../../../../../utils/app_colors.dart';
import 'bill_tab.dart';

class BillScreen extends StatefulWidget {
  static const String routeName="bill screen";
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();

}

class _BillScreenState extends State<BillScreen>  with TickerProviderStateMixin {
  List<String> bills = ["Bill 1"];
  late TabController _tabController;
  int selectedindex=0;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  void _initializeTabController() {
    _tabController = TabController(length: bills.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  void _addNewBill() {
    setState(() {
      bills.add("Bill ${bills.length + 1}");
      _rebuildTabController();
    });
  }

  void _removeBill(String bill) {
    if (bills.length > 1) {
      setState(() {
        bills.remove(bill);
        _rebuildTabController();
      });
    }
  }

  void _rebuildTabController() {
    _tabController.dispose();
    _initializeTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: WidgetStateColor.transparent,
        surfaceTintColor: WidgetStateColor.transparent,
        centerTitle: true,
        title: Text(
          'Bills',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(
              fontSize: 25.sp,
              color: AppColors.darkPrimaryColor),
        ),

      ),
      body: Column(
        children: [

          Padding(
            padding:  EdgeInsets.only(right: 10.w,left: 10.w),
            child: Row(

              children: [
                Expanded(
                  child: TabBar(
                    isScrollable: true,

                    controller: _tabController,

                    unselectedLabelColor: AppColors.primaryColor,
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontSize: 20.sp,
                        color: AppColors.darkPrimaryColor ),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontSize: 20.sp,
                        color: AppColors.whiteColor),
                    indicatorColor: AppColors.darkPrimaryColor,
                    indicatorWeight: 0,
                    dividerColor:  AppColors.darkPrimaryColor,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,

                    labelPadding:EdgeInsets.zero,
                    overlayColor: WidgetStatePropertyAll(WidgetStateColor.transparent),
                                indicator: BoxDecoration(),
                    onTap: (value) {
                      setState(() {
                        selectedindex=value;

                      });
                    },

                    tabs: bills
                        .map(
                            (bill) {
                          return Tab(
                            child:Row(
                              children: [

                                TabBarItem(bill: bill,isSelected: bills.elementAt(selectedindex)==bill,removeBill:_removeBill,),
                                SizedBox(width: 6.w,),
                              ],
                            ),
                          );}
                    )
                        .toList(),
                  ),
                ),

                InkWell(

                  child: Column(
                    children: [
                      Container(
                          width: 35.w,
                          height:53.h,
                          decoration: BoxDecoration(borderRadius:BorderRadius.only(
                              topLeft: Radius.circular(15.r) ),
                              color: AppColors.darkPrimaryColor),
                          child: Icon(Icons.add,color: AppColors.whiteColor, size: 20.sp,)),
                      Container(height: 1.7.h,width: 35.h,decoration: BoxDecoration(color: AppColors.darkPrimaryColor,),)
                    ],
                  ),
                  onTap: _addNewBill,
                ),

              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,

              children: bills.map((bill) {
                return BillTab(billName: bill);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
