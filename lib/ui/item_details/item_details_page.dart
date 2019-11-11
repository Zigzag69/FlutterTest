import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/ui/item_details/item_details_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsArgs {
  final DocumentSnapshot document;

  ItemDetailsArgs(this.document);
}

class ItemDetailsPage extends StatefulWidget {
  final ItemDetailsArgs args;
  ItemDetailsPage(this.args);
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  TextEditingController _itemController;
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _itemController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _itemController.dispose();
  }

  _onInit(Store<AppState> store) {
    if (store.state.itemDetailsState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onDispose(Store<AppState> store) {
    if (store.state.itemDetailsState.isDefault()) return;
    store.dispatch(ResetState());
  }

  _onWillChange(ItemDetailsViewModel vm) {
    if (vm.isDefault) return;
    vm.resetState();
    print("test docent");
  }

  _onDidChange(ItemDetailsViewModel vm) {
    if (vm.isDefault) return;
    if (vm.error == '') return;
    vm.resetState();
    String message;
    if (vm.error is PlatformException) {
      PlatformException pe = vm.error;
      message = pe.message;
    } else {
      message = vm.error.toString();
    }
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

  _goBack() {
    Navigator.of(context).pop();
  }

  Widget _buildListView(ItemDetailsViewModel vm, BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 60,
              width: (MediaQuery.of(context).size.width) / 2 - 30,
              color: Color(0xFF31373c),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    widget.args.document['names'],
                    style: TextStyle(
                      color: Color(0xFFfffff8),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width) / 2 - 30,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  cursorColor: Color(0xff979797),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  autocorrect: false,
                  controller: _itemController,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFfffff8),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Color(0xFF2a3035),
            child: Align(
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: _goBack,
            ),
          ),
          body: StoreConnector(
            distinct: true,
            converter: ItemDetailsViewModel.fromStore,
            onInit: _onInit,
            onDispose: _onDispose,
            onWillChange: _onWillChange,
            onDidChange: _onDidChange,
            builder: (BuildContext context, ItemDetailsViewModel vm) {
              return vm.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        "Item Details Page",
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Color(0xff5eab9f),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('testItems')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData)
                                            return const Center(
                                              child: Text(
                                                "Loading...",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFFfffff8),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: 1,
                                              itemBuilder: (context, index) =>
                                                  _buildListView(vm, context));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
          bottomNavigationBar: Container(
            height: 56,
            color: Color(0xFF2a3035),
            child: Padding(
              padding: const EdgeInsets.only(right: 19, bottom: 6),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
//                    ItemDetailsViewModel()
//                        .updateItem(widget.args.document, _itemController.text);
                    widget.args.document.reference.updateData({'names': _itemController.text});
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
