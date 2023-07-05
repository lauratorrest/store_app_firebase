// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: ( _ , index) => GestureDetector(
          onTap: () => Navigator.pushNamed( _ , 'product'),
          child: ProductCard()
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){}
      ),
    );
  }
}