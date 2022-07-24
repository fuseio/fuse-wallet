import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';

import 'package:fusecash/features/shared/widgets/barcode_scanner.dart';
import 'package:fusecash/features/shared/widgets/silver_app_bar.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/tokens/token.dart';

class SearchPanel extends StatelessWidget {
  final Collectible? collectible;
  final Token? token;
  const SearchPanel({
    Key? key,
    required this.searchController,
    this.collectible,
    this.token,
  }) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 80.0,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
                    autofocus: false,
                    controller: searchController,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0.0),
                      fillColor: Theme.of(context).canvasColor,
                      suffixIcon: const Icon(
                        Icons.search,
                      ),
                      labelText: I10n.of(context).search,
                      labelStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: const Color(0xFFAAAAAA),
                              ),
                    ),
                  ),
                ),
              ),
              BarcodeScanner(
                token: token,
                collectible: collectible,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
