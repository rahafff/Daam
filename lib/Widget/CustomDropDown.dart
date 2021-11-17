import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration _kMenuDuration = Duration(milliseconds: 300);
const double _kBaselineOffsetFromBottom = 20.0;
const double _kMenuCloseIntervalEnd = 2.0 / 3.0;
const double _kMenuHorizontalPadding = 16.0;
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kMenuVerticalPadding = 8.0;
const double _kMenuWidthStep = 56.0;
const double _kMenuScreenPadding = 8.0;
double _kMenuScreenWidth = 35.0;
double _kMenuScreenHeight = 0.0;

abstract class PopupMenuEntry<T> extends StatefulWidget {
  const PopupMenuEntry({Key key}) : super(key: key);

  double get height;

  bool represents(T value);
}

class CustomDropDownItem<T> extends PopupMenuEntry<T> {
  const CustomDropDownItem({
    Key key,
    this.value,
    this.enabled = true,
    this.height = _kMenuItemHeight,
    this.textStyle,
    @required this.child,
  })  : assert(enabled != null),
        assert(height != null),
        super(key: key);

  final T value;

  final bool enabled;

  @override
  final double height;

  final TextStyle textStyle;

  final Widget child;

  @override
  bool represents(T value) => value == this.value;

  @override
  PopupMenuItemState<T, CustomDropDownItem<T>> createState() =>
      PopupMenuItemState<T, CustomDropDownItem<T>>();
}

class PopupMenuItemState<T, W extends CustomDropDownItem<T>> extends State<W> {
  @protected
  Widget buildChild() => widget.child;

  @protected
  void handleTap() {
    Navigator.pop<T>(context, widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    TextStyle style =
        widget.textStyle ?? popupMenuTheme.textStyle ?? theme.textTheme.subtitle2;

    if (!widget.enabled) style = style.copyWith(color: theme.disabledColor);

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: Baseline(
        baseline: widget.height - _kBaselineOffsetFromBottom,
        baselineType: style.textBaseline,
        child: buildChild(),
      ),
    );
    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }

    return InkWell(
      onTap: widget.enabled ? handleTap : null,
      child: Container(
        height: widget.height,
        padding:
            const EdgeInsets.symmetric(horizontal: _kMenuHorizontalPadding),
        child: item,
      ),
    );
  }
}

class CheckedPopupMenuItem<T> extends CustomDropDownItem<T> {
  const CheckedPopupMenuItem({
    Key key,
    T value,
    this.checked = false,
    bool enabled = true,
    Widget child,
  })  : assert(checked != null),
        super(
          key: key,
          value: value,
          enabled: enabled,
          child: child,
        );

  final bool checked;

  @override
  Widget get child => super.child;

  @override
  _CheckedPopupMenuItemState<T> createState() =>
      _CheckedPopupMenuItemState<T>();
}

class _CheckedPopupMenuItemState<T>
    extends PopupMenuItemState<T, CheckedPopupMenuItem<T>>
    with SingleTickerProviderStateMixin {
  static const Duration _fadeDuration = Duration(milliseconds: 150);
  AnimationController _controller;

  Animation<double> get _opacity => _controller.view;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _fadeDuration, vsync: this)
      ..value = widget.checked ? 1.0 : 0.0
      ..addListener(() => setState(() {
            /* animation changed */
          }));
  }

  @override
  void handleTap() {
    if (widget.checked)
      _controller.reverse();
    else
      _controller.forward();
    super.handleTap();
  }

  @override
  Widget buildChild() {
    return ListTile(
      enabled: widget.enabled,
      leading: FadeTransition(
        opacity: _opacity,
        child: Icon(_controller.isDismissed ? null : Icons.done),
      ),
      title: widget.child,
    );
  }
}

class _PopupMenu<T> extends StatelessWidget {
  const _PopupMenu({
    Key key,
    this.route,
    this.semanticLabel,
  }) : super(key: key);

