import 'package:coffe_app_ui/models/icon_models.dart';
import 'package:coffe_app_ui/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currenIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List menu = Models.menuItems;

    return Scaffold(
      body: menu[currenIndex]['destination'] as Widget,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.black, const Color.fromARGB(139, 0, 0, 0)],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
        ),

        // padding: EdgeInsets.symmetric(
        //   horizontal: MediaQuery.sizeOf(context).width * 0.02,
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(menu.length, (index) {
            bool isActive = currenIndex == index;
            return Expanded(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      currenIndex = index;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 7),
                      Icon(
                        menu[index]['icon'],
                        size: 30,
                        color:
                            isActive
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.primary,
                      ),

                      if (isActive)
                        Icon(
                          Icons.minimize,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.white,
                              offset: Offset(3, 5),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
