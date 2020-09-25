import 'package:flutter/material.dart';
import 'package:marketapp/provider/auth.dart';
import 'package:marketapp/screens/order_screen.dart';
import 'package:marketapp/screens/product_overview_screen.dart';
import 'package:marketapp/screens/user_product_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Column(
        children: [
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text('Shop'),
            leading: Icon(Icons.shop),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OverViewScreen.routeName);
            },
          ),
          Divider(color: Colors.grey.shade700,),
          ListTile(
            title: Text('Order'),
            leading: Icon(Icons.payment),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
          ),
          Divider(color: Colors.grey.shade700,),
          ListTile(
            title: Text('Manage Product'),
            leading: Icon(Icons.edit),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(color: Colors.grey.shade700,),
          ListTile(
            title: Text('Logged Out'),
            leading: Icon(Icons.logout),
            onTap: (){
              Navigator.of(context).pop();
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),

        ],
      ) ,);
  }


}
