

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:sipapparong_mobile/Model/model_pembayaran_home.dart';
import 'package:sipapparong_mobile/WIdget/widget.dart';

import '../../Provider/provider_home.dart';
import '../../constant.dart';

class DetailTagihan extends StatefulWidget {
  const DetailTagihan(
      {super.key,
      required this.id,
      required this.number,
      required this.date,
      required this.total,
      required this.snapToken,
      required this.orderId,
      required this.paidStatus,
      required this.totalInRupiah,
      required this.dateInMonthYear});
  final int id;
  final String number;
  final String date;
  final int total;
  final String snapToken;
  final String orderId;
  final String paidStatus;
  final String totalInRupiah;
  final String dateInMonthYear;

  @override
  State<DetailTagihan> createState() => _DetailTagihanState();
}

class _DetailTagihanState extends State<DetailTagihan> {
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
    initSDK();
    getData();
  }

  void initSDK() async {
    midtransSDK = await MidtransSDK.init(
        config: MidtransConfig(
      clientKey: dotenv.env['MIDTRANS_CLIENT_KEY']!,
      merchantBaseUrl: dotenv.env['MIDTRANS_BASE_URL']!,
    ));
    midtransSDK?.setUIKitCustomSetting(
      skipCustomerDetailsPages: true,
    );

    midtransSDK!.setTransactionFinishedCallback((result) {
      if (kDebugMode) {
        print('connect');
      }
    });
  }

  @override
  void dispose() {
    midtransSDK?.removeTransactionFinishedCallback();
    super.dispose();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    var data = await homeProvider.getDataHome();
    setState(() {
      user = User.fromJson(data['user']);
      zone = Zone.fromJson(data['zone']);
      latestMonthlyBill =
          LatestMonthlyBill.fromJson(data['latest_monthly_bill']);
      cek = latestMonthlyBill.snapToken.toString();

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Tagihan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        elevation: 0.00,
        backgroundColor: colorAPPBARrgb,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            buildIconInvoice(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Bulan : ${widget.dateInMonthYear}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          color: Colors.grey,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 100,
                              width: MediaQueryData.fromWindow(
                                      WidgetsBinding.instance.window)
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
                                  Text(
                                    widget.totalInRupiah,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: dataPembayaran(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget dataPembayaran() {
    return Column(
      children: [
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nomor Tagihan : '),
                Text(widget.number),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Volume Sampah : '),
                isLoading
                    ? loadingText()
                    : Text(
                        zone.volume.toString(),
                      ),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        zone.transportZone.toString(),
                      ),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        zone.transportationType.toString(),
                      ),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        user.address.toString(),
                      ),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading
                    ? loadingText()
                    : Text(
                        zone.rateInRupiah.toString(),
                      ),
              ],
            ),
          ),
        ),
        DottedBorder(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 150,
                    height: 50,
                    child: widget.snapToken.isNotEmpty
                        ? ElevatedButton(
                            onPressed: () {
                              midtransSDK?.startPaymentUiFlow(
                                token: widget.snapToken,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorAPPBARrgb,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Bayar Tagihan',
                              style: TextStyle(fontSize: 15),
                            ),
                          )
                        : const Text(
                            'Tagihan Lunas',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
