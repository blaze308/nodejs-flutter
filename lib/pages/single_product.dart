import 'package:flutter/material.dart';
import '../widgets/large_text.dart';
import '../widgets/medium_text.dart';
import '../widgets/price_text.dart';
import '../widgets/app_bar.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({required this.snapshot, required this.index, super.key});
  final AsyncSnapshot snapshot;
  final int index;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      // appBar: AppBar(),
      // drawer: const NavDrawer(),
      body: ListView(
        children: [
          SizedBox(
              width: double.maxFinite,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.snapshot.data[widget.index]["image"],
                      fit: BoxFit.cover,
                    )),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: LargeText(
                text: widget.snapshot.data[widget.index]["title"],
                maxLines: 3,
                textStyle:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: PriceText(
                  text: "GHC ${widget.snapshot.data[widget.index]["price"]}"
                      .toString(),
                  textStyle: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF869013)),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_circle,
                            color: Colors.redAccent, size: 25)),
                    const Badge(
                      child: Icon(Icons.shopping_cart, color: Colors.blueGrey),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle,
                            color: Colors.greenAccent, size: 25)),
                  ]),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF57FD5E),
                      fixedSize: const Size(100, 20),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 12),
                    )),
              ),
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: MediumText(
                  text: widget.snapshot.data[widget.index]["description"],
                  maxLines: 7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: LargeText(text: "Similar and Related Products "),
          ),
          // FutureBuilder(
          //   future: PostGres.getCategory(
          //       widget.snapshot.data[widget.index]["category"]),
          //   builder: (context, AsyncSnapshot snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       );
          //     } else if (snapshot.hasData) {
          //       return SingleChildScrollView(
          //         child: Padding(
          //           padding: const EdgeInsets.all(10),
          //           child: GridView.builder(
          //             physics: const NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             gridDelegate:
          //                 const SliverGridDelegateWithMaxCrossAxisExtent(
          //               maxCrossAxisExtent: 200,
          //               crossAxisSpacing: 10,
          //               childAspectRatio: 2 / 2.8,
          //               mainAxisSpacing: 15,
          //             ),
          //             itemCount: snapshot.data.length,
          //             itemBuilder: (context, index) {
          //               return GestureDetector(
          //                 onTap: () {
          //                   Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) => SingleProduct(
          //                         snapshot: snapshot, index: index),
          //                   ));
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       borderRadius: BorderRadius.circular(5),
          //                       boxShadow: const [
          //                         BoxShadow(color: Colors.grey, blurRadius: 2)
          //                       ]),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.only(left: 10),
          //                         child: Align(
          //                             alignment: Alignment.centerLeft,
          //                             child: MediumText(
          //                                 text: snapshot.data[index]["title"])),
          //                       ),
          //                       SizedBox(
          //                         height: 150,
          //                         width: double.maxFinite,
          //                         child: Image.network(
          //                           snapshot.data[index]["image"],
          //                           fit: BoxFit.cover,
          //                         ),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.only(right: 10),
          //                         child: Align(
          //                           alignment: Alignment.centerRight,
          //                           child: PriceText(
          //                               text:
          //                                   "GHC ${snapshot.data[index]["price"]}"
          //                                       .toString()),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     } else {
          //       return const Center(
          //         child: Text("error😣: Data Not Found"),
          //       );
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
