import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sipapparong_mobile/View/Tagihan/tagihan_detail.dart';

import '../../Model/model_tagihan.dart';
import '../../Provider/provider_tagihan.dart';

class NavTagihan extends StatefulWidget {
  NavTagihan({Key? key}) : super(key: key);

  @override
  State<NavTagihan> createState() => _NavTagihanState();
}

class _NavTagihanState extends State<NavTagihan> {
  TagihanProvider tagihanProvider = TagihanProvider();
  var isLoading = false;
  var cek = "";
  var datas = [];
  Datum data = Datum(
      id: 0,
      userId: 0,
      number: '',
      date: DateTime.now(),
      total: 0,
      snapToken: '',
      orderId: '',
      paidStatus: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      totalInRupiah: '',
      dateInMonthYear: '');

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    var data = await tagihanProvider.getListTagihan();
    // log(data["data"][0]["number"].toString());
    datas = data["data"];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Tagihan',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: RgbColor(63, 13, 18),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTagihan(
                              id: datas[index]["id"],
                              number: datas[index]["number"],
                              date: datas[index]["date"],
                              total: datas[index]["total"],
                              snapToken: datas[index]["snap_token"],
                              orderId: datas[index]["order_id"],
                              paidStatus: datas[index]["paid_status"],
                              totalInRupiah: datas[index]["total_in_rupiah"],
                              dateInMonthYear: datas[index]
                                  ["date_in_month_year"],
                            ),
                          ),
                        );

                        // log(index.toString());
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 8),
                                  child: Text(
                                      'Bulan : ${datas[index]["date_in_month_year"].toString()}',
                                      style: const TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            ListTile(
                              title: Text(
                                  datas[index]["total_in_rupiah"].toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                'No. Tagihan : ${datas[index]["number"].toString()}',
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: datas[index]["paid_status"] == "paid"
                                  ? Text(
                                      'Lunas'.toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    )
                                  : Text(
                                      'Tidak Lunas'.toString().toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: datas.length,
                ),
              ],
            ),
          ),
        ));
  }
}
