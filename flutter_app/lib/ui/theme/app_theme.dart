import 'package:flutter/material.dart';

/// アプリ全体で使用する色定義
class AppColors {
  AppColors._(); // インスタンス化を防ぐ

  // プライマリカラー
  static const primary = Color(0xFF5B9BD5);
  static const primaryDark = Color(0xFF1976D2);

  // 背景色
  static const background = Color(0xFFE3F2FD);

  // テキストカラー
  static const textPrimary = Color(0xFF1976D2);
  static const textSecondary = Color(0xFF424242);

  // 機能色
  static const success = Colors.green;
  static const error = Colors.red;
  static const warning = Colors.orange;
}

/// アプリ全体で使用するサイズ定義
class AppSizes {
  AppSizes._();

  // ボーダーラディウス
  static const borderRadiusSmall = 8.0;
  static const borderRadiusMedium = 12.0;
  static const borderRadiusLarge = 16.0;

  // パディング
  static const paddingSmall = 8.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 24.0;
  static const paddingExtraLarge = 32.0;

  // ボタン高さ
  static const buttonHeightSmall = 48.0;
  static const buttonHeightMedium = 56.0;
  static const buttonHeightLarge = 80.0;

  // フォントサイズ
  static const fontSizeSmall = 12.0;
  static const fontSizeMedium = 16.0;
  static const fontSizeLarge = 20.0;
  static const fontSizeExtraLarge = 22.0;
  static const fontSizeTitle = 32.0;
}

/// アプリ全体で使用するボタンスタイル
class AppButtonStyles {
  AppButtonStyles._();

  /// プライマリボタンスタイル（大）
  static final primaryLarge = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.paddingExtraLarge,
      vertical: 20,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.fontSizeExtraLarge,
      fontWeight: FontWeight.bold,
    ),
  );

  /// プライマリボタンスタイル（中）
  static final primaryMedium = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.paddingLarge,
      vertical: AppSizes.paddingMedium,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.fontSizeLarge,
      fontWeight: FontWeight.bold,
    ),
  );

  /// エラー/削除ボタンスタイル
  static final danger = ElevatedButton.styleFrom(
    backgroundColor: Colors.red.shade400,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.paddingLarge,
      vertical: AppSizes.paddingMedium,
    ),
    textStyle: const TextStyle(
      fontSize: AppSizes.fontSizeLarge,
      fontWeight: FontWeight.bold,
    ),
  );

  /// 無効化されたボタンの背景色
  static final disabledBackgroundColor = Colors.grey.shade300;
}

/// アプリ全体で使用するテキストスタイル
class AppTextStyles {
  AppTextStyles._();

  /// タイトル
  static const title = TextStyle(
    fontSize: AppSizes.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// サブタイトル
  static const subtitle = TextStyle(
    fontSize: AppSizes.fontSizeLarge,
    color: AppColors.textSecondary,
  );

  /// 本文（太字）
  static const bodyBold = TextStyle(
    fontSize: AppSizes.fontSizeLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  /// ボタンテキスト（大）
  static const buttonLarge = TextStyle(
    fontSize: AppSizes.fontSizeExtraLarge,
    fontWeight: FontWeight.bold,
  );

  /// ボタンテキスト（中）
  static const buttonMedium = TextStyle(
    fontSize: AppSizes.fontSizeLarge,
    fontWeight: FontWeight.bold,
  );
}
