import 'package:flutter/material.dart';

/// レスポンシブなテーマとサイズ管理
/// 画面サイズに応じて適切なサイズ、フォント、スペーシングを提供
class ResponsiveTheme {
  final BuildContext context;
  final Size screenSize;
  final bool isPhone;
  final bool isTablet;
  final bool isDesktop;

  ResponsiveTheme(this.context) 
    : screenSize = MediaQuery.of(context).size,
      isPhone = MediaQuery.of(context).size.width < 600,
      isTablet = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 1200,
      isDesktop = MediaQuery.of(context).size.width >= 1200;

  // アスペクト比ベースの計算
  double get aspectRatio => screenSize.width / screenSize.height;
  bool get isWide => aspectRatio > 1.5; // 16:9以上（iPhone横向きなど）
  bool get isSquarish => aspectRatio >= 0.7 && aspectRatio <= 1.4; // iPad 4:3など
  double get scaleFactor => (screenSize.width / 375).clamp(0.8, 2.0); // iPhone 13/14基準

  // フォントサイズ - ヘッダー高さに基づく自動計算（適切なサイズ）
  FontSizes get fontSizes {
    final headerHeight = spacing.headerHeight;
    
    return FontSizes(
      // ヘッダータイトル: 7%ヘッダーに合わせて係数を調整（さらに10%減）
      headerTitle: headerHeight * 0.567,
      // ヘッダーサブタイトル: 不要だが残す
      headerSubtitle: headerHeight * 0.30,
      
      // 質問テキスト: タイトルと同等（10%減）
      questionText: headerHeight * 0.63,
    
    // ゲーム内テキスト - スケールファクターベース
    gameTitle: 12.0 * scaleFactor,
    gameContent: 10.0 * scaleFactor,
    gameResult: 20.0 * scaleFactor,
    
    // キーパッド・ボタン - スケールファクターベース  
    keypadNumber: 20.0 * scaleFactor,
    keypadLabel: 16.0 * scaleFactor,
    
      // スピーカーボタン: 小さなヘッダーに合わせて係数を調整
      speakerButton: headerHeight * 0.55,
    
    // 設定画面 - スケールファクターベース
    settingsTitle: 18.0 * scaleFactor,
    settingsLabel: 14.0 * scaleFactor,
    );
  }

  // 安全なフォントサイズ計算（AutoSizeText代替）
  double calculateSafeFontSize(double baseSize, {double minSize = 12.0, double maxSize = 32.0}) {
    return baseSize.clamp(minSize, maxSize);
  }

  // ヘッダー用のフォントサイズ計算
  HeaderFontSizes calculateHeaderFontSizes(double headerHeight) {
    return HeaderFontSizes(
      title: calculateSafeFontSize(headerHeight * 0.36, minSize: 12.0, maxSize: 24.0),
      question: calculateSafeFontSize(headerHeight * 0.45, minSize: 12.0, maxSize: 32.0),
      speakerButton: calculateSafeFontSize(headerHeight * 0.45, minSize: 12.0, maxSize: 28.0), // 問題文と同じサイズに
      progress: calculateSafeFontSize(headerHeight * 0.45, minSize: 12.0, maxSize: 24.0),
    );
  }

  // スペーシング
  Spacing get spacing {
    // ヘッダー高さを画面高さの割合で統一計算（全デバイス対応）- 1.5倍に拡大
    final headerHeight = screenSize.height * 0.126; // 0.084 → 0.126 (1.5倍)
    
    return Spacing(
      // パディング - スケールファクターベース
      screenPadding: EdgeInsets.symmetric(
        horizontal: 16.0 * scaleFactor,
        vertical: 12.0 * scaleFactor,
      ),
      headerPadding: EdgeInsets.symmetric(
        horizontal: 8.0 * scaleFactor,
        vertical: headerHeight * 0.05, // ヘッダー高さの5%
      ),
      cardPadding: EdgeInsets.all(12.0 * scaleFactor),
    
    // マージン - スケールファクターベース
    cardSpacing: 12.0 * scaleFactor,
    elementSpacing: 8.0 * scaleFactor,
    smallSpacing: 4.0 * scaleFactor,
    
    // 特定要素の高さ - 統一された計算
    headerHeight: headerHeight,
    buttonHeight: 44.0 * scaleFactor,
    );
  }

