import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/styles/styles.dart';

class AppProgressButton extends StatefulWidget {
  final String? text;
  final Widget? child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? progressIndicatorColor;
  final bool? isBordered;
  final Color? textColor;
  final double? fontSize;
  final double? radius;
  final double? elevation;
  final EdgeInsets? padding;
  final Function(AnimationController animationController) onPressed;
  final IconData? icon;

  const AppProgressButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.child,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.isBordered,
    this.height = 50,
    this.progressIndicatorColor,
    this.radius = 0,
    this.elevation,
    this.padding,
  });

  @override
  State<AppProgressButton> createState() => AppProgressButtonState();
}

class AppProgressButtonState extends State<AppProgressButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<BorderRadiusGeometry?> radiusAnimation;

  double buttonHeight = 35;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buttonHeight = widget.height ?? 35;

    final curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );

    sizeAnimation = Tween<double>(
      begin: widget.width ?? context.width,
      end: buttonHeight,
    ).animate(curvedAnimation);

    radiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(widget.radius ?? 8.0),
      end: BorderRadius.circular(50),
    ).animate(curvedAnimation);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        constraints: BoxConstraints(minWidth: buttonHeight),
        width: sizeAnimation.value,
        height: buttonHeight,
        child: MaterialButton(
          padding: widget.padding ??
              const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
          elevation: widget.elevation ?? 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: radiusAnimation.value!,
            side: !(widget.isBordered ?? false)
                ? BorderSide.none
                : BorderSide(
                    color: widget.textColor ?? Styles.secondaryColor,
                    width: 1,
                  ),
          ),
          color: widget.backgroundColor ?? Styles.secondaryColor,
          onPressed: () async {
            if (controller.isCompleted) return;
            widget.onPressed(controller);
          },
          child: controller.isCompleted
              ? OverflowBox(
                  maxWidth: buttonHeight,
                  maxHeight: buttonHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 1,
                      backgroundColor:
                          widget.progressIndicatorColor ?? Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.textColor ?? Colors.white,
                      ),
                    ),
                  ),
                )
              : FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon != null
                          ? Icon(
                              widget.icon,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                      widget.icon != null
                          ? SizedBox(height: 4)
                          : const SizedBox(),
                      widget.child ??
                          Text(
                            widget.text ?? 'Click Me',
                            style: TextStyle(
                              color: widget.textColor ?? Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
