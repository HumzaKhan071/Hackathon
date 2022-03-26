import 'package:e_cars_ui/Models/api.dart';
import 'package:e_cars_ui/const.dart';
import 'package:e_cars_ui/payment%20Gateway/payment.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class HybridCarsScreen extends StatefulWidget {
  const HybridCarsScreen({Key? key}) : super(key: key);

  @override
  _HybridCarsScreenState createState() => _HybridCarsScreenState();
}

class _HybridCarsScreenState extends State<HybridCarsScreen> {
  submitForm() async {
    ApiService _apiService = ApiService();
    var eachposts = await _apiService.fetchUsers();
    return eachposts;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: black,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: black,
            body: FutureBuilder<dynamic>(
                future: submitForm(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: size.height,
                            width: size.width,
                            child: Column(
                              children: [
                                header(size),
                                SizedBox(
                                  height: size.height / 30,
                                ),
                                Container(
                                  height: size.height / 3.5,
                                  width: size.width,
                                  decoration:  BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("${snapshot.data![index].body}"),
                                    ),
                                  ),
                                ),
                                RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                    text: "${snapshot.data![index].title}",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "\n2021",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Container(
                                    width: size.width / 1.1,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Specifications",
                                      style: TextStyle(
                                        color: blueGrey2,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                specifications(size),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: size.width / 1.1,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Price",
                                      style: TextStyle(
                                        color: blueGrey2,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                priceTag(size),
                                customButton(size),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                })),
      ),
    );
  }

  Widget customButton(Size size) {
    return SizedBox(
        height: size.height / 8,
        width: size.width / 1.2,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: size.height / 11,
                width: size.width / 1.1,
                color: blueGrey2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: size.width / 3.8,
                      child: const Text(
                        "Book a\nFree Ride",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width / 3.2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PaymentHomeScreen()));
                        },
                        child: const Text(
                          "Book\nNow",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 170,
              child: Transform.rotate(
                angle: 10,
                child: Container(
                  height: size.height / 8.5,
                  width: size.width / 50,
                  color: black,
                ),
              ),
            ),
          ],
        ));
  }

  Widget priceTag(Size size) {
    return SizedBox(
      height: size.height / 15,
      width: size.width / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Rs. 1000000",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: size.height / 18,
            width: size.width / 200,
            color: green,
          ),
          const Text(
            '''
            Tax: 57000
            RoadTax: 500
            Something: 15251
            ''',
            style: TextStyle(
              fontSize: 12,
              color: blueGrey2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget specifications(Size size) {
    return Container(
      height: size.height / 4.9,
      width: size.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.5, color: blueGrey2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          specificationItems(size, Icons.speed, "Cover Upto 250km/hr"),
          specificationItems(size, Icons.speed, "Cover Upto 250km/hr"),
          specificationItems(size, Icons.speed, "Cover Upto 250km/hr"),
        ],
      ),
    );
  }

  Widget specificationItems(Size size, IconData icon, String title) {
    return Container(
      height: size.height / 5.7,
      width: size.width / 3.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.5, color: green),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 50,
            color: blueGrey2,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: blueGrey2,
            ),
          ),
        ],
      ),
    );
  }

  Widget header(Size size) {
    return SizedBox(
      height: size.height / 18,
      width: size.width / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.arrow_back_ios,
            color: green,
          ),
          Icon(
            Icons.favorite_outline,
            color: green,
          )
        ],
      ),
    );
  }
}
