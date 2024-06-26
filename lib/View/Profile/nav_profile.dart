import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:sipapparong_mobile/View/Profile/profile_edit.dart';
import 'package:sipapparong_mobile/WIdget/widget.dart';
import 'package:sipapparong_mobile/constant.dart';
import 'package:sipapparong_mobile/Provider/provider_profile.dart';
import '../../Data/Database/db_provider.dart';
import '../../Model/model_user.dart';
import '../Login/form_login.dart';

class NavProfile extends StatefulWidget {
  const NavProfile({Key? key}) : super(key: key);

  @override
  State<NavProfile> createState() => _NavProfileState();
}

class _NavProfileState extends State<NavProfile> {
  ProfileProvider profileProvider = ProfileProvider();
  DatabaseProvider dbProvider = DatabaseProvider();
  User userModel = User();
  Zone zone = Zone();

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
      zone = Zone.fromJson(dataUser['zone']);
      isLoading = false;
    });
  }

  _onLogout() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profil",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: colorAPPBARrgb,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Edit Profil',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
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
                          'NPWR : ${userModel.npwr.toString()}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                ],
              ),
            ),
            isLoading ? loadingListView() : buildDetailProfileEmail(),
            isLoading ? loadingListView() : buildDetailNoHP(),
            isLoading ? loadingListView() : buildDetailAlamat(),
            isLoading ? loadingListView() : buildDetailJenisAngkutan(),
            isLoading ? loadingListView() : buildDetailZonaAngkutan(),
            isLoading ? loadingListView() : buildDetailDetailAngkutan(),
            isLoading ? loadingListView() : buildDetailTarif(),
            isLoading ? loadingListView() : buildDetailVolume(),
            isLoading ? loadingListView() : buildDetailTagihan(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          isLoading ? null : _onLogout();
          await Future.delayed(const Duration(seconds: 2));
          await dbProvider.deleteToken();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const FormLogin(),
            ),
          );
        },
        label: const Text('Keluar'),
        icon: isLoading
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Icon(Icons.logout),
        backgroundColor: HsbColor.fromHex('#30475E'),
      ),
    );
  }

  // Widget buildEditNoHp() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'No. Telepon',
  //           style: TextStyle(
  //             color: Colors.black,
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(10),
  //             boxShadow: const [
  //               BoxShadow(
  //                 color: Colors.black26,
  //                 blurRadius: 2,
  //                 offset: Offset(0, 2),
  //               ),
  //             ],
  //           ),
  //           height: 60,
  //           child: TextFormField(
  //             controller: _noHpController,
  //             validator: (value) =>
  //                 value!.isEmpty ? 'No. Telepon tidak boleh kosong' : null,
  //             keyboardType: TextInputType.number,
  //             style: const TextStyle(
  //               color: Colors.black87,
  //               fontFamily: 'OpenSans',
  //             ),
  //             decoration: const InputDecoration(
  //               border: InputBorder.none,
  //               contentPadding: EdgeInsets.only(top: 14),
  //               prefixIcon: Icon(
  //                 Icons.add_ic_call,
  //                 color: Colors.black,
  //               ),
  //               hintText: '',
  //               hintStyle: TextStyle(
  //                 color: Colors.black38,
  //                 fontFamily: 'OpenSans',
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildDetailProfileEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: buildDetailUserProfile(user.name, 'Name',EditNameProfile() ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child:
            buildListProfile(userModel.email.toString(), 'Email', Icons.email),
      ),
    );
  }

  Widget buildDetailNoHP() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: buildListProfile(
            userModel.phoneNumber.toString() == 'null'
                ? '-'
                : userModel.phoneNumber.toString(),
            'Nomor Telepon',
            Icons.add_ic_call),
      ),
    );
  }

  Widget buildDetailAlamat() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: buildDetailUserProfile(user.name, 'Name',EditNameProfile() ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: buildListProfile(
            userModel.address.toString(), 'Alamat', Icons.add_location_alt),
      ),
    );
  }

  Widget buildDetailJenisAngkutan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: buildDetailUserProfile(user.name, 'Name',EditNameProfile() ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: buildListProfile(zone.transportationType.toString(),
            'Jenis Angkutan', Icons.airport_shuttle),
      ),
    );
  }

  Widget buildDetailZonaAngkutan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: buildDetailUserProfile(user.name, 'Name',EditNameProfile() ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: buildListProfile(zone.transportZone.toString(), 'Zona Angkutan',
            Icons.all_inclusive),
      ),
    );
  }

  Widget buildDetailDetailAngkutan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // child: buildDetailUserProfile(user.name, 'Name',EditNameProfile() ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: buildListProfile(
            'Bangunan Permanen  ', 'Detail Angkutan', Icons.home),
      ),
    );
  }

  Widget buildDetailTarif() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: ListTile(
          title: Text(
            zone.rateInRupiah.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          subtitle: const Text(
            'Tarif',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          leading: const Icon(Icons.money),
        ),
      ),
    );
  }

  Widget buildDetailVolume() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: ListTile(
          title: Text(
            userModel.wasteVolume.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          subtitle: const Text(
            'Volume Sampah',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          leading: const Icon(Icons.photo_size_select_small),
        ),
      ),
    );
  }

  Widget buildDetailTagihan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        width: 400,
        child: ListTile(
          title: Text(
            zone.monthlyBillInRupiah.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          subtitle: const Text(
            'Tagihan Perbulan',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
            ),
          ),
          leading: const Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
