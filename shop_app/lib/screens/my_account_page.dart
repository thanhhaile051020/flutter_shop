import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/HttpException.dart';

import 'package:shop_app/provider/userProvider.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = '/my-account';

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  var isLoading = false;
  GlobalKey<FormState> _key = GlobalKey();
  var changed = false;

  @override
  void initState() {
    var provider = Provider.of<User>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    provider.getMyDetail().then((value) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  _showError(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('An Error Occured!'),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  submit(Map<String, String> info) async {
    if (!_key.currentState!.validate()) {
      return;
    }
    _key.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<User>(context, listen: false).updateUser(info);
    } on HttpException catch (error) {
      _showError(error.msg);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var details = Provider.of<User>(context).currUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.black,
              ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 960),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          // enabled: false,
                          readOnly: true,
                          initialValue: details['email'],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: "Email"),
                          style: TextStyle(color: Colors.grey),
                          onFieldSubmitted: (value) => details['email'] = value,
                          onSaved: (value) =>
                              details['email'] = value.toString(),
                          enableInteractiveSelection: false,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: details['firstname'],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: 'First Name'),
                          onFieldSubmitted: (value) =>
                              details['firstname'] = value,
                          onSaved: (value) =>
                              details['firstname'] = value.toString(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cannot be empty';
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: details['lastname'],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(Icons.person_outline),
                              labelText: 'Last Name'),
                          onFieldSubmitted: (value) =>
                              details['lastname'] = value,
                          onSaved: (value) =>
                              details['lastname'] = value.toString(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field cannot be empty";
                            }
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: details['address'],
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              prefixIcon: Icon(Icons.home_outlined),
                              labelText: 'Primary Address'),
                          onFieldSubmitted: (value) =>
                              details['address'] = value,
                          onSaved: (value) =>
                              details['address'] = value.toString(),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: details['phone'],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Mobile no.',
                          ),
                          onFieldSubmitted: (value) => details['phone'] = value,
                          onSaved: (value) =>
                              details['phone'] = value.toString(),
                          validator: (value) {
                            if (value!.length < 10) {
                              return "Please enter a valid mobile number!";
                            }
                            if (value.contains(
                                RegExp(r'[A-Z]', caseSensitive: false))) {
                              return "Please enter a valid mobile number!";
                            }
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 30),
                          child: Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: DefaultButton(
                                press: () {
                                  submit(details);
                                },
                                text: "Submit",
                              )),
                        )
                      ],
                    ),
                  ),
                  key: _key,
                ),
              ),
            ),
    );
  }
}
