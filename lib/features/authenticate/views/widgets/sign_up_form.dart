import 'package:alter/constants/sizes.dart';
import 'package:alter/features/authenticate/view_models/sign_up_view_model.dart';
import 'package:alter/features/authenticate/views/widgets/form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final Function()? onNavigationtap;
  const SignUpForm({super.key, this.onNavigationtap});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSaveFormData(String key, String? value) {
    if (value != null) {
      formData[key] = value;
    }
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        ref
            .read(signUpProvider.notifier)
            .signUp(formData["email"]!, formData["password"]!, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) => _onSaveFormData("email", newValue),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (newValue) =>
                        _onSaveFormData("password", newValue),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Plase write your password";
                      }
                      return null;
                    },
                  ),
                  FormButton(
                    onTap: _onSubmitTap,
                    disabled: false,
                    text: "Join",
                  ),
                  CupertinoButton(
                    onPressed: widget.onNavigationtap,
                    child: const Text("Login"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
