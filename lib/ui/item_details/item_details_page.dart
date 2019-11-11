import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/common/consts/keys.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/ui/item_details/item_details_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  //                  document.reference.updateData({
//                    'names': _items[index],
//                  });
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onInit(Store<AppState> store) {}

  _onDispose(Store<AppState> store) {}

  _onWillChange(ItemDetailsViewModel vm) {}

  _onDidChange(ItemDetailsViewModel vm) {}

  _goBack() {
    Navigator.of(context).pop();
  }

  Widget _buildListView(
      BuildContext context, DocumentSnapshot document, index) {
    return new Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 60,
              width: (MediaQuery.of(context).size.width - 116) / 2 - 5,
              color: Color(0xFF31373c),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    document['names'],
                    style: TextStyle(
                      color: Color(0xFFfffff8),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                child: Container(
                  height: 60,
                  width: (MediaQuery.of(context).size.width - 116) / 2 - 5,
                  color: Color(0xFF31373c),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        document['names'],
                        style: TextStyle(
                          color: Color(0xFFfffff8),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.item_details,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/ic_trash_white.svg',
                  width: 44.0,
                  height: 44.0,
                ),
                onPressed: () {
//                  document.reference.delete();
                },
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
              return Padding(
                padding: const EdgeInsets.only(top: 0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(24, 20, 24, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    return ListView.builder(
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount:
                                        snapshot.data.documents.length,
                                        itemBuilder: (context, index) =>
                                            _buildListView(
                                                context,
                                                snapshot.data.documents[index],
                                                index));
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
        ),
      ],
    );
  }
}
