import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/components.dart';
import '../../../Register/view/Register_screen_body.dart';
import '../../../Register/view/widget/Register_screen.dart';
import '../../../Register/view_model/cubit.dart';
import '../../../home.dart';
import '../../view_model/cubit.dart';
import '../../view_model/states.dart';

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key? key}) : super(key: key);

  bool isvisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  Future<void> storeTokenInSharedPreferences(String token) async {
    CacheHelper.saveData(key: "token", value: token);
  }

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
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
            title: Text('Login', style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24), // Changed horizontal padding
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centered form fields
                  children: [
                    SizedBox(height: 30), // Increased the spacing
                    Image.asset(
                      "assets/bags/logo.jpg",
                      height: 140,
                    ),
                    SizedBox(height: 20),
                    defaultFormField(
                      controller: emailController,
                      prifex:Icons.email,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      label: 'Email',
                    ),
                    SizedBox(height: 20),
                    defaultFormField(
                      suffix:LoginCubit.get(context).suffix4 ,
                      isPassword: LoginCubit.get(context).isPassword4,
                      maxline: 1,
                      suffixpressed: (){
                        LoginCubit.get(context).changePasswordVisibility4();
                      },
                      controller: passwordController,
                      prifex:Icons.lock,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      label: 'Password',
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          isvisible = true;

                          LoginCubit.get(context).login(
                            context,
                            emailController.text,
                            passwordController.text,
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
                      child: state is LoginLoadingState
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Login',
                        style:TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?  ", style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (_) => RegisterCubit(),
                                  child: RegisterScreen(), // أو RegisterScreenBody إذا كنت تستخدمه مباشرة
                                ),
                              ),
                            );
                          },

                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B2A5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),// Added spacing after the button
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