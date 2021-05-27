import 'package:flutter/material.dart';
import 'package:medik/model/product.dart';

import 'detaildata._screen.dart';

class TransList extends StatelessWidget {
  final List<ProductModel> trans;
  TransList({Key key, this.trans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        itemCount: trans == null ? 0 : trans.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailWidget(trans[index])),
                    );
                  },
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(trans[index].code.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text(trans[index].name),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Price :'),
                            Text(trans[index].price.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Stock :'),
                            Text(trans[index].stock.toString()),
                          ],
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.done, color: Colors.green,),
                  ),
                )
            );
        });
  }
}
