import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/landscape_home.dart';
import '../components/system_header.dart';
import '../../services/user_data_manager.dart';

/// ユーザー登録の各ステップ
enum RegistrationStep {
  input,     // 名前・年齢入力
  confirm,   // 確認画面
}

/// ユーザー情報モデル
class UserInfo {
  final String name;
  final int ageYears;
  final int ageMonths;

  const UserInfo({
    required this.name,
    required this.ageYears,
    required this.ageMonths,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'ageYears': ageYears,
    'ageMonths': ageMonths,
  };

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    name: json['name'] as String,
    ageYears: json['ageYears'] as int,
    ageMonths: json['ageMonths'] as int,
  );
}

/// ユーザー登録状態プロバイダー
final userRegistrationProvider = StateNotifierProvider<UserRegistrationNotifier, UserRegistrationState>((ref) {
  return UserRegistrationNotifier();
});

class UserRegistrationState {
  final RegistrationStep currentStep;
  final String name;
  final int ageYears;
  final int ageMonths;
  final bool isLoading;

  const UserRegistrationState({
    this.currentStep = RegistrationStep.input,
    this.name = '',
    this.ageYears = 4,
    this.ageMonths = 0,
    this.isLoading = false,
  });

  UserRegistrationState copyWith({
    RegistrationStep? currentStep,
    String? name,
    int? ageYears,
    int? ageMonths,
    bool? isLoading,
  }) {
    return UserRegistrationState(
      currentStep: currentStep ?? this.currentStep,
      name: name ?? this.name,
      ageYears: ageYears ?? this.ageYears,
      ageMonths: ageMonths ?? this.ageMonths,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  UserInfo get userInfo => UserInfo(
    name: name,
    ageYears: ageYears,
    ageMonths: ageMonths,
  );
}

class UserRegistrationNotifier extends StateNotifier<UserRegistrationState> {
  UserRegistrationNotifier() : super(const UserRegistrationState());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateAge(int years, int months) {
    state = state.copyWith(ageYears: years, ageMonths: months);
  }

  void nextStep() {
    final currentStep = state.currentStep;
    switch (currentStep) {
      case RegistrationStep.input:
        if (state.name.isNotEmpty) {
          state = state.copyWith(currentStep: RegistrationStep.confirm);
        }
        break;
      case RegistrationStep.confirm:
        // 登録完了は UserRegistrationScreen で処理
        break;
    }
  }

  void previousStep() {
    final currentStep = state.currentStep;
    switch (currentStep) {
      case RegistrationStep.input:
        // 最初のステップなので戻れない
        break;
      case RegistrationStep.confirm:
        state = state.copyWith(currentStep: RegistrationStep.input);
        break;
    }
  }

  Future<void> saveUserInfo() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userInfo = state.userInfo;

      // ユーザー情報を保存
      await prefs.setString('user_name', userInfo.name);
      await prefs.setInt('user_age_years', userInfo.ageYears);
      await prefs.setInt('user_age_months', userInfo.ageMonths);
      await prefs.setBool('is_first_launch', false);

    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

/// 初回起動チェック関数
Future<bool> isFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_first_launch') ?? true;
}

/// ユーザー登録画面
class UserRegistrationScreen extends ConsumerWidget {
  const UserRegistrationScreen({super.key});

  /// ステップに対応するメッセージを取得
  String _getStepMessage(RegistrationStep step) {
    switch (step) {
      case RegistrationStep.input:
        return 'こどものことを おしえてね';
      case RegistrationStep.confirm:
        return 'これで いいですか？';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userRegistrationProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false, // キーボードで画面が縮むのを防ぐ
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu/background_c.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // システムヘッダー
                SystemHeader(
                  title: 'はじめてせってい',
                  messageText: _getStepMessage(state.currentStep),
                  progressText: '${state.currentStep.index + 1}/2',
                ),

                // メインコンテンツ
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                // ステップコンテンツ
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight * 0.6,
                                  ),
                                  child: _buildCurrentStep(context, ref, state),
                                ),

                                const SizedBox(height: 8),

                                // ナビゲーションボタン
                                _buildNavigationButtons(context, ref, state),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCurrentStep(BuildContext context, WidgetRef ref, UserRegistrationState state) {
    switch (state.currentStep) {
      case RegistrationStep.input:
        return _CombinedInputStep(
          initialName: state.name,
          initialYears: state.ageYears,
          initialMonths: state.ageMonths,
          onNameChanged: (name) => ref.read(userRegistrationProvider.notifier).updateName(name),
          onAgeChanged: (years, months) => ref.read(userRegistrationProvider.notifier).updateAge(years, months),
        );
      case RegistrationStep.confirm:
        return _ConfirmationStep(userInfo: state.userInfo);
    }
  }

  Widget _buildNavigationButtons(BuildContext context, WidgetRef ref, UserRegistrationState state) {
    final notifier = ref.read(userRegistrationProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 戻るボタン（確認画面のみ表示）
        if (state.currentStep != RegistrationStep.input) ...[
          SizedBox(
            width: 100,
            child: OutlinedButton(
              onPressed: state.isLoading ? null : notifier.previousStep,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.blue),
              ),
              child: const Text('もどる', style: TextStyle(fontSize: 16)),
            ),
          ),
          const SizedBox(width: 16),
        ],

        // 次へ/完了ボタン（中央配置）
        SizedBox(
          width: 120,
          child: ElevatedButton(
            onPressed: state.isLoading ? null : () => _handleNextButton(context, ref, state),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: state.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
              : Text(
                  state.currentStep == RegistrationStep.confirm ? 'かんりょう！' : 'つぎへ',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
          ),
        ),
      ],
    );
  }

