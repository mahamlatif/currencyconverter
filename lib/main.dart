import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue1 = 'PKR';
  String dropdownValue2 = 'USD';
  String rate = '';
  final myController = TextEditingController();
  String amount = '';
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Currency Converter',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 330,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          cursorColor: Colors.blueGrey.shade300,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: myController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(left: 20),
                          height: 50,
                          width: 90,
                          child: DropdownButton(
                              focusColor: Colors.blueGrey,
                              itemHeight: 70,
                              value: dropdownValue1,
                              underline: SizedBox(),
                              style: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              items: <String>[
                                'PKR',
                                'USD',
                                'AED',
                                'ALL',
                                'CNY',
                                'EUR',
                                'GBP'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue1 = newValue!;
                                });
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              amount = myController.text;
                            });
                            fetchcurrency();
                            print(rate);
                          },
                          child: Icon(
                            Icons.swap_horizontal_circle,
                            color: Colors.blueGrey.shade700,
                            size: 40,
                          ),
                          style: ButtonStyle(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.only(left: 20),
                          height: 50,
                          width: 90,
                          child: DropdownButton(
                            focusColor: Colors.blueGrey,
                            iconDisabledColor: Colors.blueGrey,
                            itemHeight: 70,
                            value: dropdownValue2,
                            underline: SizedBox(),
                            style: TextStyle(
                              color: Colors.blueGrey.shade600,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            items: <String>[
                              'PKR',
                              'USD',
                              'AED',
                              'ALL',
                              'CNY',
                              'EUR',
                              'GBP'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue2 = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 50, 0, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Amount  :  ",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            rate,
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  fetchcurrency() async {
    const key = 'xxxxxxxxxxxxxxxxxxxxx';
    String list = 'https://api.apilayer.com/currency_data/list?apikey=$key';
    // String uri =
    //     'https://api.apilayer.com/fixer/latest?base=$dropdownValue1&symbols=$dropdownValue2&amount=100&apikey=lBIoZCkkxNXVEAn0AYqShCo27NQRM4QV';
    String uri =
        'https://api.apilayer.com/currency_data/convert?to=$dropdownValue2&from=$dropdownValue1&amount=$amount&apikey=$key';
    var url = Uri.parse(uri);
    http.Response response = await http.get(url);
    var responseBody = response.body;
    var parsedResponse = json.decode(responseBody);
    print(parsedResponse);
    print(parsedResponse['result']);
    setState(() {
      rate = parsedResponse['result'].toString();
    });
  }
}
//https://api.apilayer.com/currency_data/list?apikey=lBIoZCkkxNXVEAn0AYqShCo27NQRM4QVu
//https://api.apilayer.com/currency_data/convert?to=$dropdownValue2&from=$dropdownValue1&amount=$amount&apikey=lBIoZCkkxNXVEAn0AYqShCo27NQRM4QVu