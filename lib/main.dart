import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_task/app_language.dart';
import 'package:news_app_task/storage_helper.dart';
import 'package:news_app_task/views/book_marks_view.dart';
import 'package:news_app_task/views/category_view.dart';
import 'package:news_app_task/views/home_view.dart';
import 'package:news_app_task/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'cubits/bookMarks_cubit/book_marks_cubit.dart';
import 'cubits/search_cubit/search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLanguageProvider appLanguageProvider = AppLanguageProvider();
  await appLanguageProvider.fetchLocale();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appLanguageProvider),
      ],
      child: DevicePreview(builder: (BuildContext context)=> MyApp(isFirstTime: isFirstTime)),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
       return Consumer<AppLanguageProvider>(
      builder: (context, appLanguageProvider, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => BookmarksCubit(DatabaseHelper.instance)..loadBookmarks(),
            ),
            BlocProvider<SearchCubit>(
              create: (_) => SearchCubit(),
            ),
          ],
          child: MaterialApp(
            builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            locale: Locale(appLanguageProvider.locale),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [Locale('en'), Locale('ar')], // صححت vi إلى ar
            theme: ThemeData(
              fontFamily: 'PlayfairDisplay',
              textTheme: const TextTheme(
                bodyLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
                bodyMedium: TextStyle(fontFamily: 'PlayfairDisplay'),
                titleLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
                titleMedium: TextStyle(fontFamily: 'PlayfairDisplay'),
              ),
            ),
            home: isFirstTime ? MyCustomSplashScreen() : HomeView(),
            routes: {
              MyCustomSplashScreen.id: (context) => MyCustomSplashScreen(),
              HomeView.id: (context) => HomeView(),
              BookMarksView.id: (context) => BookMarksView(),
              CategoryView.id: (context) => CategoryView(),
            },
          ),
        );
      },
    );
  }
}
