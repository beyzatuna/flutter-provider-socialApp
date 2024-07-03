import 'package:flutter/material.dart';
import 'package:provider_project/providers/user_providers/auth_provider.dart';
import 'package:provider_project/widgets/custom_button.dart';
import 'package:provider_project/widgets/custom_text_field.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthProvider _authProvider = AuthProvider();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Any asynchronous setup can be done here.
  }

  void _handleSignUp(BuildContext context) async {
    try {
      await _authProvider.signUpWithEmailAndPassword(
        context,
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Diğer işlemler...
    } catch (e) {
      print("Error During Registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                _handleSignUp(context);
              },
              text: "Sign Up",
            ),
            TextButton(
              onPressed: () async {
                await Navigator.pushReplacementNamed(context, 'login_page');
              },
              child: const Text("Do you have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
