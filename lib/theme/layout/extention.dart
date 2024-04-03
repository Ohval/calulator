import 'package:flutter/material.dart';

extension OnPressed on Widget {
  Widget ripple(Function onPressed,
          {BorderRadiusGeometry borderRadius =
              const BorderRadius.all(Radius.circular(5))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: MaterialButton(
                animationDuration: const Duration(milliseconds: 50),
                splashColor: const Color.fromARGB(61, 255, 255, 255),
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                onPressed: () {
                  onPressed();
                },
                child: Container()),
          )
        ],
      );
}

extension ExAlignment on Widget {
  Widget get alignTopCenter => Align(
        alignment: Alignment.topCenter,
        child: this,
      );
  Widget get alignCenter => Align(
        alignment: Alignment.center,
        child: this,
      );
  Widget get alignBottomCenter => Align(
        alignment: Alignment.bottomCenter,
        child: this,
      );
  Widget get alignBottomLeft => Align(
        alignment: Alignment.bottomLeft,
        child: this,
      );
}

extension PaddingHelper on Widget {
  Padding get p16 => Padding(padding: const EdgeInsets.all(16), child: this);

  /// Set padding according to `value`
  Padding p(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Set horizontal padding according to `value`
  Padding hp(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);

  /// Set vertical padding according to `value`
  Padding vp(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  /// Horizontal Padding 16
  Padding get hP4 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: this);
  Padding get hP8 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: this);
  Padding get hP16 =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: this);

  /// Vertical Padding 16
  Padding get vP16 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: this);
  Padding get vP8 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
  Padding get vP4 =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: this);
}
