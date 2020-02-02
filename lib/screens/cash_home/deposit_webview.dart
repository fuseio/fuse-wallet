import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/plugins.dart';
import 'package:paywise/widgets/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DepositWebView extends StatefulWidget {
  final DepositPlugin depositPlugin;

  @override
  _DepositWebViewState createState() => _DepositWebViewState();

  DepositWebView({Key key, this.depositPlugin}) : super(key: key);
}

class _DepositWebViewState extends State<DepositWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController _myController;

  TextEditingController address = new TextEditingController();

  @override
  void initState() {
    address.value =
        address.value.copyWith(text: widget.depositPlugin.widgetUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DrawerViewModel>(
    converter: DrawerViewModel.fromStore,
    builder: (_, viewModel) {
      return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: new Container(
            height: 35,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: const Color(0xFFfe9e9e9),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        child: Image.asset(
                          'images/lock.png',
                          width: 16,
                          height: 16,
                        ),
                        padding: EdgeInsets.only(top: 1, left: 12),
                      ),
                      TextField(
                        controller: address,
                        textAlign: TextAlign.left,
                        decoration: new InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 0, left: 35, right: 10),
                            hintText: 'Address',
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none),
                        onSubmitted: (url) {
                          _myController.loadUrl(url);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
          actions: <Widget>[
            NavigationControls(_controller.future),
          ],
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Builder(builder: (BuildContext context) {
          dynamic depositPlugin = widget.depositPlugin;
          dynamic url =
              depositPlugin.generateUrl(walletAddress: viewModel.walletAddress);
          return WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
                _myController = webViewController;
              });
        }),
      );
    });
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
                        );
                        return;
                      }
                    },
            ),
            /*IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                      controller.reload();
                    },
            ),*/
          ],
        );
      },
    );
  }
}