  void _handleNextButton(BuildContext context, WidgetRef ref, UserRegistrationState state) async {
    final notifier = ref.read(userRegistrationProvider.notifier);

    if (state.currentStep == RegistrationStep.confirm) {
      // 登録完了処理
      await notifier.saveUserInfo();

      // UserDataManagerで初期設定完了を記録
      final userDataManager = UserDataManager();
      await userDataManager.completeInitialSetup(
        userName: state.name,
        settings: userDataManager.settings.copyWith(
          // 年齢に応じた設定の調整なども可能
        ),
      );

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeLandscape()),
        );
      }
    } else {
      // 次のステップに進む
      notifier.nextStep();
    }
  }
}

/// 名前・年齢統合入力ステップ
class _CombinedInputStep extends StatefulWidget {
  final String initialName;
  final int initialYears;
  final int initialMonths;
  final ValueChanged<String> onNameChanged;
  final Function(int years, int months) onAgeChanged;

  const _CombinedInputStep({
    required this.initialName,
    required this.initialYears,
    required this.initialMonths,
    required this.onNameChanged,
    required this.onAgeChanged,
  });

  @override
  State<_CombinedInputStep> createState() => _CombinedInputStepState();
}

class _CombinedInputStepState extends State<_CombinedInputStep> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
        // 名前入力セクション（画面の半分）
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '（おなまえ）',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade200, width: 2),
                  ),
                  child: TextField(
                    controller: _nameController,
                    onChanged: widget.onNameChanged,
                    style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'ここにかいてね',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 21),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 年齢入力セクション（画面の半分）
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.withOpacity(0.3), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '（ねんれい）',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 年選択
                    _buildAgeSelector(
                      label: 'さい',
                      value: widget.initialYears,
                      min: 2,
                      max: 8,
                      onChanged: (years) => widget.onAgeChanged(years, widget.initialMonths),
                      color: Colors.orange,
                    ),
                    // 月選択
                    _buildAgeSelector(
                      label: 'かげつ',
                      value: widget.initialMonths,
                      min: 0,
                      max: 11,
                      onChanged: (months) => widget.onAgeChanged(widget.initialYears, months),
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildAgeSelector({
    required String label,
    required int value,
    required int min,
    required int max,
    required ValueChanged<int> onChanged,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 数値とラベルを縦配置
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 横並びボタン
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // マイナスボタン
              GestureDetector(
                onTap: value > min ? () => onChanged(value - 1) : null,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: value > min ? color : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove, color: Colors.white, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              // プラスボタン
              GestureDetector(
                onTap: value < max ? () => onChanged(value + 1) : null,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: value < max ? color : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/// 確認ステップ
class _ConfirmationStep extends StatelessWidget {
  final UserInfo userInfo;

  const _ConfirmationStep({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 名前確認（青色ボックス）
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.withOpacity(0.3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '（おなまえ）',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.shade200, width: 2),
                    ),
                    child: Text(
                      userInfo.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 年齢確認（橙色ボックス）
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withOpacity(0.3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '（ねんれい）',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.orange.shade200, width: 2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${userInfo.ageYears}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'さい',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        if (userInfo.ageMonths > 0) ...[
                          const SizedBox(height: 4),
                          Text(
                            '${userInfo.ageMonths} かげつ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}