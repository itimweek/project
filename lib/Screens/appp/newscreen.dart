import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Newpage extends StatefulWidget {
  @override
  State<Newpage> createState() => _NewpageState();
}

class _NewpageState extends State<Newpage> {
  List<dynamic> _productsData = []; // ตัวแปรเก็บข้อมูลสินค้า

  @override
  void initState() {
    super.initState();
    _fetchProductsData(); // เรียกเมทอดเพื่อดึงข้อมูลสินค้า
  }

  // เมทอดสำหรับดึงข้อมูล API สินค้า
  Future<void> _fetchProductsData() async {
    try {
      var dio = Dio();
      var response = await dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        setState(() {
          _productsData = response.data; // เก็บข้อมูลสินค้าที่ได้ลงในตัวแปร _productsData
        });
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SHOP'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // จำนวนคอลัมน์ใน GridView
          crossAxisSpacing: 3, // ระยะห่างระหว่างคอลัมน์
          mainAxisSpacing: 5, // ระยะห่างระหว่างแถว
        ),
        itemCount: _productsData.length, // จำนวนรายการของข้อมูลสินค้า
        itemBuilder: (context, index) {
          var product = _productsData[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  product['image'], // URL รูปภาพของสินค้า
                  fit: BoxFit.cover, // ปรับขนาดรูปภาพให้เต็มพื้นที่ที่กำหนด
                  height: 120, // ความสูงของรูปภาพ
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['title'], // ชื่อสินค้า
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${product['price']}', // ราคาสินค้า
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
