import 'dart:math';
//#Packages
import 'package:flutter/material.dart';

//#Models
import 'package:pro3/models.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.handlerFn,
  }) : super(key: key);

  final Transaction transaction;
  final Function handlerFn;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.purple,
      Colors.green,
      Colors.yellow,
      Colors.red,
    ];
   /* void icons() {
      const availableicons = [
        Icon(Icons.wb_incandescent_outlined),
        Icon(Icons.waterfall_chart),
        Icon(Icons.mobile_friendly),
        Icon(Icons.local_gas_station),
      ];*/


    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child:Icon(Icons.waterfall_chart),//FittedBox(child: Text('\$${widget.transaction.price}')),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(widget.transaction.date),
        ),
        trailing: mediaQuery.size.width > 400
            ? FlatButton.icon(
          onPressed: () => widget.handlerFn(widget.transaction.id),
          icon: Icon(Icons.delete),
          textColor: Theme.of(context).errorColor,
          label: Text('Delete'),
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.handlerFn(widget.transaction.id),
        ),
      ),
    );
  }
}
