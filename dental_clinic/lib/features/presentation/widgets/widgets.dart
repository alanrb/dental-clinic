import 'package:dental_clinic/features/presentation/styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading);

  final String heading;

  @override
  Widget build(BuildContext context) => Text(
    heading,
    style: TextStyle(fontSize: 24),
  );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content);

  final String content;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail);

  final IconData icon;
  final String detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Icon(icon, color: Styles.color_primary),
            SizedBox(width: 8),
            Text(
              detail,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class StyledButton extends StatelessWidget {
  const StyledButton(
      {required this.child, required this.onPressed, this.isLoading});

  final bool? isLoading;
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return ElevatedButton(
        onPressed: () {},
        child: Padding(padding: Styles.space, child: Text('Loading...')),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        child: Padding(padding: Styles.space, child: child),
      );
    }
  }
}
