import '/screens/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Load language texts as preffed EN
  await TextDecider().setPreferredLanguage('EN').load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => LoginRepository()),
        Provider(create: (context) => LoginFormWidget()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: MainPage(),
      ),
    );
  }
}
