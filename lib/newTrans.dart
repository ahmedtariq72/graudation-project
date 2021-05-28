import 'dart:io';
//#Packages
import 'package:pro3/adaptiveFlatBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrx;

  //#Constructor..
  NewTransaction(this.addTrx);

  @override
  //#Creating State..
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime _selectedDate;
  //#State Constructor..
  //_NewTransactionState(){}

  /*@override
  void initState() {
    //#Init State
    //#Super>>refers to the parent class which is the Upper state..
    super.initState();
  }*/

  /*@override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    //#DidUpdate State
    //#Comparing new widget with old one..
    super.didUpdateWidget(oldWidget);
  }*/

  /*@override
  void dispose() {
    //#Dispose
    //#Remove State..
    super.dispose();
  }*/

  void _submitData() {
    if (_priceController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredPrice = double.parse(_priceController.text);

    if (enteredTitle.isEmpty || enteredPrice <= 0 || _selectedDate == null)
      return;

    widget.addTrx(
      enteredTitle,
      enteredPrice,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaQuery.viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(alignment: AlignmentDirectional.center,

                child: Text('details',
                  style: GoogleFonts.cairo(textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing:1,
                  )

                  ),





                  ),

                ),



              TextField(
                decoration: InputDecoration(
                  labelText: 'name',
                ),
                controller: _titleController,
                //onChanged: (val) => titleInput = val,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'reference number',
                ),
                controller: _priceController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
                //onChanged: (val) => priceInput = val,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // Same as Expanded Fn. used in the below text
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}'),
                  ),
                  AdaptiveFlatBtn('Choose Date', _presentDatePicker),
                ],
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                child: Text('Add bill'),
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}