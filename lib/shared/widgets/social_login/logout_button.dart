import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
          "Sair",
          style: AppTextStyles.captionShape,
        ));
  }
}
