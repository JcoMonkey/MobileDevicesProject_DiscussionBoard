import 'package:flutter/material.dart';
import '../widgets/theme_provider.dart';
import 'package:provider/provider.dart';

class ChangeThemeColor extends StatelessWidget {
  const ChangeThemeColor({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SimpleDialog(
      title: const Text('Select color'),
      children: <Widget>[
        SimpleDialogOption(
          onPressed: () {
            themeProvider.changePrimarySwatch(Colors.purple);
            Navigator.pop(context);
          },
          child: const Text('Purple'),
        ),
        SimpleDialogOption(
          onPressed: () {
            themeProvider.changePrimarySwatch(Colors.indigo);
            Navigator.pop(context);
          },
          child: const Text('Indigo'),
        ),
      ],
    );
  }
}
