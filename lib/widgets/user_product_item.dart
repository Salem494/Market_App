import 'package:flutter/material.dart';
import 'package:marketapp/provider/products.dart';
import 'package:marketapp/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProduct(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    void salem(){
      showDialog(context: (context),
          builder:(context) => AlertDialog(
            title: Text('Delete'),
            content: Text('Do You Delete it Product?'),
            actions: [
              FlatButton(onPressed: () {
                Provider.of<Products>(context).deleteProduct(id);
                Navigator.of(context).pop();
              },
                  child:Text('Yes',style: TextStyle(color: Colors.blue),)),
              FlatButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child:Text('NO',style: TextStyle(color:Colors.red,))),
            ],
           )
      );

    }

    return ListTile(
          title: Text(title),
          leading: CircleAvatar(backgroundImage: AssetImage(imageUrl),),
          trailing: Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){

                  Navigator.of(context).pushReplacementNamed(EditProductScreen.routeName,arguments: id);
                },
                    icon:Icon(Icons.edit) ),

                IconButton(onPressed: () {
                   salem();
                  },
                  icon:Icon(Icons.delete),color: Theme.of(context).errorColor, ),
              ],
            ),
          ),
    );
  }
}
