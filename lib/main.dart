import 'package:cashy_app/cubit/fetchCubit/fetch_data_cubit.dart';
import 'package:cashy_app/models/finance_model.dart';
import 'package:cashy_app/screens/splach/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();

  Hive.registerAdapter(FinanceModelAdapter());

  await Hive.openBox("darkModeBox");

  await Hive.openBox<FinanceModel>("financeBox");

  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),

      child: ValueListenableBuilder(
        valueListenable: Hive.box('darkModeBox').listenable(),

        builder: (context, box, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'Finance',

            themeMode: box.get('darkMode', defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,

            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: const Color(0xff121212),

              cardColor: const Color(0xff1E1E1E),
            ),

            theme: ThemeData(
              useMaterial3: true,

              scaffoldBackgroundColor: const Color(0xffF5F5F5),

              cardColor: Colors.white,
            ),

            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
