import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_leaf_scissor/l10n/l10n.dart';
import 'package:rock_leaf_scissor/providers/local_provider.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    Locale currentLocale = localeProvider.locale;

    if (!L10n.all.contains(currentLocale)) {
      currentLocale = L10n.all.first;
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<Locale>(
        value: currentLocale,
        icon: const Icon(Icons.language),
        items: L10n.all.map((locale) {
          final flag = L10n.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Row(
              children: [
                Text(flag, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(locale.languageCode.toUpperCase()),
              ],
            ),
          );
        }).toList(),
        onChanged: (Locale? locale) {
          if (locale != null) {
            localeProvider.setLocale(locale);
          }
        },
      ),
    );
  }
}
