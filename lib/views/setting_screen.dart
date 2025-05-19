import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../app_language.dart';

class LanguageSwitchView extends StatelessWidget {
  static const String id = 'languageSwitch';

  const LanguageSwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Consumer<AppLanguageProvider>(
      builder: (context, appLanguageProvider, _) {
        bool isEnglish = appLanguageProvider.locale == 'en';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.setting,
              style: TextStyle(fontSize: w * 0.05),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isEnglish
                      ? "Current language: English"
                      : "اللغة الحالية: العربية",
                  style: TextStyle(fontSize: w * 0.045),
                ),
                SizedBox(height: h * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🇪🇬 Arabic', style: TextStyle(fontSize: w * 0.04)),
                    Switch(
                      value: isEnglish,
                      onChanged: (value) {
                        String newLocale = value ? 'en' : 'ar';
                        appLanguageProvider.updateLanguage(newLocale);
                      },
                    ),
                    Text('English 🇬🇧', style: TextStyle(fontSize: w * 0.04)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}