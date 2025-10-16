import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/responsive_theme.dart';

/// ユーザー情報を表示するヘッダー
class UserInfoHeader extends ConsumerStatefulWidget {
  const UserInfoHeader({super.key});

  @override
  ConsumerState<UserInfoHeader> createState() => _UserInfoHeaderState();
}

class _UserInfoHeaderState extends ConsumerState<UserInfoHeader> {
  String? userName;
  int? userAgeYears;
  int? userAgeMonths;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userAgeYears = prefs.getInt('user_age_years');
      userAgeMonths = prefs.getInt('user_age_months');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.responsive;
    final size = MediaQuery.sizeOf(context);
    final headerHeight = theme.spacing.headerHeight;
    final padH = size.width * 0.02;

    final headerFonts = theme.calculateHeaderFontSizes(headerHeight);

    return SafeArea(
      child: Container(
        height: headerHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: padH),
        child: Row(
          children: [
            // 左側：ユーザー名
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person,
                      size: headerFonts.title * 0.8,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        userName ?? 'ゲスト',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: headerFonts.title * 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 中央：年齢
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cake,
                      size: headerFonts.title * 0.8,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        userAgeYears != null && userAgeMonths != null
                            ? '${userAgeYears}さい ${userAgeMonths}かげつ'
                            : '年齢不明',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: headerFonts.title * 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 右側：有料ユーザー表示
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.015,
                vertical: size.height * 0.005,
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.orange,
                  width: 2,
                ),
              ),
              child: Text(
                '有料ユーザー',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: headerFonts.title * 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}