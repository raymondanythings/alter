import 'package:alter/constants/sizes.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    this.onTap,
    this.text,
    required this.child,
  });
  final String? text;
  final bool disabled;
  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled && onTap != null ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 100,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color: disabled
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
          ],
        ),
      ),
    );
  }
}
