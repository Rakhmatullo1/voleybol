import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String firstName = _emailController.text;
      String lastName = _passwordController.text;
      await _dbHelper.insertUser(firstName, lastName);
      try {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text('Credentials saved successfully!'), backgroundColor: Colors.green[200],),
        );
      } finally {
        Navigator.of(context).pushNamed(HomeScreen.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.asset("assets/images/running.png")),
                const SizedBox(height: 20),
                // Email Field
                TextFormField(
                  cursorColor: accentColor,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Ism",
                      style: TextStyle(color: accentColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ismni kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: accentColor,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Familiya",
                      style: TextStyle(color: accentColor),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: accentColor),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Familiyani kiriting';
                    }
                    return null;
                  },
                ),
                // Password Field
                const SizedBox(height: 20),
                // Login Button
                ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      backgroundColor: accentColor),
                  child: const Text('Ro\'yxatdan o\'tish',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
