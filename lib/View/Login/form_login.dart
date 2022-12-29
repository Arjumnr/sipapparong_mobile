import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../Provider/provider_auth.dart';
import '../../WIdget/field_input.dart';
import '../../WIdget/notification.dart';
import '../../bottom_navigation.dart';

class FormLogin extends StatefulWidget {
  FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

final TextEditingController _nopPbbController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _FormLoginState extends State<FormLogin> {
  //
  AuthProvider authProvider = AuthProvider();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  //
  doLogin() {
    if (formKey.currentState!.validate()) {
      authProvider
          .login(_nopPbbController.text, _passwordController.text, context)
          .then((value) {
        if (authProvider.loggedInStatus == Status.Authenticated) {
          notifSuccess('Login Berhasil').show(context).then((value) =>
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigation())));
        } else {
          notifError('Login Gagal').show(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //

    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: FlutterEasyLoading(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Consumer<AuthProvider>(
              builder:
                  ((BuildContext context, AuthProvider value, Widget? child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                RgbColor(167, 29, 49),
                                RgbColor(120, 13, 18),
                                RgbColor(80, 13, 18),
                                RgbColor(63, 13, 18),
                              ],
                              stops: [0.1, 0.4, 0.7, 0.9],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              right: 40.0, left: 40.0, top: 120.0
                              // vertical: 120.0,
                              ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(
                                        'asset/images/logo-login.png')),
                                const SizedBox(height: 30.0),
                                buildNOPPBB(),
                                const SizedBox(height: 30.0),
                                buildPassword(),
                                const SizedBox(height: 30.0),
                                buildButtonLogin(),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ));
  }

  buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          autofocus: false,
          obscureText: _isObscure,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.black,
            ),
            hintText: 'Masukkan Password',
            hintStyle: const TextStyle(
              color: Colors.black38,
              fontFamily: 'OpenSans',
            ),
            suffixIcon: IconButton(
              color: Colors.grey,
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildNOPPBB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOP PBB',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        buildTextFormField(
          controller: _nopPbbController,
          textInputType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return 'NOP PBB tidak boleh kosong';
            }
            return null;
          },
          hintText: 'Masukkan NOP PBB',
          icon: Icons.app_registration,
        ),
      ],
    );
  }

  buildButtonLogin() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: RgbColor.fromHex('#DBC8AC'),
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            doLogin();
          }
        },
        child: const Text(
          'Masuk',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
