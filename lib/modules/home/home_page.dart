import 'package:flutter/material.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          color: AppColors.primary,
          height: 152,
          child: Center(
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: AppTextStyles.titleRegular,
                    children: [
                      TextSpan(
                          text: "${widget.user.name}",
                          style: AppTextStyles.titleBoldBackground)
                    ]),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: AppTextStyles.captionShape,
              ),
              trailing: GestureDetector(
                // TODO Fix logoutButton
                onTap: () => PopupMenuButton(
                    onSelected: (value) {
                      loginController.googleSignOut(context);
                      Navigator.pushNamed(context, "/login");
                    },
                    itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: null,
                            child: Text("Sair"),
                          ),
                        ]),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.photoURL!))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: [
        MeusBoletosPage(
          key: UniqueKey(),
        ),
        ExtractPage(
          key: UniqueKey(),
        )
      ][homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  homeController.setPage(0);
                  setState(() {});
                },
                icon: Icon(
                  Icons.home,
                  color: homeController.currentPage == 0
                      ? AppColors.primary
                      : AppColors.body,
                )),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, "/barcode_scanner");
                setState(() {});
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Icon(
                  Icons.add_box_outlined,
                  color: AppColors.background,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.setPage(1);
                setState(() {});
              },
              icon: Icon(
                Icons.description_outlined,
                color: homeController.currentPage == 1
                    ? AppColors.primary
                    : AppColors.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
