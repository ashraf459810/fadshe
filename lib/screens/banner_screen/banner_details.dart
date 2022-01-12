import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fad_shee/extensions/list_extensions.dart';
import 'package:fad_shee/models/data/product.dart';
import 'package:fad_shee/screens/banner_screen/provider.dart';
import 'package:fad_shee/widgets/products_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class BannerDetails extends StatefulWidget {
  final String url;
  BannerDetails({Key key, this.url}) : super(key: key);

  @override
  _BannerDetailsState createState() => _BannerDetailsState();
}

class _BannerDetailsState extends State<BannerDetails> {
  dynamic products = [];
  @override
  Future<void> initState() {
    log(widget.url);

    // bannerProvider.url = widget.url;
    // products = bannerProvider.productss;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BannerProvider>(
      create: (context) => BannerProvider()..getBannersList(widget.url),
      child: Scaffold(body: Builder(builder: (context) {
        return Container(
            height: 700,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Provider.of<BannerProvider>(context).productss.length,
              itemBuilder: (context, index) => ProductsListItem(
                  Provider.of<BannerProvider>(context).productss[index],
                  Provider.of<BannerProvider>(context)
                      .productss
                      .getItemLocation(index)),
            ));
      })),
    );
  }
}
