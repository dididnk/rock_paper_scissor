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

    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      height: 42.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 0.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          icon: Icon(
            Icons.language,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
          dropdownColor: Theme.of(context).colorScheme.surface,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          items: L10n.all.map((locale) {
            final flag = L10n.getFlag(locale.languageCode);
            return DropdownMenuItem(
              value: locale,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(flag, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(
                      locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (Locale? locale) {
            if (locale != null) {
              localeProvider.setLocale(locale);
            }
          },
        ),
      ),
    );
  }
}
