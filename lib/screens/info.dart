import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lodt_hack/screens/create_consultation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles/ColorResources.dart';
import 'consultation.dart';

class Info extends StatefulWidget {
  const Info({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.externalLink,
  });

  final String title;
  final String subtitle;
  final String description;
  final String externalLink;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      body: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(
                widget.title,
                style: GoogleFonts.ptSerif(fontWeight: FontWeight.w100),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: CupertinoButton(
                          color: ColorResources.accentRed,
                          onPressed: () {
                            launchUrl(Uri.parse(widget.externalLink));
                          },
                          child: const Text(
                            "Перейти на сайт",
                            style: TextStyle(
                              color: ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
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
}
