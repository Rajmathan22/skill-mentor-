import 'package:flutter/material.dart';

class AppBarForDetails extends StatefulWidget implements PreferredSizeWidget {
  final bool showNotificationIcon;
  final String companyname;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AppBarForDetails({
    Key? key,
    this.showNotificationIcon = false,
    required this.companyname,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  State<AppBarForDetails> createState() => _AppBarForDetailsState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _AppBarForDetailsState extends State<AppBarForDetails> {
  final bool notification = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
      
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 22),
                  SizedBox(
                    height: 28,
                    width: 180,
                    child: Text(widget.companyname , style: const TextStyle(
                      fontSize: 24 , 
                      fontFamily: 'TimesNewRoman'
                    ),),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
