//#Packages
import 'package:flutter/material.dart';
//#Models
import 'package:pro3/models.dart';
//#Widgets
import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'No bill added yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.04,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (context, index) {
        return TransactionItem(
          transaction: transactions[index],
          handlerFn: deleteTx,
        );
      },
      itemCount: transactions.length,
    );
  }
}

//The replaced list with listTile
/*return Card(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).accentColor,
                              width: 3,
                            ),
                          ),
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              '\$ ${transactions[index].price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              DateFormat.MMMMEEEEd()
                                  .add_jm()
                                  .format(transactions[index].date),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );*/