  final _PopupMenuRoute<T> route;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double unit = 1.0 / (route.items.length + 1.5);
    final List<Widget> children = <Widget>[];
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);

    for (int i = 0; i < route.items.length; i += 1) {
      final double start = (i + 1) * unit;
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      final CurvedAnimation opacity = CurvedAnimation(
        parent: route.animation,
        curve: Interval(start, end),
      );
      Widget item = route.items[i];
      if (route.initialValue != null &&
          route.items[i].represents(route.initialValue)) {
        item = Container(
          color: Theme.of(context).highlightColor,
          child: item,
        );
      }
      children.add(FadeTransition(
        opacity: opacity,
        child: item,
      ));
    }

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));
    final CurveTween width = CurveTween(curve: Interval(0.0, unit));
    final CurveTween height =
        CurveTween(curve: Interval(0.0, unit * route.items.length));

    final Widget child = SizedBox(
      width: _kMenuScreenWidth,
      child: IntrinsicWidth(
        stepWidth: _kMenuWidthStep,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: semanticLabel,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: _kMenuVerticalPadding),
            child: ListBody(children: children),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: opacity.evaluate(route.animation),
          child: Material(
            shape: route.shape ?? popupMenuTheme.shape,
            color: route.color ?? popupMenuTheme.color,
            type: MaterialType.card,
            elevation: route.elevation ?? popupMenuTheme.elevation ?? 8.0,
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              widthFactor: width.evaluate(route.animation),
              heightFactor: height.evaluate(route.animation),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}

class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(
      this.position, this.selectedItemOffset, this.textDirection);

  final RelativeRect position;

  final double selectedItemOffset;

  final TextDirection textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest -
        const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double y;
//    if (selectedItemOffset == null) {
      y = position.top;
//    } else {
//      y = position.top +
//          (size.height - position.top - position.bottom) / 2.0 -
//          selectedItemOffset;
//    }

    double x;
    if (position.left > position.right) {
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      x = position.left;
    } else {
      assert(textDirection != null);
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    if (x < _kMenuScreenPadding)
      x = _kMenuScreenPadding;
    else if (x + childSize.width > size.width - _kMenuScreenPadding)
      x = size.width - childSize.width - _kMenuScreenPadding;
    if (y < _kMenuScreenPadding)
      y = _kMenuScreenPadding;
    else if (y + childSize.height > size.height - _kMenuScreenPadding)
      y = size.height - childSize.height - _kMenuScreenPadding;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}

class _PopupMenuRoute<T> extends PopupRoute<T> {
  _PopupMenuRoute({
    this.position,
    this.items,
    this.initialValue,
    this.elevation,
    this.theme,
    this.popupMenuTheme,
    this.barrierLabel,
    this.semanticLabel,
    this.shape,
    this.color,
  });

  final RelativeRect position;
  final List<PopupMenuEntry<T>> items;
  final dynamic initialValue;
  final double elevation;
  final ThemeData theme;
  final String semanticLabel;
  final ShapeBorder shape;
  final Color color;
  final PopupMenuThemeData popupMenuTheme;

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kMenuCloseIntervalEnd),
    );
  }

  @override
  Duration get transitionDuration => _kMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => null;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    double selectedItemOffset;
    if (initialValue != null) {
      double y = _kMenuVerticalPadding;
      for (PopupMenuEntry<T> entry in items) {
        if (entry.represents(initialValue)) {
          selectedItemOffset = y + entry.height / 2.0;
          break;
        }
        y += entry.height;
      }
    }

    Widget menu = _PopupMenu<T>(route: this, semanticLabel: semanticLabel);
    if (popupMenuTheme != null)
      menu = PopupMenuTheme(
          data: PopupMenuThemeData(textStyle: popupMenuTheme.textStyle),
          child: menu);
    if (theme != null) menu = Theme(data: theme, child: menu);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _PopupMenuRouteLayout(
              position,
              selectedItemOffset,
              Directionality.of(context),
            ),
            child: menu,
          );
        },
      ),
    );
  }
}

Future<T> showMenu<T>({
  @required BuildContext context,
  @required RelativeRect position,
  @required List<PopupMenuEntry<T>> items,
  T initialValue,
  double elevation,
  String semanticLabel,
  ShapeBorder shape,
  Color color,
}) {
  assert(context != null);
  assert(position != null);
  assert(items != null && items.isNotEmpty);
  assert(debugCheckHasMaterialLocalizations(context));
  String label = semanticLabel;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      label = semanticLabel;
      break;
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      label =
          semanticLabel ?? MaterialLocalizations.of(context)?.popupMenuLabel;
  }

  return Navigator.push(
      context,
      _PopupMenuRoute<T>(
        position: position,
        items: items,
        initialValue: initialValue,
        elevation: elevation,
        semanticLabel: label,
        // theme: Theme.of(context, shadowThemeOnly: true),
        popupMenuTheme: PopupMenuTheme.of(context),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        shape: shape,
        color: color,
      ));
}

typedef PopupMenuItemSelected<T> = void Function(T value);

typedef PopupMenuCanceled = void Function();

typedef PopupMenuItemBuilder<T> = List<PopupMenuEntry<T>> Function(
    BuildContext context);

class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    Key key,
    @required this.itemBuilder,
    this.initialValue,
    this.onSelected,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.icon,
    this.enabled = true,
    this.shape,
    this.color,
  })  : assert(itemBuilder != null),
        assert(enabled != null),
        assert(!(child != null && icon != null)),
        super(key: key);

  final PopupMenuItemBuilder<T> itemBuilder;

  final T initialValue;

  final PopupMenuItemSelected<T> onSelected;

  final PopupMenuCanceled onCanceled;

  final String tooltip;

  final double elevation;

  final EdgeInsetsGeometry padding;

  final Widget child;

  final Icon icon;

  final bool enabled;

  final ShapeBorder shape;

  final Color color;

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  void showButtonMenu() {
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, _kMenuScreenHeight), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<PopupMenuEntry<T>> items = widget.itemBuilder(context);
    if (items.isNotEmpty) {
      showMenu<T>(
        context: context,
        elevation: widget.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: widget.initialValue,
        position: position,
        shape: widget.shape ?? popupMenuTheme.shape,
        color: widget.color ?? popupMenuTheme.color,
      ).then<void>((T newValue) {
        if (!mounted) return null;
        if (newValue == null) {
          if (widget.onCanceled != null) widget.onCanceled();
          return null;
        }
        if (widget.onSelected != null) widget.onSelected(newValue);
      });
    }
  }

  Icon _getIcon(TargetPlatform platform) {
    assert(platform != null);
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return const Icon(Icons.more_vert);
      case TargetPlatform.iOS:
        return const Icon(Icons.more_horiz);
    }
    return null;
  }

  GlobalKey _keyRed = GlobalKey();

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return widget.child != null
        ? InkWell(
            key: _keyRed,
            onTap: widget.enabled ? (){
              _setSizes();
              showButtonMenu();
            } : null,
            child: widget.child,
          )
        : IconButton(
            icon: widget.icon ?? _getIcon(Theme.of(context).platform),
            padding: widget.padding,
            tooltip: widget.tooltip ??
                MaterialLocalizations.of(context).showMenuTooltip,
            onPressed: widget.enabled ? showButtonMenu : null,
          );
  }

  _setSizes() {
    final RenderBox renderBoxRed = _keyRed.currentContext.findRenderObject();
    final sizeRed = renderBoxRed.size;
    _kMenuScreenWidth = sizeRed.width;
    _kMenuScreenHeight = sizeRed.height;
  }
}
