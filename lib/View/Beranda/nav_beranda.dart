import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:sipapparong_mobile/Model/model_pembayaran_home.dart';
import 'package:sipapparong_mobile/Provider/provider_home.dart';
import 'package:sipapparong_mobile/WIdget/widget.dart';

import '../../constant.dart';
import '../Tagihan/Bayar Tagihan/informasi_produk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NavBeranda extends StatefulWidget {
  NavBeranda({Key? key}) : super(key: key);

  @override
  State<NavBeranda> createState() => _NavBerandaState();
}

class _NavBerandaState extends State<NavBeranda> {
  HomeProvider homeProvider = HomeProvider();
  var isLoading = false;
  LatestMonthlyBill latestMonthlyBill = LatestMonthlyBill();
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300]!, blurRadius: 30, offset: Offset(0, 10))
  ];

  User user = User();
  MidtransSDK? midtransSDK;
  @override
  void initState() {
    super.initState();
    _fetchData();
    initSDK();
  }

  void initSDK() async {
    midtransSDK = await MidtransSDK.init(
        config: MidtransConfig(
            clientKey: dotenv.env['MIDTRANS_CLIENT_KEY']!,
            merchantBaseUrl: dotenv.env['MIDTRANS_BASE_URL']!,
            // colorTheme: ColorTheme(
            //   colorPrimary: Theme.of(context).colorScheme.secondary,
            //   colorPrimaryDark: Theme.of(context).colorScheme.secondary,
            //   colorSecondary: Theme.of(context).colorScheme.secondary,
            // ),
            enableLog: true));
    midtransSDK?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );

    midtransSDK!.setTransactionFinishedCallback((result) {
      print('Transaction finished: $result');
    });
  }

  @override
  void dispose() {
    midtransSDK?.removeTransactionFinishedCallback();
    super.dispose();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    var data = await homeProvider.getDataHome();
    setState(() {
      user = User.fromJson(data['user']);
      // latestMonthlyBill = LatestMonthlyBill.fromJson(data['latest_monthly_bill']);
      isLoading = false;
    });
  }

  AppBar buildappBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        "Retribusi Sampah",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
      titleSpacing: 00.0,
      centerTitle: true,
      toolbarOpacity: 0.8,
      elevation: 0.00,
      primary: true,
      backgroundColor: HsbColor.fromHex('#30475E'),
    );
  }

  Widget buildIconInvoice() {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.article_outlined, size: 100, color: Colors.grey.shade700),
        ],
      ),
    );
  }

  Widget buildJumlahTagihan() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        color: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 100,
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tagihan Terakhir Anda',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp. 250.000',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataPembayaran() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DottedBorder(
            color: Colors.grey.shade300,
            child: Column(
              children: [
                buildJumlahTagihan(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nomor Tagihan : '),
                      Text('1234567890'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Volume Sampah : '),
                      Text('10 m3'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Pengangkutan Sampah Rumah Tangga'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Zona 1 - Lorong/Gang/Setapak'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Industri Rumah Tangga Kecil'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Tarif Rp. 25.000/m3 '),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            midtransSDK?.startPaymentUiFlow(
                              token: '1f34b6d4-bd07-4fc2-8bd2-d966f7a1ce80',
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => InformasiProduk(),
                            //   ),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorButton,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Bayar Tagihan',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTop() {
    return Container(
      // padding: EdgeInsets.
      height: 100,
      color: colorProfileBeranda,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        user.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                isLoading
                    ? loadingText()
                    : Text(
                        "NOPBPP : ${user.nopPbb.toString()}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              right: 20,
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('asset/images/default.png'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var fullHeight = MediaQuery.of(context).size.height;
    // print('fullHeight: $fullHeight');
    // var peddingTop = MediaQuery.of(context).padding.top;
    // print('peddingTop: $peddingTop');
    // var heightAPPBAR = AppBar().preferredSize.height;
    // print('heightUpAPPBAR: $heightAPPBAR');
    // var totHeight = fullHeight - heightAPPBAR - peddingTop;
    // print('totHeight: $totHeight');
    // Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      // backgroundColor: HsbColor.fromHex('#30475E'),
      backgroundColor: Colors.white,
      appBar: buildappBar(),
      body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
        color: HsbColor.fromHex('#30475E'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfileTop(),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: buildDataPembayaran(),
            ),
            // buildDataPembayaran(),
          ],
        ),
      )),
    );
  }
}
