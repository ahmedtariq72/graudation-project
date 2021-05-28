import 'dart:io';
//#Packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'transfer.dart';
//Services is for SystemChrome property.

//#Widgets
import 'package:pro3/newTrans.dart';
import 'package:pro3/transactionList.dart';

import 'package:google_fonts/google_fonts.dart';
//#Models
import 'package:pro3/models.dart';

void main() {
  //No LandScape Mode.
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(MyApp() );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bills',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white),
          ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //String titleInput;
  //String priceInput;
  //final titleController = TextEditingController();
  //[final priceController = TextEditingController();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    /*Transaction(
      id: 'a1',
      title: 'New Clothes',
      price: 14.45,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'a2',
      title: 'Groceries',
      price: 3.45,
      date: DateTime.now(),
    ),*/
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTrx(String trxTitle, double trxPrice, DateTime selectedDate) {
    final newTrx = Transaction(
      title: trxTitle,
      price: trxPrice,
      date: selectedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTrx);
    });
  }

  void _startAddNewTrx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTrx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTrx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery,
      AppBar appBar,
      Widget txListWidget,
      ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      //_showChart ?
           //Container(
        //height: (mediaQuery.size.height -
           // appBar.preferredSize.height -
           // mediaQuery.padding.top) *
          //  0.7,
        //child: //Chart(_recentTransactions),
      //):
           txListWidget //),
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery,
      AppBar appBar,
      Widget txListWidget,
      ) {
    return [
      /*Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),*/
      txListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    //to get info about app bar we saved it in seperated value from its default
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
      middle: Text(
        'bills',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTrx(context),
          ),
        ],
      ),
    )
        : AppBar(
      title: Text('bills',textAlign:TextAlign.center,
        style: GoogleFonts.cairo(textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          letterSpacing:1,
        )

        ),)

    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
          appBar.preferredSize.height -
          mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTrx),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandScape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    )
        : Scaffold(
      appBar: appBar,
      body: pageBody,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _startAddNewTrx(context),
      ),
    );
  }
}