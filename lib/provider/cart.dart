import 'package:flutter/cupertino.dart';


class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}


class Cart with ChangeNotifier {
  Map<String, CartItem> items = {};

  Map<String, CartItem> get _items {
    return {...items};
  }

  int get itemCount {
    return items.length;
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId,
      double price,
      String title,
      ) {
    if (items.containsKey(productId)) {
      // change quantity...
      items.update(
        productId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      items.putIfAbsent(
        productId,
            () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!items.containsKey(productId)) {
      return;
    }
    if (items[productId].quantity > 1) {
      items.update(
          productId,
              (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity - 1,
          ));
    } else {
      items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    items = {};
    notifyListeners();
  }
}