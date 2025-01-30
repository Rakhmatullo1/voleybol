import 'package:appnew/helper/db_helper.dart';
import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NewDataWidget extends StatefulWidget {
  const NewDataWidget({super.key});

  @override
  State<NewDataWidget> createState() => _NewDataWidgetState();
}

class _NewDataWidgetState extends State<NewDataWidget> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _heightController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  final RegExp regExp = RegExp("\\d+");

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submitForm(String firstName, String lastName, String id) async {
    if (_formKey.currentState!.validate()) {
      String age = _ageController.text;
      String weight = _weightController.text;
      String height = _heightController.text;

      await dbHelper
          .insertUserDetails(id, firstName, lastName, age, weight, height)
          .then((_) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Credentials saved successfully!'),
            backgroundColor: Colors.green[200],
          ),
        );
      }).then((_) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dbHelper.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: accentColor,
            );
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator(
              color: accentColor,
            );
          }

          Map<String, dynamic> data = snapshot.data!;
          String firstName = data["first_name"];
          String lastName = data["last_name"];
          int id = data["id"];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            color: backGroungColor,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Expanded(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                          'assets/images/profile.webp'), // Replace with your image asset
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      alignment: const Alignment(0, 0),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        data == null
                            ? "Guest"
                            : data!["first_name"]! + " " + data!["last_name"]!,
                        style: const TextStyle(
                            color: secondaryColor, fontSize: 18),
                        softWrap: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      text("Yosh"),
                      Expanded(
                        child: TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: getDecoration("Yoshni kiriting"),
                            validator: (value) =>
                                getValidator("Yoshni kiriting", value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      text("Vazn"),
                      Expanded(
                        child: TextFormField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: getDecoration("Vaznni kiriting (kg)"),
                            validator: (value) =>
                                getValidator("Vaznni kiriting", value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      text("Bo'y"),
                      Expanded(
                        child: TextFormField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: getDecoration("Bo'yni kiriting (cm)"),
                            validator: (value) =>
                                getValidator("Bo'yni kiriting", value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(firstName, lastName, "$id"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor),
                      child: const Text(
                        'Yakunlash',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget text(String name) {
    return Expanded(
        child: Text(
      name,
      style: const TextStyle(
          fontSize: 24, color: accentColor, fontWeight: FontWeight.w500),
    ));
  }

  InputDecoration getDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: accentColor),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: accentColor)),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: accentColor)),
    );
  }

  String? getValidator(String hint, String? value) {
    if (value == null || value.isEmpty) {
      return hint;
    }
    if (!regExp.hasMatch(value)) {
      return "Enter valid value";
    }
    return null;
  }
}
