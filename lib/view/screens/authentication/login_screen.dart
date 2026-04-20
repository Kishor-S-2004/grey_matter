import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/view/screens/authentication/register_screen.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/authenrication_widgets.dart';
import 'package:grey_matter/view/widgets/bottomnavi.dart';
import 'package:grey_matter/viewmodel/bloc/authentication/login/login_event.dart';

import '../../../viewmodel/bloc/authentication/login/login_bloc.dart';
import '../../../viewmodel/bloc/authentication/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;
  bool isEmailTapped = false;
  bool isPasswordTapped = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Appcolor.background,
        appBar: AppBar(
          backgroundColor: Appcolor.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Login',
            style: GoogleFonts.gabriela(color: Appcolor.primary),
          ),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              loaded: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged In'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message), backgroundColor: Colors.red),
                );
              },
            );
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
              
                    Text(
                      'Hi User',
                      style: GoogleFonts.gabriela(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Appcolor.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome Back! Please Enter Your Details',
                      style: GoogleFonts.gabriela(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Appcolor.primary,
                      ),
                    ),
              
                    const SizedBox(height: 50),
              
                    CustomTextField(
                      onTap: (){
                        setState(() {
                          isEmailTapped = true;
                          isPasswordTapped = false;
                        });
                      },
                      controller: emailController,
                      hintText: 'Enter Your Email',
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      suffixIcon: Icon(Icons.person, color: isEmailTapped ? Appcolor.primary : Colors.grey),
                    ),
              
                    const SizedBox(height: 20),

                    CustomTextField(
                      onTap: (){
                       setState(() {
                         isPasswordTapped = true;
                         isEmailTapped = false;
                       });
                      },
                      controller: passwordController,
                      hintText: 'Enter Your Password',
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: isObscure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                          color: isPasswordTapped ? Appcolor.primary : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                            isPasswordTapped = true;
                            isEmailTapped = false;
                          });
                        },
                      ),
                    ),
              
                    const SizedBox(height: 40),
              
                    state.maybeWhen(
              
                      loading: () => CircularProgressIndicator(),
                      orElse: () => CustomButton(
                        btnText: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginEvent.loginUsers(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
              
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Dont have an account',
                        style: GoogleFonts.gabriela(color: Appcolor.primary),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
