import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:skillzmentors/config/Images/jobes_image.dart';

class AppBarWithBackButton extends StatefulWidget
    implements PreferredSizeWidget {
  final bool showNotificationIcon;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool hideNotifcationIcon;

  const AppBarWithBackButton({
    Key? key,
    this.scaffoldKey,
    this.showNotificationIcon = false,
    this.hideNotifcationIcon = false,
  }) : super(key: key);

  @override
  State<AppBarWithBackButton> createState() => _AppBarWithBackButton();

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}

class _AppBarWithBackButton extends State<AppBarWithBackButton> {
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
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: HugeIcon(
                      icon: Icons.arrow_back_ios,
                      color: const Color.fromARGB(255, 2, 2, 2),
                      size: 24,
                    ),
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
                child: widget.hideNotifcationIcon
                    ? const SizedBox.shrink() // Hides the icon
                    : Icon(
                        Icons.notifications,
                        color: widget.showNotificationIcon
                            ? Colors.black
                            : Colors.red,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
