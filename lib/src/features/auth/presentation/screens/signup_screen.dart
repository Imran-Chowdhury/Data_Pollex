import 'package:data_pollex/src/core/constants/role.dart';
import 'package:data_pollex/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/custom_button.dart';
import '../widget/signup_form.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // String _role = Role.teacher; // Default role
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final ValueNotifier<String> _roleNotifier = ValueNotifier(Role.teacher);

  // bool _isTeacher = true;
  // bool _isStudent = false;
  //
  // void _toggleRole(String role) {
  //   setState(() {
  //     if (role == Role.teacher) {
  //       _isTeacher = true;
  //       _isStudent = false;
  //       _role = Role.teacher;
  //     } else {
  //       _isTeacher = false;
  //       _isStudent = true;
  //       _role = Role.student;
  //     }
  //   });
  // }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      // if (_password != _confirmPassword) {
      // if (passwordController.text.trim() !=
      //     confirmPasswordController.text.trim()) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Passwords do not match!'),
      //   ));
      //   return;
      // }

      await ref.read(authViewModelProvider.notifier).signUp(
            // name: _name,
            // email: _email,
            // password: _password,
            // role: _role,
            // context: context
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim(),
            confirmPasswordController.text.trim(),
            _roleNotifier.value,
          );
      // Navigator.pushNamed(context, '/signIn');
      // }
      // catch (e) {
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text(e.toString()),
      //     ));
      //   }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(authViewModelProvider, (prev, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error!),
        ));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;
    // final visibleState = ref.watch(obscureControllerProvider);
    // final confirmVisibleState = ref.watch(confirmPasswordVisibilityProvider);

    Size size = MediaQuery.sizeOf(context);
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.only(top: width * 0.1, left: width * .01),
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: Image.asset(
                    //       'assets/images/signup2.png', // Your image path
                    //       height: height * 0.4,
                    //     ),
                    //   ),
                    // ),
                    const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Welcome to Ichiban Auto Limited',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: height * 0.03),

                    ///Form
                    SignUpForm(
                      formKey: _formKey,
                      nameController: nameController,
                      height: height,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      roleNotifier: _roleNotifier,
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.2, right: width * 0.2),
                      child: CustomButton(
                        screenHeight: height,
                        buttonName: 'Sign Up',
                        // buttonColor: const Color(0xFFffc801),
                        buttonColor: const Color(0XFFd71e23),
                        icon: const Icon(
                          // size: 20,
                          Icons.app_registration_sharp,
                          color: Colors.white,
                        ),
                        onpressed: () {
                          signUp();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
