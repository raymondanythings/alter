import 'package:alter/common/styles/decorated_input_border.dart';
import 'package:alter/constants/sizes.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final bool obscureText;
  final bool multiline;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Widget? label;

  const Input({
    super.key,
    this.onSaved,
    this.validator,
    this.label,
    this.obscureText = false,
    this.multiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: multiline ? TextInputType.multiline : null,
      maxLines: multiline ? null : 1,
      obscureText: obscureText,
      clipBehavior: Clip.hardEdge,
      decoration: InputDecoration(
        label: label,
        border: DecoratedInputBorder(
          shadow: BoxShadow(
            color: Theme.of(context).secondaryHeaderColor,
            blurRadius: 5,
          ),
          child: const UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(
                Sizes.size4,
              ),
            ),
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
