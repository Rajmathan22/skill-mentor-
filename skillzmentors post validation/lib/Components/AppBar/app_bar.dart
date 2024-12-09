
import 'package:flutter/material.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class AppBarBack extends StatefulWidget
    implements PreferredSizeWidget {
      final GlobalKey<ScaffoldState>? scaffoldKey;

  final bool showNotificationIcon;

  const AppBarBack({
    Key? key,
    this.scaffoldKey,
    this.showNotificationIcon = false,
  }) : super(key: key);

  @override
  State<AppBarBack> createState() => _AppBarBackState();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _AppBarBackState extends State<AppBarBack> {
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
                  Container(
                    height: 28,
                    width: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(JobsImage.app_bar),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  notification
                      ? Icons.notifications_outlined
                      : Icons.notifications_off_outlined,
                  color:
                      widget.showNotificationIcon ? Colors.black : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
