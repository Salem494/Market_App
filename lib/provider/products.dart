import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:marketapp/provider/product.dart';
import '../provider/product.dart';
import '../models/excption.dart';

class Products with ChangeNotifier {

  List<Product> items = [
    Product(
      id: 'p1',
      title: '  t-Shirt',
      desc: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl: 'assets/t-shirts/t-shirt1.jpg',
    ),
    Product(
        id: 'p2',
        title: 'shoes',
        desc: 'A red shirt - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/shoes/shoe1.jpg'),
    Product(
        id: 'p3',
        title: 't-Shirt',
        desc: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl: 'assets/t-shirts/t-shirt4.jpg'),
    Product(
        id: 'p4',
        title: 'jackets',
        desc: 'jackets- it is pretty red!',
        price: 29.99,
        imageUrl: 'assets/jackets/jacket8.png'),
    Product(
        id: 'p5',
        title: 'shoes',
        desc: 'A red shirt - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/shoes/shoe2.jpg'),
    Product(
        id: 'p6',
        title: 'trousers',
        desc: 'trousers - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/trousers/trouser1.jpg'),
    Product(
        id: 'p7',
        title: 'jackets',
        desc: 'jackets - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/jackets/jacket7.jpg'),
    Product(
        id: 'p8',
        title: 't-shirt',
        desc: 't-shirts - it is pretty red!',
        price: 20.99,
        imageUrl: 'assets/t-shirts/t-shirt5.jpg'),
    Product(
        id: 'p9',
        title: 'trousers',
        desc: 'trousers - it is pretty red!',
        price: 20.99,
        imageUrl: 'assets/trousers/trouser3.jpg'),
    Product(
        id: 'p10',
        title: 'jackets',
        desc: 'jackets - it is pretty red!',
        price: 20.99,
        imageUrl: 'assets/jackets/jacket10.jpg'),
    Product(
        id: 'p11',
        title: 'trousers',
        desc: 'trousers - it is pretty red!',
        price: 20.99,
        imageUrl: 'assets/trousers/trouser7.jpg'),
    Product(
        id: 'p12',
        title: 'jackets',
        desc: 'jackets - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/jackets/jacket9.jpg'),
    Product(
        id: 'p13',
        title: 'shoes',
        desc: 'A red shirt - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/shoes/shoe4.jpg'),
    Product(
        id: 'p14',
        title: 'shoes',
        desc: 'A red shirt - it is pretty red!',
        price: 50.99,
        imageUrl: 'assets/shoes/shoe6.jpg'),
  ];

  final String authToken;
  final String userId;

  Products(
      this.authToken,
      this.userId,
      );



  List<Product> get _items{
    return [...items];
  }

  List<Product> get favoriteItems {
    return items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((prod) => prod.id == id);
  }
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://firstapp-d77ef.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url = 'https://firstapp-d77ef.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          desc: prodData['description'],
          price: prodData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
        ));
      });

      items = loadedProducts;
      notifyListeners();

     }
    catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://firstapp-d77ef.firebaseio.com';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.desc,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        title: product.title,
        desc: product.desc,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://firstapp-d77ef.firebaseio.com/products';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.desc,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://firstapp-d77ef.firebaseio.com';
    final existingProductIndex = items.indexWhere((prod) => prod.id == id);
    var existingProduct = items[existingProductIndex];
    items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
