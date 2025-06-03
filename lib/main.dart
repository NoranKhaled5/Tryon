import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled15/splashscreen.dart';
import 'package:untitled15/category/watch.dart';

import 'Register/view/Register_screen_body.dart';
import 'Register/view_model/cubit.dart';
import 'category/accessories.dart';
import 'category/clothespage.dart';
import 'core/bloc.dart';
import 'core/cache_helper.dart';
import 'core/dio.dart';
import 'category/glasses.dart';
import 'login/view/login_screenbody.dart';
import 'login/view_model/cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.Init_dio();
  await CacheHelper.init();
  runApp(WatchApp());
}

class WatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
         routes: {
            'login': (context) => LoginScreen(),
            'signup': (context) => RegisterScreen(),
        },
      ),
    );
  }
}




