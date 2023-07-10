import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/products_screen/product_details.dart';
import 'package:admin_luanvan/views/widget/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchFirebase extends StatefulWidget {
  const SearchFirebase({Key? key}) : super(key: key);

  @override
  State<SearchFirebase> createState() => _SearchFirebaseState();
}

class _SearchFirebaseState extends State<SearchFirebase> {

  List searchResult = [];
  void searchFromFirebase(String query) async{
    final result = await FirebaseFirestore.instance
    .collection(productsCollection)
    .where('p_name', isLessThan: query)
    .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
        title: boldText(text: "Search", color: fontGrey, size: 16.0, ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search here"
              ),
              onChanged: (query){
                searchFromFirebase(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(searchResult[index]["p_name"]),
                  onTap: () {
                    Get.to(() => ProductDetails(data: searchResult[index]));
                  },
                  leading: Image.network(searchResult[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
                  subtitle: Text(searchResult[index]['p_price']),
                );
              })
          ),
        ],
      ),
    );
  }
}