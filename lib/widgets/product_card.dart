// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage(),

            _productDetails(),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag()
            ),

            Positioned(
              top: 0,
              left: 0,
              child: _NotAvailable()
            ),

          ],
        )
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0,5),
            blurRadius: 10
          )
        ]
      );
  }
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain, //El texto se adapta al container
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20)
          )
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      )
    );
  }
}

class _PriceTag extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain, //El texto se adapta al container
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$100.99', style: TextStyle(color: Colors.white, fontSize: 20))
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      )
    );
  }
}

class _productDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 12),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disco duro G', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis//En caso de que se pase de 1 linea.
            ),
            Text(
              'Id del disco duro', style: TextStyle(fontSize: 15, color: Colors.white)
            )
          ]
        )
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

class _BackgroundImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(//Para poder ponerle un progress indicator
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}