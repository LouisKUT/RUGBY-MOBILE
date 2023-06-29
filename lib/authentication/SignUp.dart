// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:rugby_mobile/authentication/auth.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
// String? errorMessage = '';
// bool isLogin = true;

// final TextEditingController _controllerEmail = TextEditingController();
// final TextEditingController _controllerPassword = TextEditingController();


// Future<void> createUserWithEmailAndPassword()async{
//   try {
//     await Auth().signInWithEmailAndPassword(
//       email: _controllerEmail.text,
//        password: _controllerPassword.text);
//   } on FirebaseAuthException catch (e){
//     setState(() {
//       errorMessage = e.message;
//     });
//   }
// }

// Widget _title(){
//   return const Text('Firebase Auth');
// }

// Widget _entryField(
//   String title ,
//   TextEditingController controller,
// ){return TextField(controller: controller,
// decoration: InputDecoration(labelText: title),
// );}

// Widget _errorMesssage(){
//   return Text(errorMessage! == 'Hum ? $errorMessage');
// }

// Widget _submitButton(){
//   return ElevatedButton(
    
    
//     onPressed: () { 
//        createUserWithEmailAndPassword;
//      },
//     child: const Text('SignUp') ,
    
    
//     );
// }

// Widget _loginOrRegistration(){
//   return TextButton(
//     onPressed: (){
//       setState(() {
//         isLogin = !isLogin;
//       });
//     }, 
    
//     child: Text(isLogin ? 'Register instead': 'Login instead'));
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: _title(),),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:<Widget> [
//             _entryField('email', _controllerEmail),
//             _entryField('password', _controllerPassword),
//             _errorMesssage(),
//             _submitButton(),
//             _loginOrRegistration()
            
//           ],
//         ),
//       ),
//     );
    
    
//   }
// }