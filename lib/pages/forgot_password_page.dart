import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override

  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override

  //?
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    //herhangi bir hata var mı 
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text("Şifre sıfırlama linki gönderildi."),
        );
      },
     );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(e.message.toString()),
        );
      },
     );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Şifre sıfırlama linki için e-posta adresinizi girin',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
              ),
          ),

          SizedBox(height: 25),

  
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey.shade200,
                hintStyle: TextStyle(color: Colors.grey[500])
              ),
            ),
          ),

          SizedBox(height: 10),

          MaterialButton(
          onPressed: passwordReset,  
          child: Text('Şifreyi sıfırlayın'),
          color: Colors.grey[500],
          
          ),
        ],
      ),
    );
  }
}

























