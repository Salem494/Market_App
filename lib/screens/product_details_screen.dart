
import 'package:flutter/material.dart';
import 'package:marketapp/provider/products.dart';
import 'package:marketapp/provider/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-detail';


  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {
  final productId =  ModalRoute.of(context).settings.arguments as String;
  final loadedProduct =  Provider.of<Products>(context,listen: false).items.firstWhere((element) => element.id == productId);
    return Scaffold(
   appBar: AppBar(
     title: Text(loadedProduct.title),
   ),
     body:SingleChildScrollView(
       child: Column(
         children: [
           Container(
             height: 300,
             width: double.infinity,
             child: Hero(
               tag: loadedProduct.id,
                 child: Image.asset(loadedProduct.imageUrl,fit: BoxFit.cover,)),
           ),
           SizedBox(height: 10,),
            Text('\$${loadedProduct.price}',style: TextStyle(color: Colors.grey,fontSize: 18),),
           SizedBox(height: 10,),
           Text(loadedProduct.desc,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w900),)
         ],
       ),
     )
    );
  }
}
