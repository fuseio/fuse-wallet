import 'package:flutter/material.dart';
import 'package:fusecash/services.dart';

class PriceDiff extends StatefulWidget {
  final String tokenAddress;
  const PriceDiff({
    Key key,
    this.tokenAddress,
  }) : super(key: key);

  @override
  _PriceDiffState createState() => _PriceDiffState();
}

class _PriceDiffState extends State<PriceDiff> {
  String limit = '1';

  Widget _limitButton(String value, String l) {
    return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        setState(() {
          limit = limit;
        });
      },
      child: Container(
        color: limit == l
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.secondary,
        alignment: Alignment.center,
        width: 47,
        height: 26,
        child: Text(
          value,
          style: TextStyle(
            fontSize: 30,
            color: limit == l
                ? Theme.of(context).canvasColor
                : Theme.of(context).colorScheme.onSurface,
            // fontWeight: FontWeight.bold,
            // color: ,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FutureBuilder<num>(
              future: fuseSwapService.priceChange(widget.tokenAddress),
              builder: (context, AsyncSnapshot<num> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Select lot');
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                    return Text('\$${snapshot.data}');
                  case ConnectionState.done:
                    return Text(snapshot.data.toStringAsFixed(2));
                }
                return null; // unreachable
                // if (dataSnapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // } else {
                //   if (dataSnapshot.error != null) {
                //     return Center(
                //       child: Text('An error occured'),
                //     );
                //   } else {
                //     return Container();
                //   }
                // }
              },
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _limitButton('24H', '1'),
                _limitButton('1W', '7'),
                _limitButton('1M', '30'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
