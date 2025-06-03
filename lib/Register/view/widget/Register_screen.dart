import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/components.dart';
import '../../../home.dart';
import '../../../login/view/login_screenbody.dart';
import '../../view_model/cubit.dart';
import '../../view_model/states.dart';


class RegisterScreenBody extends StatefulWidget {
  RegisterScreenBody({Key? key}) : super(key: key);

  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  bool isvisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> storeTokenInSharedPreferences(String token) async {
    CacheHelper.saveData(key: "token", value: token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, RegisterStates state) {
        if(state is RegisterSuccessState){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  CategoriesScreen (),
            ),
          );
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF4B2A5F),
            title: Text('Register',style: TextStyle(color: Colors.white),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/bags/logo.jpg",
                      height: 140,

                    ),
                    SizedBox(height: 16),
                    defaultFormField(
                      prifex:Icons.person,
                      controller: nameController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else if (nameController.text.length < 3) {
                          return 'Name must be more than 3 characters';
                        }
                        return null;
                      },
                      label: 'Name',
                    ),
                    SizedBox(height: 16),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      prifex:Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      label: 'Email',
                    ),

                    SizedBox(height: 16),
                    defaultFormField(
                      controller: passwordController,
                      prifex:Icons.lock,
                      isPassword:  RegisterCubit.get(context).isPassword,
                      type: TextInputType.visiblePassword,
                      maxline: 1,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      suffix:RegisterCubit.get(context).suffix ,
                      suffixpressed: (){
                        RegisterCubit.get(context).changePasswordVisibility();
                      },
                      label: 'Password',
                    ),
                    SizedBox(height: 16),
                    defaultFormField(
                      maxline: 1,
                      prifex:Icons.lock,
                      isPassword: RegisterCubit.get(context).isPassword3,
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      suffix:RegisterCubit.get(context).suffix3 ,
                      suffixpressed: (){
                        RegisterCubit.get(context).changePasswordVisibility3();
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password again';
                        } else if (passwordController.text != confirmPasswordController.text) {
                          return 'Confirm password doesn\'t match password';
                        }
                        return null;
                      },
                      label: 'Confirm Password',
                    ),
                    SizedBox(height: 16),
                    // ... Other form fields ...

                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          isvisible = true;
                          RegisterCubit.get(context).addRegister(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            ConfirmPassword: confirmPasswordController.text, phone: '',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF4B2A5F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(312, 48),
                      ),
                      child: state is RegisterLoadingState
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ', style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Login here',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B2A5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}