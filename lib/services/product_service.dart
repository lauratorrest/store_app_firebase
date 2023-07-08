


// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier{

  final String _baseUrl = 'flutter-varios-c603c-default-rtdb.firebaseio.com';
  static List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

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

  Future saveCreateProduct(Product product) async{
    isSaving = true;
    notifyListeners();

    if(product.id == null){
      await createProduct(product);
    }else{
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createProduct(Product product) async{

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.post( url , body: product.toJson() );
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];//Name es el id en el json q genera firebase
    products.add(product);

    return product.id!;

  }

  Future<String> updateProduct(Product product) async{

    final url = Uri.https( _baseUrl, 'products/${ product.id }.json');
    final resp = await http.put( url , body: product.toJson() );
    final decodedData = resp.body;

    //Actualizar listado
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;

  }

  void updateSelectedProductImage(String path){
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async{
    if(newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/du1lw1gw9/image/upload?upload_preset=mhpydicu');

    final imageUploadRequest = http.MultipartRequest('POST',url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}