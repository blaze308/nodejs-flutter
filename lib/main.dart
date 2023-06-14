import 'package:flutter/material.dart';
import 'package:second/backend/mongodb.dart';
import 'package:second/backend/product_model.dart';
import 'package:second/widgets/large_text.dart';

import 'pages/add_product.dart';
import 'pages/single_product.dart';
import 'widgets/medium_text.dart';
import 'widgets/price_text.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    theme: ThemeData(fontFamily: "Inter"),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: LargeText(text: "Awesome Products to use in Eternity")),
          ),
          FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 2.8,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SingleProduct(
                                        snapshot: snapshot, index: index))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(color: Colors.grey, blurRadius: 2)
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: MediumText(
                                            text: Product.fromJson(
                                                    snapshot.data[index])
                                                .price
                                                .toString())),
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: double.maxFinite,
                                    child: Image.network(
                                      Product.fromJson(snapshot.data[index])
                                          .image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: PriceText(
                                          text:
                                              "GHC ${Product.fromJson(snapshot.data[index]).price.toString()}"
                                                  .toString()),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                );
              } else {
                return Center(child: MediumText(text: "Data not Found"));
              }
            },
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 55,
        height: 55,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: const Color(0xFF9DA53F),
              child: const Text(
                "Add Products",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProduct()));
              }),
        ),
      ),
    );
  }
}
