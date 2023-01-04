library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';
import 'package:google_fonts/google_fonts.dart';

RgbColor colorAPPBARrgb = const RgbColor(63, 13, 18);
var colorButton = HsbColor.fromHex('#30475E');
var colorProfileBeranda = HsbColor.fromHex('#30475E');
Text textLunasDetail = Text(
  "Lunas",
  style: GoogleFonts.poppins(
    color: Colors.green,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
);
