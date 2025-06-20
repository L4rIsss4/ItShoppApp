import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itshop/ui/views/cubit/adminPageCubit.dart';
import 'package:itshop/ui/views/cubit/loginCubit.dart';
import 'package:itshop/ui/views/cubit/resetpasswordCubit.dart';
import 'package:itshop/ui/views/cubit/signUpCubit.dart';
import 'package:itshop/ui/views/Pages/firstpage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => PasswordResetCubit()),
        BlocProvider(create: (_) => AdminPageCubit()), // Global cubit (tüm sayfalarda geçerli olacak)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IT Shop Admin Panel',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const firstPage(), // Buradaki sınıf ismini büyük harfle yazmalısın
      ),
    );
  }
}
