import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test_app/data/models/user.dart';
import 'package:flutter_test_app/redux/item_details/item_details_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_test_app/redux/base/app_state.dart';
import 'package:flutter_test_app/ui/item_details/item_details_vm.dart';

class ItemDetailsArgs {
  final User user;
  final int index;

  ItemDetailsArgs(this.user, this.index);
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
    if (vm.result == '') return;
    vm.resetState();
    vm.users[widget.args.index].firstName = _itemController.text;
    _goBack();
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
        content: Text(
          message,
          style: TextStyle(
            fontSize: 10,
            color: Color(0xff5eab9f),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF2a3035),
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
          return vm.loading ? LoaderWidget() : _buildBody(vm);
        },
      ),
    );
  }

  Widget _buildBody(ItemDetailsViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitle(),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return _buildListView(
                vm,
                context,
                index,
              );
            },
          ),
        ),
        _buildButtonSave(vm),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          "Item Details Page",
          style: TextStyle(
            fontSize: 40,
            color: Color(0xff5eab9f),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildListView(
    ItemDetailsViewModel vm,
    BuildContext context,
    index,
  ) {
    return new Padding(
        padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
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
                    widget.args.user.firstName +
                        "   " +
                        widget.args.user.lastName +
                        "   " +
                        widget.args.user.age.toString(),
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
                  decoration: InputDecoration(
                    labelText: 'Change first name',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xff7acfc2),
                    ),
                  ),
                  cursorColor: Color(0xff979797),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(5),
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

  Widget _buildButtonSave(ItemDetailsViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
      child: SizedBox(
        height: 44,
        child: RaisedButton(
          color: Color(0xffe1594b),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(22.0),
              side: BorderSide(color: Colors.white)),
          child: Text(
            'Save',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            vm.updateItem(widget.args.user.id, _itemController.text);
          },
        ),
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
