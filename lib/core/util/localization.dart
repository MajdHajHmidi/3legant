import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations localization(BuildContext context) {
  return AppLocalizations.of(context)!;
}

dynamic getValueWithDirection(BuildContext context, dynamic ltr, dynamic rtl) {
  if (Directionality.of(context) == TextDirection.ltr) {
    return ltr;
  }

  return rtl;
}
