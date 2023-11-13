import 'package:flutter/gestures.dart';
import'package:flutter/material.dart';

class sign_in_screen extends StatelessWidget{
  sign_in_screen({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedin = false;
  bool _obscurePassword = true;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      // TODO: 2. Passang Appbar
      appBar: AppBar(title: Text('Sign In'),),
      // TODO: 3. Pasang body
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // TODO: 4. Atur mainAxisAligment dan crossAxisAligmnet
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO: 5. Pasang TextFormField nama pengguna
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Nama Pengguna",
                    border: OutlineInputBorder(),
                  ),
                ),
                // TODO: 6 Pasang TextFormField kata sandi
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Kata Sandi",
                    errorText: _errorText.isNotEmpty ? _errorText : null,
                    border: OutlineInputBorder(),
                  ),
                  obscureText: _obscurePassword,
                ),
                // TODO: 7. Pasang ElevatedButton Sign In
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: (){
                    setState(){
                      if(_passwordController.value.text.length <8){
                        _errorText= "Password harus lebih dari atau sama dengan 8 karakter";
                      } else {
                        _errorText = '';
                      }
                    }
                  },
                  child: Text("Sign In"),
                ),
                // TODO: 8 Pasang TextButton Sign up
                SizedBox(height: 10),
                TextButton(
                    onPressed: (){},
                    child: Text('Belum punya akun? Daftar di sini')),
                RichText(
                  text: TextSpan(
                    text: 'Belum punya akun?',
                    style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Daftar di sini. ',
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap= (){},
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );


  }
}