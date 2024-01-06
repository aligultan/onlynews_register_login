import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modernlogintute/components/my_button.dart';
import 'package:modernlogintute/components/my_textfield.dart';
import 'package:modernlogintute/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordContoller=TextEditingController();

  // kayıt ol butonu
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // kullanıcı oluşturma
    try {
      // şifreler eşleşiyo mu
      if(passwordController.text==confirmPasswordContoller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      }else {
        //hata ver
        showErrorMessage("Şifreler eşleşmiyor!");
      }
      
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // hata mesajı

      showErrorMessage(e.code);
      
    }
  }

  // hata mesajı
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return  AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              // logo
              const Icon(
                Icons.person,
                size: 150,
              ),

              const SizedBox(height: 20),

              // logonun altındaki yazı
              Text(
                'Hadi hesabını oluştur!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Şifre',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //şifreyi onayla
              MyTextField(
                controller: confirmPasswordContoller,
                hintText: 'Şifreyi Onayla',
                obscureText: true,
              ),

              

              const SizedBox(height: 25),

              // giriş yap butonu
              MyButton(
                text: "Kayıt ol",
                onTap: signUserUp,
              ),

              const SizedBox(height: 50),

              // ya da bunlarla devam et
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google apple vs butonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(imagePath: 'lib/images/apple.png'),
                  SizedBox(width: 25),
                  
                  SquareTile(imagePath: 'lib/images/facebook.png'),
                  SizedBox(width: 25),

                  SquareTile(imagePath: 'lib/images/x2.png'),
                  SizedBox(width: 25),

                  SquareTile(imagePath: 'lib/images/linkedin.png'),
                  SizedBox(width: 25),
                ],
              ),

              const SizedBox(height: 50),

              // üye değil misin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:widget.onTap,
                    child: Text(
                      'Zaten üye misin?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Şimdi giriş yap',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}