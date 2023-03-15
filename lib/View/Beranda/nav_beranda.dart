import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:sipapparong_mobile/Model/model_pembayaran_home.dart';
import 'package:sipapparong_mobile/Provider/provider_home.dart';
import 'package:sipapparong_mobile/WIdget/widget.dart';

import '../../constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NavBeranda extends StatefulWidget {
  const NavBeranda({Key? key}) : super(key: key);

  @override
  State<NavBeranda> createState() => _NavBerandaState();
}

class _NavBerandaState extends State<NavBeranda> {
  HomeProvider homeProvider = HomeProvider();
  var isLoading = false;
  var cek = "";

  User user = User();
  Zone zone = Zone();
  LatestMonthlyBill latestMonthlyBill = LatestMonthlyBill();
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
      colorTheme: ColorTheme(
        colorPrimary: HsbColor.fromHex('#30475E'),
        colorPrimaryDark: HsbColor.fromHex('#30475E'),
      ),
    ));

    midtransSDK?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );

    midtransSDK!.setTransactionFinishedCallback((result) {
      log('connect');
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
      zone = Zone.fromJson(data['zone']);

      // log(user.npwr.toString());
      if (data['latest_monthly_bill'].isEmpty) {
        log('is empty');
        cek = "";
      } else {
        latestMonthlyBill =
            LatestMonthlyBill.fromJson(data['latest_monthly_bill']);
        cek = latestMonthlyBill.snapToken.toString();
      }
      // jika data kosong

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
        radius: const Radius.circular(12),
        color: Colors.grey,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 100,
            width: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Tagihan Terakhir Anda',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                isLoading
                    ? loadingText()
                    : Text(
                        latestMonthlyBill.totalInRupiah.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataPembayaran() {
    return DottedBorder(
      color: Colors.grey.shade300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        'Bulan : ${latestMonthlyBill.dateInMonthYear}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
          ),
          buildJumlahTagihan(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nomor Tagihan : '),
                isLoading
                    ? loadingText()
                    : Text(latestMonthlyBill.number.toString()),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text('Volume Sampah : '),
          //       isLoading ? loadingText() : Text(zone.volume.toString()),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ? loadingText()
                    : Text(zone.transportationType.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading ? loadingText() : Text(zone.transportZone.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading ? loadingText() : Text(user.address.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading ? loadingText() : Text(zone.rateInRupiah.toString()),
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
                        token: latestMonthlyBill.snapToken.toString(),
                      );
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
            padding: const EdgeInsets.only(left: 20),
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
                        "NPWR : ${user.npwr.toString()}",
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
            padding: const EdgeInsets.only(
              right: 20,
            ),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                CircleAvatar(
                  radius: 30,
                  backgroundImage: const AssetImage('asset/images/default.png'),
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
    // log('fullHeight: $fullHeight');
    // var peddingTop = MediaQuery.of(context).padding.top;
    // log('peddingTop: $peddingTop');
    // var heightAPPBAR = AppBar().preferredSize.height;
    // log('heightUpAPPBAR: $heightAPPBAR');
    // var totHeight = fullHeight - heightAPPBAR - peddingTop;
    // log('totHeight: $totHeight');
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cek.isNotEmpty
                        ? buildDataPembayaran()
                        : isLoading
                            ? buildDataPembayaran()
                            : buildTidakAdaTagihan(),
                  ),
                ),
              ),
            ),
            // buildDataPembayaran(),
          ],
        ),
      )),
    );
  }
}

buildTidakAdaTagihan() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Image.asset(
            'asset/images/tagihan-lunas.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Tidak Ada Tagihan',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    ],
  );
}
