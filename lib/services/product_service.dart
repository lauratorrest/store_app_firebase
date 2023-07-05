


// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-c603c-default-rtdb.firebaseio.com';
  static List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;

  ProductsService(){
    loadProducts();
  }

  Future loadProducts() async{

    isLoading = true;
    notifyListeners();

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.get( url );

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return products;

  }

}