import 'package:flutter/material.dart';
import 'package:marketapp/provider/auth.dart';
import 'package:marketapp/provider/cart.dart';
import 'package:marketapp/provider/products.dart';
import 'package:marketapp/screens/auth_screen.dart';
import 'package:marketapp/screens/cart_screen.dart';
import 'package:marketapp/screens/edit_product_screen.dart';
import 'package:marketapp/screens/order_screen.dart';
import 'package:marketapp/screens/product_details_screen.dart';
import 'package:marketapp/screens/product_overview_screen.dart';
import 'package:marketapp/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          // ignore: deprecated_member_use
          builder: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
//            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
    ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Market',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          home: AuthScreen(),

//          auth.isAuth
//              ? OverViewScreen()
//              : FutureBuilder(
//            future: auth.tryAutoLogin(),
//            builder: (ctx, authResultSnapshot) =>
//            authResultSnapshot.connectionState ==
//                ConnectionState.waiting
//                ? SplashScreen()
//                : AuthScreen(),
//          ),
          routes: {
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            OverViewScreen.routeName: (ctx) => OverViewScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

