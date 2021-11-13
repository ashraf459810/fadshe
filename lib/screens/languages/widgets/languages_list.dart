import 'package:fad_shee/models/data/language.dart';
import 'package:fad_shee/screens/languages/widgets/languages_list_item.dart';
import 'package:fad_shee/theme/AppColors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LanguagesList extends StatelessWidget {
  List<Language> languages = [
    Language(code: 'ar', name: 'العربية'),
    Language(code: 'en', name: 'English'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: languages.length,
        separatorBuilder: (ctx, index) => Container(height: 1, color: AppColors.lightGrey),
        itemBuilder: (ctx, index) => LanguagesListItem(
          languages[index],
        ),
      ),
    );
  }
}
