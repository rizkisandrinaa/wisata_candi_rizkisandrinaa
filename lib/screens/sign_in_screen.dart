import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisata_candi/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TODO: 1 Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  void signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String savedUsername = prefs.getString('username') ?? '';
    String savedPassword = prefs.getString('password') ?? '';
    String enteredUsername = _usernameController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    if(enteredUsername.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        _errorText = 'Nama pengguna dan kata sandi harus diisi';
      });
      return;
    }

    if(savedUsername.isEmpty || savedPassword.isEmpty) {
      setState(() {
        _errorText = 'Pengguna belum terdaftar. Silakan daftar terlebih dahulu.';
      });
      return;
    }

    if (enteredUsername == savedUsername && enteredPassword == savedPassword){
      setState(() {
        _errorText = '';
        _isSignedIn = true;
        prefs.setBool('isSignedIn', true);
      });
      print('isSignedIn: $_isSignedIn');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/');
      });
    } else {
      setState(() {
        _errorText = 'Nama pengguna atau kata sandi salah';
      });
    }

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // TODO: 2 Pasang AppBar
      appBar: AppBar(title: Text('Sign In'),),
      // TODO: 3 Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                child: Column(
                  // TODO: 4 Atur mainAxisAlignment dan crossAlignment
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TODO: 5 Pasang TextFormField Nama Pengguna
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: "Nama Pengguna",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // TODO: 6 Pasang TextFormField Kata Sandi
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: "Kata Sandi",
                          errorText: _errorText.isNotEmpty
                              ? _errorText
                              : null,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility
                            ),
                          )
                      ),
                      obscureText: _obscurePassword,
                    ),
                    // TODO: 7 Pasang ElevatedButton Sign In
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: (){
                          setState(() {
                            // if(_passwordController.value.text.length < 8){
                            //                             _errorText = "Password harus lebih dari atau sama dengan 8 karakter";
                            //                           } else if(!_passwordController.value.text.contains(RegExp(r'[A-Z]'))){
                            //                             _errorText = "Password harus berisi uppercase";
                            //                           } else if(!_passwordController.value.text.contains(RegExp(r'[a-z]'))){
                            //                             _errorText = "Password harus berisi lowercase";
                            //                           } else if(!_passwordController.value.text.contains(RegExp(r'[0-9]'))){
                            //                             _errorText = "Password harus berisi angka";
                            //                           } else if(!_passwordController.value.text.contains(RegExp(r'[\_\/\*\.\,]'))){
                            //                             _errorText = "Password harus berisi karakter spesial (_ / * . ,)";
                            //                           } else if(
                            //                               _passwordController.value.text.contains(_usernameController.value.text)){
                            //                             _errorText = "Password tidak boleh berisi nama pengguna anda";
                            //                           } else {
                            //                             _errorText = ''; // error text kosong saat tidak ada error
                            //                           }
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Sign In')
                    ),
                    // TODO 8: Pasang TextButton Sign Up
                    SizedBox(height: 20),
                    //TextButton(
                    //                     onPressed: (){},
                    //                     child: Text('Belum punya akun? Daftar di sini.'),
                    //                   ),
                    RichText(
                      text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Daftar di sini.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/sign_up");
                                },
                            ),
                          ]
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
