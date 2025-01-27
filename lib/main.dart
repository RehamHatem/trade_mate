
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trade_mate/screens/auth/login/ui/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trade_mate/screens/auth/signup/ui/view/signup_screen.dart';
import 'package:trade_mate/screens/home/home.dart';
import 'package:trade_mate/screens/home/tabs/add_product/ui/view/add_product_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/add_bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/bill/ui/view/bill_screen.dart';
import 'package:trade_mate/screens/home/tabs/categories/ui/view/category_products.dart';
import 'package:trade_mate/screens/home/tabs/categories/ui/view/category_screen.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/ui/view/add_customer_screen.dart';
import 'package:trade_mate/screens/home/tabs/cutomers/ui/view/customers_screen.dart';
import 'package:trade_mate/screens/home/tabs/orders/ui/view/orders_screen.dart';
import 'package:trade_mate/screens/home/tabs/stock/ui/view/stock_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/add_supplier_screen.dart';
import 'package:trade_mate/screens/home/tabs/suppliers/ui/view/suplliers_screen.dart';
import 'package:trade_mate/screens/widgets/splash.dart';
import 'package:trade_mate/utils/app_theme.dart';
import 'package:trade_mate/utils/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final path =await getApplicationDocumentsDirectory();
  Hive.init(path.path);
  print("Hive data stored at: ${path}");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute:Splash.routeName,
        theme: AppTheme.mainTheme,
        routes: {
          Splash.routeName:(context)=>Splash(),
          LoginScreen.routeName:(context)=>LoginScreen(),
          SignupScreen.routeName:(context)=>SignupScreen(),
          Home.routeName:(context)=>Home(),
          OrdersScreen.routeName:(context)=>OrdersScreen(),
          StockScreen.routeName:(context)=>StockScreen(),
          SuplliersScreen.routeName:(context)=>SuplliersScreen(),
          CustomersScreen.routeName:(context)=>CustomersScreen(),
          AddProductScreen.routeName:(context)=>AddProductScreen(),
          AddSupplierScreen.routeName:(context)=>AddSupplierScreen(),
          AddCustomerScreen.routeName:(context)=>AddCustomerScreen(),
          AddBillScreen.routeName:(context)=>AddBillScreen(),
          BillScreen.routeName:(context)=>BillScreen(),
          CategoryScreen.routeName:(context)=>CategoryScreen(),
          CategoryProducts.routeName:(context)=>CategoryProducts(),

        },
      ),
    );
  }
}







