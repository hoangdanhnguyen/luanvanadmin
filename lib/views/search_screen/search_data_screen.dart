import 'package:admin_luanvan/const/const.dart';
import 'package:admin_luanvan/views/products_screen/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class searchData extends StatefulWidget {
  const searchData({super.key});

  @override
  State<searchData> createState() => _searchDataState();
}

class _searchDataState extends State<searchData> {

  List _allResults = [];

  List _resultlist = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getClientStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged(){
    print(_searchController.text);
    searchResultList();
  }

  searchResultList(){
    var showReasults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResults) {
        var name = clientSnapShot['p_name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showReasults.add(clientSnapShot);
        }
      }
    } else {
      showReasults = List.from(_allResults);
    }

    setState(() {
      _resultlist = showReasults;
    });
  }


  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection(productsCollection).orderBy('p_name').get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black)
        ),
          backgroundColor: Colors.white,
          title: CupertinoSearchTextField(
            controller: _searchController,
          ),
        ),
        body: ListView.builder(
          itemCount: _resultlist.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_resultlist[index]['p_name']),
              onTap: () {
                    Get.to(() => ProductDetails(data: _resultlist[index]));
                  },
              leading: Image.network(_resultlist[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
              subtitle: Text(_resultlist[index]['p_price']),
            );
          },
        ),
      ),
    );
  }
}