import 'package:auto_route/auto_route.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/screens/backup/edit_backup.dart';
import 'package:esol/screens/home/router/home_router.gr.dart';
import 'package:esol/screens/home/widgets/drawer.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/widgets/header.dart';
import 'package:esol/widgets/my_app_bar.dart';
import 'package:esol/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esol/models/views/drawer.dart';

// Widget drawerHeader(DrawerViewModel viewModel) {
//   return DrawerHeader(
//     child: InkWell(
//       onTap: () {
//         ExtendedNavigator.root.pop();
//         ExtendedNavigator.named('homeRouter').push(HomeRoutes.profileScreen);
//       },
//       child: Padding(
//           padding: EdgeInsets.only(top: 10, bottom: 15, left: 10),
//           child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                     height: 70,
//                     width: 70,
//                     child: ![null, ''].contains(viewModel.avatarUrl)
//                         ? ClipRRect(
//                             borderRadius: BorderRadius.circular(50),
//                             child: Positioned.fill(
//                                 child: CachedNetworkImage(
//                               imageUrl: viewModel.avatarUrl,
//                               placeholder: (context, url) =>
//                                   CircularProgressIndicator(),
//                               errorWidget: (context, url, error) => Image.asset(
//                                   'assets/images/anom.png',
//                                   width: 40,
//                                   height: 40),
//                               imageBuilder: (context, imageProvider) => Image(
//                                 image: imageProvider,
//                                 fit: BoxFit.fill,
//                               ),
//                             )),
//                           )
//                         : CircleAvatar(
//                             backgroundImage:
//                                 new AssetImage('assets/images/anom.png'),
//                             radius: 30,
//                           )),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         (viewModel?.firstName() ?? ''),
//                         style: TextStyle(
//                             color: Colors.red,
//                             fontSize: 22,
//                             fontWeight: FontWeight.normal),
//                       ),
//                       viewModel.walletAddress != null
//                           ? Row(
//                               children: <Widget>[
//                                 Text(
//                                   formatAddress(viewModel.walletAddress),
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                               ],
//                             )
//                           : SizedBox.shrink()
//                     ],
//                   ),
//                 ),
//               ])),
//     ),
//     decoration: BoxDecoration(
//         color: Colors.grey,
//         border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
//   );
// }

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          print(viewModel.avatarUrl);
          return Scaffold(
            drawer: DrawerWidget(),
            appBar: MyAppBar(
              // Make it Responsive
              height: MediaQuery.of(context).size.height * 0.3,
              child: Header(
                avatarUrl: viewModel.avatarUrl,
                text: viewModel.firstName(),
                image: null,
                contactEmpty: false,
                textshow: false,
                imageshow: true,
              ),
            ),
            body: Column(
              children: [
                // Text(viewModel.avatarUrl),
                // Text(
                //   (viewModel?.firstName() ?? ''),
                // ),
                // drawerHeader(viewModel),
                InkWell(
                  onTap: () {
                    ExtendedNavigator.root.pop();
                    Navigator.pop(context);
                    ExtendedNavigator.named('homeRouter')
                        .push(HomeRoutes.profileScreen);
                  },
                  child: RectangleGo(
                    color: Colors.white,
                    label: 'Editar mis datos',
                  ),
                ),
                RectangleGo(
                  color: Color.fromRGBO(255, 190, 0, 1),
                  label: 'Face ID Habilitado',
                ),
                InkWell(
                  child: RectangleGo(
                    color: Color.fromRGBO(255, 190, 0, 1),
                    label: 'Habilitar Frases mneomónicas ',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainMneomic()),
                    );
                  },
                ),
                Expanded(child: SizedBox()),
                PrimaryButton(
                  colors: [Colors.white],
                  labalColor: Colors.black,
                  label: 'Cerrar Sesión',
                  color: Colors.white,
                  onPressed: () {
                    viewModel.logout();
                    ExtendedNavigator.root.replace(Routes.splashScreen);
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        });
  }
}

class RectangleGo extends StatelessWidget {
  final String label;
  final Color color;
  const RectangleGo({
    this.label,
    this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 30, right: 30.0, top: 20.0, bottom: 0),
      child: Container(
        // height: 70.0,
        width: 347.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5,
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text(
                              label,
                              style: TextStyle(fontSize: 16),
                              // textAlign: TextAlign.center,
                            ),
                            (label.contains('Habilitar Frases mneomónicas') ||
                                    label.contains('Face ID Habilitado'))
                                ? SvgPicture.asset(
                                    'assets/images/checkmark_circle.svg')
                                : Container(
                                    height: 46,
                                    width: 46,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.edit),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
