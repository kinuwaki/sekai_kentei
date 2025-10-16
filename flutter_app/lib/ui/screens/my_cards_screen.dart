import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/system_header.dart';
import '../../core/responsive_theme.dart';

class MyCardsScreen extends ConsumerStatefulWidget {
  const MyCardsScreen({super.key});

  @override
  ConsumerState<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends ConsumerState<MyCardsScreen> {
  final List<String> cardImages = [
    'assets/images/monsters/000.jpg',
    'assets/images/monsters/001.jpg',
    'assets/images/monsters/002.jpg',
    'assets/images/monsters/003.jpg',
    'assets/images/monsters/004.jpg',
    'assets/images/monsters/005.jpg',
  ];

  String? selectedCard;

  void _showCardZoom(BuildContext context, String imagePath) {
    setState(() {
      selectedCard = imagePath;
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: MediaQuery.of(context).padding.top + 16.0,
              ),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 5.0,
                boundaryMargin: const EdgeInsets.all(100),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    ).then((_) {
      setState(() {
        selectedCard = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.responsive;
    final padding = theme.spacing.screenPadding;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      body: Column(
        children: [
          // システムヘッダー
          SystemHeader(
            title: '自分のカード',
            onBack: () => Navigator.of(context).pop(),
          ),

          // カードグリッド
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE8F4FD),
                    const Color(0xFFD4E9FF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: padding,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: theme.spacing.cardSpacing,
                    mainAxisSpacing: theme.spacing.cardSpacing,
                  ),
                  itemCount: cardImages.length,
                  itemBuilder: (context, index) {
                    final imagePath = cardImages[index];
                    final isSelected = selectedCard == imagePath;

                    return GestureDetector(
                      onTap: () => _showCardZoom(context, imagePath),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        transform: isSelected
                          ? (Matrix4.identity()..scale(0.95))
                          : Matrix4.identity(),
                        child: Card(
                          elevation: isSelected ? 12 : 6,
                          shadowColor: isSelected
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                              width: isSelected ? 3 : 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_not_supported,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'カード ${index + 1}',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                // ホバー効果
                                if (isSelected)
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.3),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),

                                // カード番号ラベル
                                Positioned(
                                  bottom: 8,
                                  left: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}