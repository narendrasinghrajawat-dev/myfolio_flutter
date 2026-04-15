import 'package:flutter/material.dart';
import '../utils/screen_util.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveBuilder({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.desktop) {
          return desktop;
        } else if (constraints.maxWidth >= AppBreakpoints.tablet) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

/// A responsive container that adapts its child based on screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final Decoration? mobileDecoration;
  final Decoration? tabletDecoration;
  final Decoration? desktopDecoration;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileDecoration,
    this.tabletDecoration,
    this.desktopDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Container(
        padding: mobilePadding ?? EdgeInsets.zero,
        decoration: mobileDecoration,
        child: child,
      ),
      tablet: Container(
        padding: tabletPadding ?? EdgeInsets.zero,
        decoration: tabletDecoration,
        child: child,
      ),
      desktop: Container(
        padding: desktopPadding ?? EdgeInsets.zero,
        decoration: desktopDecoration,
        child: child,
      ),
    );
  }
}

/// A responsive grid that adapts its column count based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    required this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: GridView.count(
        crossAxisCount: mobileColumns,
        childAspectRatio: childAspectRatio ?? 1.0,
        crossAxisSpacing: crossAxisSpacing ?? 8.0,
        mainAxisSpacing: mainAxisSpacing ?? 8.0,
        children: children,
      ),
      tablet: GridView.count(
        crossAxisCount: tabletColumns ?? mobileColumns,
        childAspectRatio: childAspectRatio ?? 1.0,
        crossAxisSpacing: crossAxisSpacing ?? 12.0,
        mainAxisSpacing: mainAxisSpacing ?? 12.0,
        children: children,
      ),
      desktop: GridView.count(
        crossAxisCount: desktopColumns ?? tabletColumns ?? mobileColumns,
        childAspectRatio: childAspectRatio ?? 1.2,
        crossAxisSpacing: crossAxisSpacing ?? 16.0,
        mainAxisSpacing: mainAxisSpacing ?? 16.0,
        children: children,
      ),
    );
  }
}

/// A responsive row that adapts its children based on screen size
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mobileAlignment;
  final MainAxisAlignment? tabletAlignment;
  final MainAxisAlignment? desktopAlignment;
  final double? spacing;
  final bool? wrap;

  const ResponsiveRow({
    Key? key,
    required this.children,
    this.mobileAlignment,
    this.tabletAlignment,
    this.desktopAlignment,
    this.spacing,
    this.wrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Row(
        mainAxisAlignment: mobileAlignment ?? MainAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 8.0, wrap: wrap),
      ),
      tablet: Row(
        mainAxisAlignment: tabletAlignment ?? MainAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 12.0, wrap: wrap),
      ),
      desktop: Row(
        mainAxisAlignment: desktopAlignment ?? MainAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 16.0, wrap: wrap),
      ),
    );
  }

  List<Widget> _addSpacing(List<Widget> children, double spacing, {bool wrap = false}) {
    if (children.isEmpty) return children;
    
    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox.SizedBox(width: spacing, height: 0));
      }
    }
    
    return spacedChildren;
  }
}

/// A responsive column that adapts its children based on screen size
class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment? mobileAlignment;
  final CrossAxisAlignment? tabletAlignment;
  final CrossAxisAlignment? desktopAlignment;
  final double? spacing;
  final MainAxisSize? mainAxisSize;

  const ResponsiveColumn({
    Key? key,
    required this.children,
    this.mobileAlignment,
    this.tabletAlignment,
    this.desktopAlignment,
    this.spacing,
    this.mainAxisSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Column(
        crossAxisAlignment: mobileAlignment ?? CrossAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 8.0),
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      ),
      tablet: Column(
        crossAxisAlignment: tabletAlignment ?? CrossAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 12.0),
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      ),
      desktop: Column(
        crossAxisAlignment: desktopAlignment ?? CrossAxisAlignment.start,
        children: _addSpacing(children, spacing ?? 16.0),
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
      ),
    );
  }
}

/// A responsive stack that adapts its children based on screen size
class ResponsiveStack extends StatelessWidget {
  final List<Widget> children;
  final Alignment? mobileAlignment;
  final Alignment? tabletAlignment;
  final Alignment? desktopAlignment;

  const ResponsiveStack({
    Key? key,
    required this.children,
    this.mobileAlignment,
    this.tabletAlignment,
    this.desktopAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: Stack(
        alignment: mobileAlignment ?? Alignment.center,
        children: children,
      ),
      tablet: Stack(
        alignment: tabletAlignment ?? Alignment.center,
        children: children,
      ),
      desktop: Stack(
        alignment: desktopAlignment ?? Alignment.center,
        children: children,
      ),
    );
  }
}
