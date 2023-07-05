// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider(productsService.selectedProduct),
      child: _ProductScreenBody(productService: productsService)
    );

    //return _ProductScreenBody(productService: productService);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,//Cuando se haga scroll se oculta teclado
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
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

            _ProductForm(productService: productService),

            SizedBox(height: 100)

          ]
        )
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: (){
          if(!productForm.isValidForm()) return;
          productService.saveCreateProduct(productForm.product);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Cambios guardados con éxito. ✔️"),
          ));
          FocusScope.of(context).requestFocus(FocusNode());//Ocultar teclado al guardar
        }
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  final ProductsService productService;
  const _ProductForm({super.key, required this.productService});

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value){
                  if(value == null || value.length < 1){
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de producto',
                  labelText: 'Nombre: '
                )
              ),

              SizedBox(height: 10),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value){
                  if(double.tryParse(value) == null){
                    product.price = 0;
                  }else{
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio: '
                )
              ),
              
              SizedBox(height: 10),

              SwitchListTile.adaptive(
                value: product.available,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) => productForm.updateAvailability(value)
              ),
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