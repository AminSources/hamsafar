import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamsafar/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String fontDisplay = 'Lalezar';
  static const String fontBody = 'Vazirmatn';

  //* Light theme entry point
  static ThemeData get light => _build(_lightScheme);

  //* Dark theme entry point
  static ThemeData get dark => _build(_darkScheme);

  //* Material 3 Light Color Scheme
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: AppColors.primaryTint200,
    onPrimaryContainer: AppColors.primaryDeep,
    secondary: AppColors.saffron,
    onSecondary: Color(0xFF2B1E06),
    secondaryContainer: AppColors.saffronTint,
    onSecondaryContainer: Color(0xFF7A5210),
    tertiary: AppColors.primaryDeep,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFCFE9E2),
    onTertiaryContainer: Color(0xFF06403A),
    error: AppColors.brick,
    onError: Color(0xFFFFFFFF),
    errorContainer: AppColors.brickTint,
    onErrorContainer: Color(0xFF8C2F1D),
    surface: AppColors.shell,
    onSurface: AppColors.ink,
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceContainerLow: Color(0xFFF2F4EE),
    surfaceContainer: Color(0xFFEDEFE9),
    surfaceContainerHigh: Color(0xFFE7EAE2),
    surfaceContainerHighest: Color(0xFFE1E5DC),
    onSurfaceVariant: AppColors.inkSoft,
    outline: Color(0xFFB8C4BB),
    outlineVariant: AppColors.line,
    shadow: Color(0x331B2A24),
    scrim: Color(0x661B2A24),
    inverseSurface: AppColors.ink,
    onInverseSurface: AppColors.shell,
    inversePrimary: Color(0xFF4ED3BE),
    surfaceTint: AppColors.primary,
  );

  //* Material 3 Dark Color Scheme
  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.darkPrimary,
    onPrimary: Color(0xFF052E27),
    primaryContainer: AppColors.primaryDeep,
    onPrimaryContainer: AppColors.primaryTint200,
    secondary: AppColors.darkSaffron,
    onSecondary: Color(0xFF402D07),
    secondaryContainer: Color(0xFF5A4312),
    onSecondaryContainer: AppColors.saffronTint,
    tertiary: Color(0xFF4EC9B4),
    onTertiary: Color(0xFF052E27),
    tertiaryContainer: AppColors.primaryDeep,
    onTertiaryContainer: AppColors.primaryTint200,
    error: AppColors.darkBrick,
    onError: Color(0xFF401008),
    errorContainer: Color(0xFF641F10),
    onErrorContainer: AppColors.brickTint,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkTextPrimary,
    surfaceContainerLowest: Color(0xFF0C1210),
    surfaceContainerLow: Color(0xFF142019),
    surfaceContainer: AppColors.darkSurface,
    surfaceContainerHigh: AppColors.darkSurfaceHigh,
    surfaceContainerHighest: Color(0xFF2C3E33),
    onSurfaceVariant: AppColors.darkTextSecondary,
    outline: Color(0xFF43544A),
    outlineVariant: AppColors.darkBorder,
    shadow: Color(0x66000000),
    scrim: Color(0x99000000),
    inverseSurface: AppColors.shell,
    onInverseSurface: AppColors.ink,
    inversePrimary: AppColors.primary,
    surfaceTint: AppColors.darkPrimary,
  );

  //* Typography configuration
  static TextTheme _textTheme(ColorScheme scheme) {
    final Color onSurface = scheme.onSurface;
    final Color soft = scheme.onSurfaceVariant;

    return TextTheme(
      // Display (Lalezar)
      displayLarge: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 34,
        color: onSurface,
        height: 1.25,
      ),
      displayMedium: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 30,
        color: onSurface,
        height: 1.25,
      ),
      displaySmall: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 26,
        color: onSurface,
        height: 1.3,
      ),

      // Headlines (Lalezar)
      headlineLarge: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 24,
        color: onSurface,
        height: 1.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 21,
        color: onSurface,
        height: 1.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontDisplay,
        fontSize: 18,
        color: onSurface,
        height: 1.35,
      ),

      // Titles (Vazirmatn Bold/SemiBold)
      titleLarge: TextStyle(
        fontFamily: fontBody,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: onSurface,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontFamily: fontBody,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: onSurface,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: fontBody,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: onSurface,
        height: 1.5,
      ),

      // Body (Vazirmatn Regular)
      bodyLarge: TextStyle(
        fontFamily: fontBody,
        fontSize: 16,
        color: onSurface,
        height: 1.7,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontBody,
        fontSize: 14,
        color: onSurface,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontFamily: fontBody,
        fontSize: 12,
        color: soft,
        height: 1.6,
      ),

      // Labels (Vazirmatn Medium/Bold)
      labelLarge: TextStyle(
        fontFamily: fontBody,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: onSurface,
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: fontBody,
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
        color: onSurface,
        height: 1.4,
      ),
      labelSmall: TextStyle(
        fontFamily: fontBody,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: soft,
        height: 1.4,
        letterSpacing: 0.2,
      ),
    );
  }

  //* Main theme builder
  static ThemeData _build(ColorScheme scheme) {
    final bool isDark = scheme.brightness == Brightness.dark;
    final TextTheme textTheme = _textTheme(scheme);

    final Color cardColor = isDark ? AppColors.darkSurface : Colors.white;
    final Color inputFill = isDark ? AppColors.darkSurfaceHigh : Colors.white;
    final Color chipBg = isDark ? AppColors.darkSurfaceHigh : AppColors.mist;

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      fontFamily: fontBody,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      cardColor: cardColor,
      dividerColor: scheme.outlineVariant,
      splashColor: isDark ? const Color(0x142FB8A2) : const Color(0x140E8172),
      highlightColor: isDark
          ? const Color(0x0D2FB8A2)
          : const Color(0x0D0E8172),
      splashFactory: InkRipple.splashFactory,
      textTheme: textTheme,
      primaryTextTheme: textTheme.apply(
        bodyColor: scheme.onPrimary,
        displayColor: scheme.onPrimary,
      ),
      iconTheme: IconThemeData(color: scheme.onSurface, size: 24),

      //* AppBar styling
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleSpacing: AppSpacing.lg,
        titleTextStyle: TextStyle(
          fontFamily: fontDisplay,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: scheme.onSurface,
        ),
        iconTheme: IconThemeData(color: scheme.onSurface, size: 24),
        actionsIconTheme: IconThemeData(color: scheme.onSurface, size: 24),
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
      ),

      //* Card styling (Radius 16, Thin border)
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shadowColor: AppShadows.soft.color,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.large,
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : scheme.outlineVariant,
            width: AppBorders.widthThin,
          ),
        ),
      ),

      //* Filled Button (Primary action, Height 48)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.35),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.6),
          elevation: 0,
          minimumSize: const Size.fromHeight(AppRadius.control),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
          textStyle: textTheme.labelLarge,
        ),
      ),

      //* Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.primary.withValues(alpha: 0.35),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.6),
          elevation: 0,
          minimumSize: const Size.fromHeight(AppRadius.control),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
          textStyle: textTheme.labelLarge,
        ),
      ),

      //* Outlined Button (1.5px border)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: scheme.primary, width: AppBorders.width),
          minimumSize: const Size.fromHeight(AppRadius.control),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
          textStyle: textTheme.labelLarge,
        ),
      ),

      //* Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),

      //* Icon Button & FAB
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
          iconSize: 24,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppRadius.lg),
        ),
      ),

      //* Input Decoration (Forms)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        isDense: true,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: 14,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        floatingLabelStyle: TextStyle(color: scheme.primary),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        prefixIconColor: scheme.onSurfaceVariant,
        suffixIconColor: scheme.onSurfaceVariant,
        errorStyle: textTheme.labelSmall?.copyWith(color: scheme.error),
        border: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: scheme.outlineVariant,
            width: AppBorders.width,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: scheme.outlineVariant,
            width: AppBorders.width,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: scheme.primary,
            width: AppBorders.width,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(
            color: scheme.error,
            width: AppBorders.widthThin,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.medium,
          borderSide: BorderSide(color: scheme.error, width: AppBorders.width),
        ),
      ),

      //* Selection Controls (Checkbox, Radio, Switch)
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? scheme.primary
              : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(scheme.onPrimary),
        side: BorderSide(color: scheme.outline, width: AppBorders.width),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStatePropertyAll(scheme.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? scheme.onPrimary
              : scheme.outline,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.outlineVariant,
        ),
      ),

      //* Dropdown Menu
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: textTheme.bodyMedium?.copyWith(color: scheme.onSurface),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(cardColor),
          elevation: const WidgetStatePropertyAll(4),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.medium),
          ),
        ),
      ),

      //* Bottom Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        height: 68,
        elevation: 0,
        backgroundColor: cardColor,
        indicatorColor: isDark
            ? const Color(0xFF123E37)
            : AppColors.primaryTint200,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            size: 24,
            color: s.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (s) => TextStyle(
            fontFamily: fontBody,
            fontSize: 11.5,
            fontWeight: s.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: s.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
      ),

      //* Tab Bar
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: scheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: scheme.outlineVariant,
        dividerHeight: AppBorders.width,
        splashFactory: InkRipple.splashFactory,
      ),

      //* Chips
      chipTheme: ChipThemeData(
        backgroundColor: chipBg,
        selectedColor: scheme.primary,
        checkmarkColor: scheme.onPrimary,
        labelStyle: textTheme.labelMedium?.copyWith(color: scheme.onSurface),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.onPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.small),
      ),

      //* Badge (Notifications)
      badgeTheme: BadgeThemeData(
        backgroundColor: scheme.error,
        textColor: Colors.white,
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        smallSize: 8,
      ),

      //* Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.extraLarge),
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: scheme.onSurface,
        ),
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
          height: 1.7,
        ),
      ),

      //* Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: cardColor,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        showDragHandle: true,
        dragHandleColor: scheme.outline,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadius.xl),
            topRight: Radius.circular(AppRadius.xl),
          ),
        ),
      ),

      //* SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? AppColors.darkSurfaceHigh : AppColors.ink,
        contentTextStyle: textTheme.bodySmall?.copyWith(color: AppColors.shell),
        actionTextColor: AppColors.saffron,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
      ),

      //* ListTile & ExpansionTile
      listTileTheme: ListTileThemeData(
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: scheme.primary,
        collapsedIconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        collapsedTextColor: scheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
        collapsedShape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
      ),

      //* Divider (1.5px)
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: AppBorders.width,
        space: 1,
      ),

      //* Progress Indicator
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.outlineVariant,
        circularTrackColor: scheme.outlineVariant,
      ),

      //* Tooltip
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceHigh : AppColors.ink,
          borderRadius: AppRadius.small,
        ),
        textStyle: textTheme.labelSmall?.copyWith(color: AppColors.shell),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),

      //* Segmented Button
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? scheme.primary
                : Colors.transparent,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected)
                ? scheme.onPrimary
                : scheme.onSurfaceVariant,
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: scheme.outlineVariant,
              width: AppBorders.widthThin,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: AppRadius.medium),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(0, 44)),
        ),
      ),

      //* Text Selection
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.primary,
        selectionColor: scheme.primary.withValues(alpha: 0.25),
        selectionHandleColor: scheme.primary,
      ),
    );
  }
}
