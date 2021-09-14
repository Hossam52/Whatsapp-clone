import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsappclone/bloc_observer.dart';
import 'package:whatsappclone/model_view_controller/chats/cubits/all_chats_cubit.dart';
import 'package:whatsappclone/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(DevicePreview(
    builder: (_) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllChatsCubit>(create: (_) => AllChatsCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff128C7E),
            accentColor: Colors.grey,
            textTheme: TextTheme(bodyText1: TextStyle(fontSize: 24))),
        home: HomeScreen(),
      ),
    );
  }
}
