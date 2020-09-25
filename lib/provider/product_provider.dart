//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//
//
//
//
//import 'package:http/http.dart' as http;
//
//class Products with ChangeNotifier {
//  final String id;
//  final String title;
//  final String desc;
//  final double price;
//  final String imageUrl;
//  bool isFavorite;
//
//  Products({
//    @required this.id,
//    @required this.title,
//    @required this.desc,
//    @required this.price,
//    @required this.imageUrl,
//    this.isFavorite = false,
//  });
//
//  void _setFavValue(bool newValue) {
//    isFavorite = newValue;
//    notifyListeners();
//  }
//
//  Future<void> toggleFavoriteStatus(String token, String userId) async {
//    final oldStatus = isFavorite;
//    isFavorite = !isFavorite;
//    notifyListeners();
//    final url =
//        'https://flutter-update.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
//    try {
//      final response = await http.put(
//        url,
//        body: json.encode(
//          isFavorite,
//        ),
//      );
//      if (response.statusCode >= 400) {
//        _setFavValue(oldStatus);
//      }
//    } catch (error) {
//      _setFavValue(oldStatus);
//    }
//  }
//}
//
//class Product with ChangeNotifier {
//
//
//  bool isFavourite = false;
//
//  List<Products> items =[
//    Products(
//      id: 'p1',
//      title: '  t-Shirt',
//      desc: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:'assets/t-shirts/t-shirt1.jpg'
//      ,
//    ),
//    Products(
//      id: 'p2',
//      title: 'shoes',
//      desc: 'A red shirt - it is pretty red!',
//      price: 50.99,
//      imageUrl:'assets/shoes/shoe1.jpg'
//    ),
//    Products(
//        id: 'p3',
//        title: 't-Shirt',
//        desc: 'A red shirt - it is pretty red!',
//        price: 29.99,
//        imageUrl:'assets/t-shirts/t-shirt4.jpg'
//    ),
//    Products(
//        id: 'p4',
//        title: 'jackets',
//        desc: 'jackets- it is pretty red!',
//        price: 29.99,
//        imageUrl:'assets/jackets/jacket8.png'
//    ),
//    Products(
//        id: 'p5',
//        title: 'shoes',
//        desc: 'A red shirt - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/shoes/shoe2.jpg'
//    ),
//    Products(
//        id: 'p6',
//        title: 'trousers',
//        desc: 'trousers - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/trousers/trouser1.jpg'
//    ),
//    Products(
//        id: 'p7',
//        title: 'jackets',
//        desc: 'jackets - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/jackets/jacket7.jpg'
//    ),
//    Products(
//        id: 'p8',
//        title: 't-shirt',
//        desc: 't-shirts - it is pretty red!',
//        price: 20.99,
//        imageUrl:'assets/t-shirts/t-shirt5.jpg'
//    ),
//    Products(
//        id: 'p9',
//        title: 'trousers',
//        desc: 'trousers - it is pretty red!',
//        price: 20.99,
//        imageUrl:'assets/trousers/trouser3.jpg'
//    ),
//    Products(
//        id: 'p10',
//        title: 'jackets',
//        desc: 'jackets - it is pretty red!',
//        price: 20.99,
//        imageUrl:'assets/jackets/jacket10.jpg'
//    ),
//    Products(
//        id: 'p11',
//        title: 'trousers',
//        desc: 'trousers - it is pretty red!',
//        price: 20.99,
//        imageUrl:'assets/trousers/trouser7.jpg'
//    ),
//    Products(
//        id: 'p12',
//        title: 'jackets',
//        desc: 'jackets - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/jackets/jacket9.jpg'
//    ),
//    Products(
//        id: 'p13',
//        title: 'shoes',
//        desc: 'A red shirt - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/shoes/shoe4.jpg'
//    ),
//    Products(
//        id: 'p14',
//        title: 'shoes',
//        desc: 'A red shirt - it is pretty red!',
//        price: 50.99,
//        imageUrl:'assets/shoes/shoe6.jpg'
//    ),
//
//  ];
//
//  var _showFavoritesOnly = false;
//
//
//  List<Products> get item {
//
////    if(_showFavoritesOnly){
////      return item.where((element) => element.isFavourite).toList();
////    }
//    return [...item];
//  }
//
//
//  List<Products> get favoriteItems {
//    return items.where((element) => element.isFavorite).toList();
//  }
//
//
////  void showFavoritesOnly(){
////    _showFavoritesOnly = true;
////    notifyListeners();
////  }
////
////
////  void showAll(){
////    _showFavoritesOnly = false;
////    notifyListeners();
////  }
//
//
//  void toggleFavoriteStatus(){
//    final oldStatus = isFavourite;
//    isFavourite = !isFavourite ;
//    notifyListeners();
//    final url = 'https://firstapp-d77ef.firebaseio.com/products.json';
//    http.patch(url);
//  }
//
//
//
// Future<void> addProduct(Products products){
//    const url ='https://firstapp-d77ef.firebaseio.com/products.json';
//   return http.post(url,body:json.encode({
//      'title':products.title,
//      'desc':products.desc,
//      'imageUrl':products.imageUrl,
//      'price':products.price,
//    }),
//    ).then((value){
//      final newProduct = Products(
//        title: products.title,
//        imageUrl:  products.imageUrl,
//        price: products.price,
//        desc: products.desc,
//        id: json.decode(value.body)['name'],
//      );
//      items.add(newProduct);
////    items.insert(0, newProduct);
//      notifyListeners();
//    });
//  }
//
//
//  void deleteProduct(String id){
//    items.removeWhere((element) => element.id == id);
//    notifyListeners();
//
//  }
//
//}