  // アイコンサイズ - ヘッダー高さに基づく自動計算（適切なサイズ）
  IconSizes get iconSizes {
    final headerHeight = spacing.headerHeight;
    return IconSizes(
      // ヘッダー - 小さなヘッダーに合わせて係数を大きく調整
      headerBack: headerHeight * 0.50,
      headerStar: headerHeight * 0.40,
      
      // ゲーム内 - スケールファクターベース
      gameIcon: 24.0 * scaleFactor,
      // スピーカーアイコン: ヘッダーベース
      speakerIcon: headerHeight * 0.40,
    
      // ボタン - スケールファクターベース
      buttonIcon: 18.0 * scaleFactor,
    );
  }

  // レイアウト制約 - アスペクト比・スケールファクターベース
  Constraints get constraints => Constraints(
    // カードの最大・最小サイズ - スケールファクターベース
    cardMinHeight: 100.0 * scaleFactor,
    cardMaxHeight: 180.0 * scaleFactor,
    
    // ゲーム領域 - アスペクト比ベース
    gameAreaMaxWidth: isWide ? screenSize.width * 0.8 : double.infinity,
    
    // モーダル・ダイアログ - 画面サイズベース
    modalMaxWidth: screenSize.width * (isWide ? 0.6 : 0.9),
    
    // ヘッダー固定幅 - スケールファクターベース
    headerTitleWidth: 200.0 * scaleFactor,
  );

  // 角丸 - スケールファクターベース
  BorderRadius get borderRadius => BorderRadius.circular(
    14.0 * scaleFactor
  );

  // 小さい角丸 - スケールファクターベース  
  BorderRadius get smallBorderRadius => BorderRadius.circular(
    8.0 * scaleFactor
  );
}

/// ヘッダー用フォントサイズのデータクラス
class HeaderFontSizes {
  final double title;
  final double question;
  final double speakerButton;
  final double progress;

  const HeaderFontSizes({
    required this.title,
    required this.question,
    required this.speakerButton,
    required this.progress,
  });
}

/// フォントサイズのデータクラス
class FontSizes {
  final double headerTitle;
  final double headerSubtitle;
  final double questionText;
  final double gameTitle;
  final double gameContent;
  final double gameResult;
  final double keypadNumber;
  final double keypadLabel;
  final double speakerButton;
  final double settingsTitle;
  final double settingsLabel;

  const FontSizes({
    required this.headerTitle,
    required this.headerSubtitle,
    required this.questionText,
    required this.gameTitle,
    required this.gameContent,
    required this.gameResult,
    required this.keypadNumber,
    required this.keypadLabel,
    required this.speakerButton,
    required this.settingsTitle,
    required this.settingsLabel,
  });
}

/// スペーシングのデータクラス
class Spacing {
  final EdgeInsets screenPadding;
  final EdgeInsets headerPadding;
  final EdgeInsets cardPadding;
  final double cardSpacing;
  final double elementSpacing;
  final double smallSpacing;
  final double headerHeight;
  final double buttonHeight;

  const Spacing({
    required this.screenPadding,
    required this.headerPadding,
    required this.cardPadding,
    required this.cardSpacing,
    required this.elementSpacing,
    required this.smallSpacing,
    required this.headerHeight,
    required this.buttonHeight,
  });
}

/// アイコンサイズのデータクラス
class IconSizes {
  final double headerBack;
  final double headerStar;
  final double gameIcon;
  final double speakerIcon;
  final double buttonIcon;

  const IconSizes({
    required this.headerBack,
    required this.headerStar,
    required this.gameIcon,
    required this.speakerIcon,
    required this.buttonIcon,
  });
}

/// レイアウト制約のデータクラス
class Constraints {
  final double cardMinHeight;
  final double cardMaxHeight;
  final double gameAreaMaxWidth;
  final double modalMaxWidth;
  final double headerTitleWidth;

  const Constraints({
    required this.cardMinHeight,
    required this.cardMaxHeight,
    required this.gameAreaMaxWidth,
    required this.modalMaxWidth,
    required this.headerTitleWidth,
  });
}

/// BuildContextの拡張でテーマへの簡単アクセスを提供
extension ResponsiveThemeExtension on BuildContext {
  ResponsiveTheme get responsive => ResponsiveTheme(this);
  FontSizes get fontSizes => ResponsiveTheme(this).fontSizes;
  Spacing get spacing => ResponsiveTheme(this).spacing;
  IconSizes get iconSizes => ResponsiveTheme(this).iconSizes;
  Constraints get constraints => ResponsiveTheme(this).constraints;
}