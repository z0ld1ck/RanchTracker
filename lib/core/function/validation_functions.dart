import 'package:flutter/material.dart';

typedef Validator = String? Function(String?)?;

// TODO: fix localization
class ValidationFunctions {
  Validator isEmpty(BuildContext context) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'fieldCannotBeEmpty'; //AppLocalizations.of(context)!.fieldCannotBeEmpty.capitalize();
      }
      return null;
    };
  }

  Validator isEmptyOrInvalidNumber(BuildContext context) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'fieldCannotBeEmpty'; //AppLocalizations.of(context)!.fieldCannotBeEmpty.capitalize();
      } else if (double.tryParse(value.replaceAll(' ', '')) == null) {
        return 'fieldCannotBeEmpty'; //AppLocalizations.of(context)!.fieldMustBeNumber.capitalize();
      }
      return null;
    };
  }

  Validator isInvalidNumber(BuildContext context) {
    return (value) {
      if (value == null || value.isEmpty) {
        return null;
      } else if (double.tryParse(value.replaceAll(' ', '')) == null) {
        return 'fieldCannotBeEmpty'; //AppLocalizations.of(context)!.fieldMustBeNumber.capitalize();
      }
      return null;
    };
  }
}
