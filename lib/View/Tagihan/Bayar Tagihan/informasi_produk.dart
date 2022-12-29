import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';
import '../nav_tagihan.dart';

class InformasiProduk extends StatefulWidget {
  InformasiProduk({Key? key}) : super(key: key);

  @override
  State<InformasiProduk> createState() => _InformasiProdukState();
}

class _InformasiProdukState extends State<InformasiProduk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informasi Produk",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        elevation: 0.00,
        backgroundColor: colorAPP_BARrgb,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => NavTagihan()));
          },
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30.0),
                  buildNamaProduk(),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Nama Produk',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60,
                            child: Container(
                              width: 10,
                              height: 10,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        color: Colors.green,
                      )
                    ],
                  ),

                  // const SizedBox(height: 30.0),
                  // buildButtonLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNamaProduk() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama Produk',
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
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60,
          child: const TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Masukkan Nama Produk',
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHargaKuantitas() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nama Produk',
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
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60,
          child: const TextField(
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              hintText: 'Masukkan Nama Produk',
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
