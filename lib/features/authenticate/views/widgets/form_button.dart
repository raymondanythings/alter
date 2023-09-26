import 'package:alter/constants/sizes.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    this.onTap,
    this.text,
  });
  final String? text;
  final bool disabled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled && onTap != null ? onTap : null,
      child: FractionallySizedBox(
        widthFactor: 1,
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
          child: AnimatedDefaultTextStyle(
            duration: const Duration(
              milliseconds: 100,
            ),
            style: TextStyle(
              color: disabled
                  ? Colors.grey.shade400
                  : Theme.of(context).textTheme.displayMedium!.color,
              fontWeight: FontWeight.w600,
            ),
            child: Text(
              text ?? "Next",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
