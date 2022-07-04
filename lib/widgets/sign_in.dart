import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guru/widgets/custom_input_field.dart';
import 'package:travel_guru/widgets/forgot_password.dart';
import '../screens/dashboard.dart';

class SignInScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/Sign-In';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _fkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fkey,
      child: Column(
        children: [
          Container(
            width: 500,
            height: 250,
            margin: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/pictures/logo.jpg',
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w800,
              fontSize: 30,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              CustomInputField(
                labelText: 'Email',
                txtController: _emailController,
                iconValue: Icons.email,
                type: TextInputType.emailAddress,
                visible: false,
              ),
            ],
          ),
          const SizedBox(height: 5),
          CustomInputField(
            labelText: 'Password',
            txtController: _passwordController,
            iconValue: Icons.key,
            type: TextInputType.visiblePassword,
            visible: true,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              if (_fkey.currentState!.validate()) {
                proceed();
              }
            },
            icon: const Icon(
              Icons.app_registration,
            ),
            label: const Text('Login'),
          ),
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPassword(),
                ),
              )
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> proceed() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      String userId = credential.user!.uid;
      fetchtoDB(userId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMsg('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMsg('Wrong password provided for that user.');
      }
    }
  }

  void showMsg(String e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e),
      ),
    );
  }

  void fetchtoDB(String userId) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('accounts');

    await userCollection
        .doc(userId)
        .set({
          'email': _emailController.text,
          'password': _passwordController.text,
        })
        .then((_) => Navigator.pushNamed(
              context,
              DashboardScreen.ROUTE_NAME,
            ))
        .catchError((error) => showMsg("Failed to sign in: $error"));
  }
}
