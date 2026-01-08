import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final cedulaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    cedulaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const Text('Datos de cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

           
              TextFormField(
                controller: cedulaController,
                keyboardType: TextInputType.number,
                maxLength: 10,
         
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Cédula (10 dígitos)',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                  counterText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese la cédula';
                  if (value.length != 10) return 'Debe tener exactamente 10 dígitos';

            
                  
                  int provincia = int.parse(value.substring(0, 2));
                  if (provincia < 1 || (provincia > 24 && provincia != 30)) return 'Cédula incorrecta';

              
                  List<int> coeficientes = [2, 1, 2, 1, 2, 1, 2, 1, 2];
                  int suma = 0;
                  
                  for (int i = 0; i < coeficientes.length; i++) {
                    int digito = int.parse(value.substring(i, i + 1)) * coeficientes[i];
                    if (digito > 9) digito -= 9;
                    suma += digito;
                  }

                  int resultado = 10 - (suma % 10);
                  if (resultado == 10) resultado = 0;

           
                  int ultimoDigito = int.parse(value.substring(9, 10));
                  if (resultado != ultimoDigito) return 'Cédula incorrecta';

                  return null; 
                },
              ),
              const SizedBox(height: 20),

              // --- CAMPO CORREO ---
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Ingrese su correo';
                  if (!value.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // --- CAMPO CONTRASEÑA ---
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Contraseña incorrecta';
               
                  bool esValida = RegExp(r'[A-Z]').hasMatch(value) && 
                                  RegExp(r'[0-9]').hasMatch(value) && 
                                  RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value) &&
                                  value.toLowerCase().contains('pucetec');

                  if (!esValida) return 'Contraseña incorrecta';
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registro exitoso')),
                    );
                  }
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}