import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_matter/view/screens/authentication/login_screen.dart';
import 'package:grey_matter/view/theme/appcolor.dart';
import 'package:grey_matter/view/widgets/authenrication_widgets.dart';

import '../../../viewmodel/bloc/authentication/registration/registration_bloc.dart';
import '../../../viewmodel/bloc/authentication/registration/registration_event.dart';
import '../../../viewmodel/bloc/authentication/registration/registration_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: Scaffold(
        backgroundColor: Appcolor.background,
        appBar: AppBar(
          backgroundColor: Appcolor.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: GoogleFonts.gabriela(
              color: Appcolor.primary,
            ),
          ),
        ),
        body: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registration Successful!'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
              failure: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  Text(
                    "Let's get started",
                    style: GoogleFonts.gabriela(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Appcolor.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The latest movies and series are here',
                    style: GoogleFonts.gabriela(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Appcolor.primary,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // ---- Username Field ----
                  CustomTextField(
                    controller: userNameController,
                    hintText: 'Enter Your Name',
                    suffixIcon: const Icon(
                      Icons.sort_by_alpha,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---- Email Field ----
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Enter Your Email',
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ---- Password Field ----
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Enter Your Password',
                    obscureText: isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ---- Submit Button ----
                  state.maybeWhen(
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => CustomButton(
                      btnText: 'Sign Up',
                      onPressed: () {

                        if (userNameController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty ||
                            passwordController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields',style: GoogleFonts.gabriela(color: Colors.black),),
                              backgroundColor: Appcolor.primary,
                            ),
                          );
                          return;
                        }

                        context.read<RegistrationBloc>().add(
                          RegistrationEvent.registrationUser(
                            userName: userNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}