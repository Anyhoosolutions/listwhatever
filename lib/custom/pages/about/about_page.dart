import 'package:flutter/material.dart'; // hide Page;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).aboutHeader)),
        body: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
            children: [
              Text(AppLocalizations.of(context).versionLabel('<version>')),
              Text(AppLocalizations.of(context).gitHashLabel('<git_hash>')),
              Text(AppLocalizations.of(context).aboutDateLabel('<datetime>')),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
