import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
    child: Text(
      title,
      style: GoogleFonts.quicksand(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
    ),
  );
}