import 'package:flutter/material.dart';
import 'package:marketapp/provider/cart.dart';
import 'package:marketapp/provider/product.dart';
import 'package:marketapp/provider/products.dart';
import 'package:marketapp/screens/cart_screen.dart';
import 'package:marketapp/widgets/app_drawer.dart';
import 'package:marketapp/widgets/badge.dart';
import 'package:marketapp/widgets/product_grid.dart';
import 'package:provider/provider.dart';

  enum FilterOptions{
    Favorite,
    All
  }


class OverViewScreen extends StatefulWidget {

  static const routeName = '/over-screen';

  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {


  List<Products>loadedProducts;

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);
    final pro = Provider.of<Products>(context);

    var _showOnlyFavorite = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
       actions: [
         PopupMenuButton(
           onSelected: (FilterOptions selectedValue){
            setState(() {
              if(selectedValue == FilterOptions.Favorite){

                _showOnlyFavorite = true;
              }else{
                _showOnlyFavorite = false;
              }
            });
           },
           itemBuilder: (_) =>[
             PopupMenuItem(
               child: Text('Only Favorite'),
               value: FilterOptions.Favorite,
             ),
             PopupMenuItem(child: Text('All'),value: FilterOptions.All,),
           ],
         ),
          SizedBox(width:10),
         Stack(
           children: [
             IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
               Navigator.of(context).pushNamed(CartScreen.routeName);
             }),
             Badge(value: cart.itemCount.toString(),),
           ],
          )



       ],
      ),
      body: ProductGrid(_showOnlyFavorite),
      drawer: AppDrawer(),
    );
  }
}
