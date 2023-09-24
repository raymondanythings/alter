import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeUrl = "/login";
  static const String routeName = "login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Phone Number"),
      ),
      body: Center(
        child: CupertinoListSection.insetGrouped(
          header: const Text('My Reminders'),
          children: [
            CupertinoListTile.notched(
              leading: Text(
                "Korea",
                style: TextStyle(
                  color: Colors.blue.shade500,
                ),
              ),
              title: const Text(''),
              trailing: const CupertinoListTileChevron(),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (BuildContext context) {
                    return const Scaffold(
                      body: Text('??'),
                    );
                  },
                ),
              ),
            ),
            CupertinoListTile.notched(
              leading: const Text(
                '+82',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              title: CupertinoTextField(
                placeholder: "your phone number",
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.transparent,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class LoginScreen extends StatelessWidget {
//   static const String routeUrl = "/login";
//   static const String routeName = "login";
//   final _phoneController = TextEditingController();
//   final _codeController = TextEditingController();

//   LoginScreen({super.key});

//   Future<bool?> loginUser(String phone, BuildContext context) async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     auth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (AuthCredential credential) async {
//         Navigator.of(context).pop();

//         UserCredential result = await auth.signInWithCredential(credential);
//         if (result.user == null) return;
//         User user = result.user!;

//         if (user != null) {
//           print(user);
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => HomeScreen(
//           //       user: user,
//           //     ),
//           //   ),
//           // );
//         } else {
//           print("Error");
//         }

//         //This callback would gets called when verification is done auto maticlly
//       },
//       verificationFailed: (FirebaseAuthException exception) {
//         print(exception);
//       },
//       codeSent: (String verificationId, forceResendingToken) {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text("Give the code?"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     TextField(
//                       controller: _codeController,
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   MaterialButton(
//                     textColor: Colors.white,
//                     color: Colors.blue,
//                     onPressed: () async {
//                       final code = _codeController.text.trim();
//                       AuthCredential credential = PhoneAuthProvider.credential(
//                         verificationId: verificationId,
//                         smsCode: code,
//                       );

//                       UserCredential result =
//                           await auth.signInWithCredential(credential);

//                       if (result.user != null) {
//                         User user = result.user!;
//                         print(user);
//                       } else {
//                         print("Error");
//                       }
//                     },
//                     child: const Text("Confirm"),
//                   )
//                 ],
//               );
//             });
//       },
//       codeAutoRetrievalTimeout: (verificationId) => print(verificationId),
//     );
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.all(32),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Colors.lightBlue,
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: const BorderRadius.all(Radius.circular(8)),
//                     borderSide: BorderSide(
//                       color: Colors.grey.shade200,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                       borderRadius: const BorderRadius.all(Radius.circular(8)),
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade300,
//                       )),
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   hintText: "Mobile Number",
//                 ),
//                 controller: _phoneController,
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 child: MaterialButton(
//                   textColor: Colors.white,
//                   padding: const EdgeInsets.all(16),
//                   onPressed: () {
//                     final phone = _phoneController.text.trim();
//                     print(phone);

//                     loginUser(phone, context);
//                   },
//                   color: Colors.blue,
//                   child: const Text("LOGIN"),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
