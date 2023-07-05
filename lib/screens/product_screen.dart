// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                ProductImage(),
                Positioned(
                  top: 35,
                  left: 20,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, size: 25, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop()
                  )
                ),

                Positioned(
                  top: 35,
                  right: 20,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt_outlined, size: 25, color: Colors.white),
                    onPressed: (){}
                  )
                )
              ],
            ),

            _ProductForm(),

            SizedBox(height: 100)

          ]
        )
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: (){}
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [

              TextFormField(
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de producto',
                  labelText: 'Nombre: '
                )
              ),

              SizedBox(height: 20),

              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio: '
                )
              ),
              
              SizedBox(height: 20),

              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value){
                  
                }
              )
            ]
          )
        )
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          offset: Offset(0,5),
          blurRadius: 5
        )
      ]
    );
  }
}