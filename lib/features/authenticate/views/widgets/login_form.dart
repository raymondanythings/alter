import 'package:alter/common/views/widgets/input.dart';
import 'package:alter/constants/gaps.dart';
import 'package:alter/constants/sizes.dart';
import 'package:alter/features/authenticate/view_models/login_view_model.dart';
import 'package:alter/features/authenticate/views/widgets/form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  final Function()? onNavigationtap;
  const LoginForm({super.key, this.onNavigationtap});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
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
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(loginProvider).isLoading;
    return Padding(
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
                Input(
                  onSaved: (newValue) => _onSaveFormData(
                    "email",
                    newValue,
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your email";
                    }
                    return null;
                  },
                  label: const Text(
                    "Email",
                  ),
                ),
                Gaps.v10,
                Input(
                  obscureText: true,
                  onSaved: (newValue) => _onSaveFormData("password", newValue),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Plase write your password";
                    }
                    return null;
                  },
                  label: const Text(
                    "Password",
                  ),
                ),
                Gaps.v10,
                FormButton(
                  onTap: !isLoading ? _onSubmitTap : () {},
                  disabled: isLoading,
                  child: isLoading
                      ? const SizedBox(
                          height: Sizes.size14,
                          child: CupertinoActivityIndicator(),
                        )
                      : AnimatedDefaultTextStyle(
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          style: TextStyle(
                            color: isLoading
                                ? Colors.grey.shade400
                                : Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .color,
                            fontWeight: FontWeight.w600,
                          ),
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
                CupertinoButton(
                  onPressed: widget.onNavigationtap,
                  child: const Text("Create Account"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
