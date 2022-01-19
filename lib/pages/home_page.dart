import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/HomeWidgets/catalog_header.dart';
import 'package:flutter_application_1/widgets/HomeWidgets/catalog_list.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodeData = jsonDecode(catalogJson);
    var productsData = decodeData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final dummyList = List.generate(20, (index) => CatalogModel.items[0]);
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      // Color(0xff080e2c),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
        backgroundColor: MyTheme.darkBluishColor,
        child: Icon(CupertinoIcons.cart),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand().py16(),
            ],
          ),
        ),
      ),
      // body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
      //         ? GridView.builder(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //               crossAxisCount: 2,
      //               mainAxisSpacing: 16,
      //               crossAxisSpacing: 16,
      //             ),
      //             itemCount: CatalogModel.items.length,
      //             itemBuilder: (context, index) {
      //               final item = CatalogModel.items[index];
      //               return Card(
      //                   clipBehavior: Clip.antiAlias,
      //                   shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(10)),
      //                   child: GridTile(
      //                     header: Container(
      //
      //   child: Text(
      //                         item.name,
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                       padding: const EdgeInsets.all(12.0),
      //                       decoration: BoxDecoration(color: Colors.deepPurple),
      //                     ),
      //                     child: Image.network(item.image),
      //                     footer: Container(
      //                       child: Text(
      //                         item.price.toString(),
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                       padding: const EdgeInsets.all(12.0),
      //                       decoration: BoxDecoration(color: Colors.black),
      //                     ),
      //                   ));
      //             },
      //           )
      //         // ? ListView.builder(
      //         //     itemCount: CatalogModel.items.length,
      //         //     itemBuilder: (context, index) {
      //         //       return ItemWidget(item: CatalogModel.items[index]);
      //         //     },
      //         //   )

      //         : Center(
      //             child: CircularProgressIndicator(),
      //           )),
      // drawer: MyDrawer(),
    );
  }
}
