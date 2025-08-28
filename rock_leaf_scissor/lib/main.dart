import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rock_leaf_scissor/l10n/app_localizations.dart';
import 'package:rock_leaf_scissor/l10n/l10n.dart';
import 'package:rock_leaf_scissor/pages/home_page.dart';
import 'package:rock_leaf_scissor/providers/local_provider.dart';
import 'package:rock_leaf_scissor/utils/global_constances.dart';
import 'package:rock_leaf_scissor/utils/theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: localeProvider.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.lightTheme,    
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,  
      home: const HomePage(),
    );
  }
}
