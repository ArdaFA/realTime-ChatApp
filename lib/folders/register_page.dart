import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/authentication/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  // sign up
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match !"),),);
      return;
    }
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword( // method which we've created in auth_service
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // logo
                  Icon(
                    Icons.app_registration,
                    size: 80,
                    color: Colors.brown[800],
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // message
                  Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.brown[800],
                    ),
                  ),

                  const SizedBox(
                    height: 28,
                  ),

                  // email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false),

                  const SizedBox(
                    height: 20,
                  ),

                  // password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),

                  const SizedBox(
                    height: 20,
                  ),

                  // password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm password',
                      obscureText: true),

                  const SizedBox(
                    height: 20,
                  ),

                  //sign in button
                  MyButton(
                    text: "Sign up",
                    onTap: signUp,),

                  const SizedBox(
                    height: 40,
                  ),

                  // not a member?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already a member?',
                        style: TextStyle(
                            color: Colors.brown[800]
                        ),),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text('Log in now!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800]
                          ),),
                      )
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
