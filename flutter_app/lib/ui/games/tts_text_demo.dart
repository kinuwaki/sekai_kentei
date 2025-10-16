/// TTSテキスト抽出システムのデモ・テスト実行用ファイル
/// 
/// このファイルは以下の用途で使用します：
/// 1. システムの動作確認とテスト
/// 2. 実際のTTSテキスト生成のデモンストレーション
/// 3. 開発時のデバッグとトラブルシューティング

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'game_tts_text_generator.dart';
import 'advanced_tts_analyzer.dart';
import 'tts_text_extractor.dart';

/// TTSテキスト抽出システムのデモウィジェット
class TTSTextExtractionDemo extends StatefulWidget {
  const TTSTextExtractionDemo({super.key});

  @override
  State<TTSTextExtractionDemo> createState() => _TTSTextExtractionDemoState();
}

class _TTSTextExtractionDemoState extends State<TTSTextExtractionDemo> {
  GeneratedTTSData? _generatedData;
  bool _isLoading = false;
  String _selectedGameType = 'All';
  final List<String> _availableGameTypes = [
    'All',
    'NumberRecognition',
    'Counting',
    'Comparison',
    'SizeComparison',
    'OddEven',
    'ShapeMatching',
    'FigureOrientation',
    'Puzzle',
    'Writing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TTS テキスト抽出デモ'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildControlPanel(),
            const SizedBox(height: 20),
            if (_isLoading) 
              const Center(child: CircularProgressIndicator())
            else if (_generatedData != null)
              Expanded(child: _buildResultsView())
            else
              const Center(
                child: Text(
                  'ゲームタイプを選択して「生成開始」ボタンを押してください',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TTS テキスト抽出設定',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('ゲームタイプ: '),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedGameType,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGameType = newValue!;
                    });
                  },
                  items: _availableGameTypes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == 'All' ? '全ゲーム' : value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _generateTexts,
                  child: const Text('生成開始'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _isLoading ? null : _exportTexts,
                  child: const Text('エクスポート'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _runFullAnalysis,
                  child: const Text('完全解析実行'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsView() {
    if (_generatedData == null) return const SizedBox.shrink();

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: '統計'),
              Tab(text: '全テキスト'),
              Tab(text: 'ゲーム別'),
              Tab(text: '使用頻度'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildStatisticsTab(),
                _buildAllTextsTab(),
                _buildGameSpecificTab(),
                _buildFrequencyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    final metadata = _generatedData!.metadata;
    final statistics = metadata['statistics'] as Map<String, dynamic>?;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('抽出統計', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildStatItem('総テキスト数', '${_generatedData!.allTexts.length} 件'),
          _buildStatItem('ゲーム数', '${_generatedData!.gameSpecificTexts.keys.length} ゲーム'),
          _buildStatItem('生成日時', metadata['generation_timestamp'] ?? 'N/A'),
          if (statistics != null) ...[
            _buildStatItem('ユニークテキスト数', '${statistics['total_unique_texts']} 件'),
            _buildStatItem('解析ゲーム数', '${statistics['games_analyzed']} ゲーム'),
          ],
          const SizedBox(height: 20),
          const Text('ゲーム別内訳', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ..._generatedData!.gameSpecificTexts.entries.map((entry) => 
            _buildStatItem(entry.key, '${entry.value.length} 件')
          ),
        ],
      ),
    );
  }

  Widget _buildAllTextsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _generatedData!.allTexts.length,
      itemBuilder: (context, index) {
        final text = _generatedData!.allTexts[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 4.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
            title: Text(text),
            onTap: () => _showTextDetail(text),
          ),
        );
      },
    );
  }

  Widget _buildGameSpecificTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: _generatedData!.gameSpecificTexts.entries.map((entry) {
        return ExpansionTile(
          title: Text('${entry.key} (${entry.value.length}件)'),
          children: entry.value.map((text) => ListTile(
            title: Text(text),
            dense: true,
            onTap: () => _showTextDetail(text),
          )).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildFrequencyTab() {
    final frequencies = _generatedData!.textFrequency;
    if (frequencies.isEmpty) {
      return const Center(child: Text('使用頻度データがありません'));
    }

    final sortedEntries = frequencies.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: sortedEntries.length,
      itemBuilder: (context, index) {
        final entry = sortedEntries[index];
        if (entry.value <= 1) return const SizedBox.shrink();
        
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: entry.value > 2 ? Colors.red : Colors.orange,
              child: Text('${entry.value}'),
            ),
            title: Text(entry.key),
            subtitle: Text('${entry.value}回使用'),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showTextDetail(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('テキスト詳細'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('テキスト: $text'),
            const SizedBox(height: 10),
            Text('文字数: ${text.length}文字'),
            Text('使用頻度: ${_generatedData!.textFrequency[text] ?? 1}回'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  Future<void> _generateTexts() async {
    setState(() {
      _isLoading = true;
      _generatedData = null;
    });

    try {
      final GeneratedTTSData data;
      
      if (_selectedGameType == 'All') {
        data = await GameTTSTextGenerator.generateAllTTSTexts(
          options: const TTSGenerationOptions(
            includeFrequency: true,
          ),
        );
      } else {
        data = await GameTTSTextGenerator.generateGameTTSTexts(
          _selectedGameType,
          options: const TTSGenerationOptions(
            includeFrequency: true,
          ),
        );
      }

      setState(() {
        _generatedData = data;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data.allTexts.length}件のTTSテキストを生成しました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Text generation error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _exportTexts() async {
    if (_generatedData == null) return;

    try {
      await GameTTSTextGenerator.exportTTSTexts(
        _generatedData!,
        basePath: 'game_tts_export',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('TTSテキストをエクスポートしました'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      debugPrint('Export error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エクスポートエラー: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _runFullAnalysis() {
    // フルシステム解析のデモ実行
    _showAnalysisDialog();
  }

  void _showAnalysisDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('完全解析実行'),
        content: const Text('システムの完全解析を実行します。\n'
            'この処理により、全ゲームのTTSテキストパターンが解析され、\n'
            '包括的なレポートが生成されます。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _executeFullAnalysis();
            },
            child: const Text('実行'),
          ),
        ],
      ),
    );
  }

  Future<void> _executeFullAnalysis() async {
    try {
      // 基本解析
      final basicResult = GameTTSTextExtractor.extractAllTTSTexts();
      
      // 高度解析
      final advancedResult = AdvancedTTSTextAnalyzer.performAdvancedAnalysis();
      
      // 統合データ生成
      final generatedData = await GameTTSTextGenerator.generateAllTTSTexts(
        options: const TTSGenerationOptions(includeFrequency: true),
      );
      
      // 結果レポート表示
      _showAnalysisReport(basicResult, advancedResult, generatedData);
      
    } catch (e) {
      debugPrint('Full analysis error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('完全解析エラー: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAnalysisReport(
    TTSExtractionResult basicResult,
    AdvancedTTSAnalysisResult advancedResult,
    GeneratedTTSData generatedData,
  ) {
    final report = '''
=== 完全解析レポート ===

【基本解析結果】
• 静的テキスト: ${basicResult.staticTexts.length}件
• 動的テキスト: ${basicResult.dynamicTexts.length}件
• ユニークテキスト: ${basicResult.uniqueTexts.length}件

【高度解析結果】
• 総テキスト: ${advancedResult.allPossibleTexts.length}件
• テキスト生成パターン: ${advancedResult.textGenerationPatterns.keys.length}種類

【統合結果】
• 最終テキスト数: ${generatedData.allTexts.length}件
• 対象ゲーム数: ${generatedData.gameSpecificTexts.keys.length}ゲーム
• 重複テキスト: ${generatedData.textFrequency.values.where((v) => v > 1).length}件

このシステムにより、Flutter アプリ内で実際に使用される
全ての音声テキストを動的に抽出・管理することができます。
    ''';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('解析レポート'),
        content: SingleChildScrollView(
          child: Text(report, style: const TextStyle(fontFamily: 'monospace')),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}