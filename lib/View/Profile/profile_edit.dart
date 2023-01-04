import 'package:flutter/material.dart';
import 'package:sipapparong_mobile/Provider/provider_auth.dart';
import 'package:sipapparong_mobile/View/Profile/nav_profile.dart';
import 'package:sipapparong_mobile/WIdget/notification.dart';
import 'package:sipapparong_mobile/constant.dart';
import '../../Model/model_user.dart';
import '../../Provider/provider_profile.dart';
import '../../Widget/widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _alamatController = TextEditingController();
TextEditingController _noHpController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileProvider profileProvider = ProfileProvider();
  AuthProvider authProvider = AuthProvider();
  User userModel = User();
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    isLoading = true;
    var dataUser = await profileProvider.getDataProfile();
    setState(() {
      userModel = User.fromJson(dataUser['user']);
      isLoading = false;
      _emailController.text = userModel.email.toString();
      _noHpController.text = userModel.phoneNumber.toString();
      _alamatController.text = userModel.address.toString();
    });
  }

  doUpdate() {
    if (formKey.currentState!.validate()) {
      profileProvider
          .updateProfile(_emailController.text, _noHpController.text,
              _alamatController.text, context)
          .then((value) {
        if (value == true) {
          notifSuccess('Berhasil Ubah Profile')
              .show(context)
              .then((value) => Navigator.pop(context));
        } else {
          notifError('Gagal Ubah Profile').show(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ubah Profil",
          style: TextStyle(),
        ),
        centerTitle: true,
        elevation: 0.00,
        backgroundColor: colorAPPBARrgb,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => NavProfile()));
          },
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('asset/images/default.png'),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      isLoading
                          ? loadingText()
                          : Text(
                              userModel.name.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      isLoading
                          ? loadingText()
                          : Text(
                              'NopPbb : ${userModel.nopPbb.toString()}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                    ],
                  ),
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        buildEditEmail(),
                        buildEditNoHp(),
                        buildEditAlamat(),
                        buildBtnUpdate()
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Widget buildBtnUpdate() {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
          color: colorButton, borderRadius: BorderRadius.circular(10)),
      child: TextButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            doUpdate();
          } else {
            notifError('Gagal Ubah Profile').show(context);
          }
        },
        child: const Text(
          'Ubah',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildEditAlamat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alamat',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60,
            child: TextFormField(
              controller: _alamatController,
              validator: (value) =>
                  value!.isEmpty ? 'Alamat tidak boleh kosong' : null,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.add_location_alt,
                  color: Colors.black,
                ),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value!.isEmpty ? 'Email tidak boleh kosong' : null,
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditNoHp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No. Telepon',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 60,
            child: TextFormField(
              controller: _noHpController,
              validator: (value) =>
                  value!.isEmpty ? 'No. Telepon tidak boleh kosong' : null,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black87,
                fontFamily: 'OpenSans',
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.add_ic_call,
                  color: Colors.black,
                ),
                hintText: '',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
