import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_guru/screens/dashboard.dart';
import 'package:travel_guru/widgets/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/sign-up';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fkey,
      child: SingleChildScrollView(
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
              'Sign Up',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            CustomInputField(
              labelText: 'Name',
              txtController: _nameController,
              iconValue: Icons.person,
              type: TextInputType.name,
              visible: false,
            ),
            const SizedBox(height: 5),
            CustomInputField(
              labelText: 'Email',
              txtController: _emailController,
              iconValue: Icons.email,
              type: TextInputType.emailAddress,
              visible: false,
            ),
            const SizedBox(height: 5),
            CustomInputField(
              labelText: 'Password',
              txtController: _passwordController,
              iconValue: Icons.key,
              type: TextInputType.visiblePassword,
              visible: true,
            ),
            const SizedBox(height: 5),
            CustomInputField(
              labelText: 'Confirm Password',
              txtController: _confirmPasswordController,
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
              label: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> proceed() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userId = credential.user!.uid;
      addtoDB(userId);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsg('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showMsg('The account already exists for that email.');
      }
    } catch (e) {
      showMsg(e.toString());
    }
  }

  void showMsg(String e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e),
      ),
    );
  }

  void addtoDB(String userId) async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('accounts');

    await userCollection
        .doc(userId)
        .set({
          'name': _nameController.text,
          'email': _emailController.text,
        })
        .then((_) => Navigator.pushNamed(
              context,
              DashboardScreen.ROUTE_NAME,
            ))
        .catchError((error) => showMsg("Failed to add user: $error"));
  }
}
