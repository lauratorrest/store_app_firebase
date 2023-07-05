// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 180),
              CardContainer(
                child: Column(
                  children: [
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
      
                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _LoginForm()
                    ) //Solo lo que esta dentro tiene acceso al NotifierProvider
                  ],
                )
              ),

              SizedBox(height: 50),
              Text('Crear nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 50)
            
            ],
          )
        )
      )
    );
  }
}

class _LoginForm extends StatefulWidget {

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'jhon.doe@example.com',
              labelText: 'Email',
              prefixIcon: Icons.alternate_email_sharp
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                ? null
                : 'El valor no parece ser un correo';
            }
          ),

          SizedBox(height: 30),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*******',
              labelText: 'Password',
              prefixIcon: Icons.lock_outline
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value){
              return (value != null && value.length >= 6)
                ? null
                : 'La clave debe ser de 6 caracteres';
            }
          ),

          SizedBox(height: 30),

          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading
                  ? 'Espere...'
                  : 'Ingresar',
                style: TextStyle(color: Colors.white)
              )
            ),
            onPressed: loginForm.isLoading ? null : () async {

              FocusScope.of(context).unfocus(); //Quitar teclado

              if(!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              await Future.delayed(Duration(seconds: 2));

              Navigator.pushReplacementNamed(context, 'home');
            }
          )


        ],
      ),
    );
  }
}