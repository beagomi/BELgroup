
import 'package:flutter/material.dart';
import 'package:my_project/screens/home.dart';
import 'package:my_project/utils/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static bool _passwordVisible = false;
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController(); 
  final _formKey = GlobalKey<FormState>();
  final Impact impact = Impact();

  void _showPassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 50, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo_provvisorio.png',
                  scale: 4,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Login',
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  controller: userController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.person,
                    ),
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showPassword();
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  onTap: () {
                    _selectDate(context); // to select date of birth
                  },
                  readOnly: true,
                  controller: dobController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Date of Birth is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                    ),
                    hintText: 'Date of Birth',
                  ),
                ),
                const SizedBox(height: 15),

                //button to log in 
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        //if username and password are correct get and store the tokens
                        if (_formKey.currentState!.validate()) {
                          final result = await impact.getAndStoreTokens(
                              userController.text, passwordController.text);

                          //save username, password and DOB (used for data elaboration) in SP
                          if (result == 200) {
                            final sp = await SharedPreferences.getInstance();
                            await sp.setString('username', userController.text);
                            await sp.setString('password', passwordController.text);
                            await sp.setString('dob', dobController.text); 

                            //go to the home page
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            );

                          //wrong username or password   
                          } else {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(8),
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text("username or password incorrect")));
                          }
                        }
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 12)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 57, 73, 171))),
                      child: const Text('Log In'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //used to select DOB
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        dobController.text = picked.toIso8601String().split('T')[0]; // properly format dob
      });
    }
  }
}
