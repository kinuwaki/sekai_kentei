#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
自動音声生成パイプライン
CI/CD統合用の自動化システム
"""

import sys
import io
import subprocess
import time
import json
from pathlib import Path
from typing import Dict, List, Optional
from datetime import datetime

# Windows環境でのUTF-8出力設定
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8')

class AutomatedVoicePipeline:
    """自動音声生成パイプライン"""
    
    def __init__(self, project_root: Path = None):
        if project_root is None:
            project_root = Path(__file__).parent.parent.parent
        
        self.project_root = project_root
        self.tools_dir = project_root / "tools" / "voicevox"
        self.assets_dir = project_root / "flutter_app" / "assets" / "voice"
        self.log_file = self.tools_dir / "pipeline.log"
        
        # 設定
        self.config = {
            'voicevox_url': 'http://127.0.0.1:50021',
            'tts_server_url': 'http://127.0.0.1:8000',
            'max_retry_attempts': 3,
            'retry_delay': 5,
            'server_startup_timeout': 30
        }
    
    def log(self, message: str, level: str = "INFO"):
        """ログ出力"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] [{level}] {message}"
        print(log_entry)
        
        try:
            with open(self.log_file, 'a', encoding='utf-8') as f:
                f.write(log_entry + '\n')
        except Exception:
            pass  # ログファイル書き込み失敗は無視
    
    def check_servers(self) -> Dict[str, bool]:
        """サーバー状態チェック"""
        self.log("🔍 サーバー状態をチェック中...")
        
        status = {
            'voicevox': False,
            'tts_server': False
        }
        
        try:
            import requests
            
            # VoiceVoxチェック
            try:
                response = requests.get(f"{self.config['voicevox_url']}/version", timeout=5)
                status['voicevox'] = response.status_code == 200
            except:
                pass
            
            # TTSサーバーチェック
            try:
                response = requests.get(f"{self.config['tts_server_url']}/health", timeout=5)
                status['tts_server'] = response.status_code == 200
            except:
                pass
                
        except ImportError:
            self.log("❌ requests モジュールが見つかりません", "ERROR")
        
        self.log(f"  VoiceVox: {'✅' if status['voicevox'] else '❌'}")
        self.log(f"  TTS Server: {'✅' if status['tts_server'] else '❌'}")
        
        return status
    
    def start_servers(self) -> bool:
        """サーバーを自動起動"""
        self.log("🚀 サーバーを起動中...")
        
        try:
            # TTSサーバー起動スクリプトを実行
            startup_script = self.tools_dir / "start_voicevox_server.bat"
            if startup_script.exists():
                self.log(f"  実行中: {startup_script}")
                subprocess.Popen([str(startup_script)], cwd=str(self.tools_dir))
                
                # 起動待機
                self.log(f"  サーバー起動を待機中... ({self.config['server_startup_timeout']}秒)")
                for i in range(self.config['server_startup_timeout']):
                    time.sleep(1)
                    status = self.check_servers()
                    if status['voicevox'] and status['tts_server']:
                        self.log("✅ サーバー起動完了")
                        return True
                
                self.log("⚠️ サーバー起動がタイムアウトしました", "WARNING")
                return False
            else:
                self.log(f"❌ 起動スクリプトが見つかりません: {startup_script}", "ERROR")
                return False
                
        except Exception as e:
            self.log(f"❌ サーバー起動エラー: {e}", "ERROR")
            return False
    
    def analyze_missing_files(self) -> Dict:
        """不足ファイルの分析"""
        self.log("📋 不足ファイルを分析中...")
        
        try:
            # generate_voice_assets.pyで不足ファイルをチェック
            cmd = [sys.executable, "generate_voice_assets.py", "--json"]
            result = subprocess.run(
                cmd,
                cwd=str(self.tools_dir),
                capture_output=True,
                text=True,
                timeout=30,
                encoding='utf-8'
            )
            
            if result.returncode == 0:
                # 出力からJSON部分を抽出
                output_lines = result.stdout.split('\n')
                json_start = -1
                for i, line in enumerate(output_lines):
                    if line.strip().startswith('['):
                        json_start = i
                        break
                
                if json_start >= 0:
                    json_text = '\n'.join(output_lines[json_start:])
                    json_text = json_text.strip()
                    if json_text:
                        missing_files = json.loads(json_text)
                        self.log(f"  不足ファイル: {len(missing_files)} 個")
                        return {'missing_files': missing_files, 'count': len(missing_files)}
                
                self.log("✅ すべてのファイルが存在します")
                return {'missing_files': [], 'count': 0}
            else:
                self.log(f"❌ ファイルチェックでエラー: {result.stderr}", "ERROR")
                return {'missing_files': [], 'count': 0, 'error': result.stderr}
                
        except Exception as e:
            self.log(f"❌ ファイル分析エラー: {e}", "ERROR")
            return {'missing_files': [], 'count': 0, 'error': str(e)}
    
    def generate_voice_files(self) -> bool:
        """音声ファイル生成"""
        self.log("🎤 音声ファイルを生成中...")
        
        for attempt in range(self.config['max_retry_attempts']):
            try:
                self.log(f"  試行 {attempt + 1}/{self.config['max_retry_attempts']}")
                
                cmd = [sys.executable, "generate_voice_assets.py", "--overwrite"]
                result = subprocess.run(
                    cmd,
                    cwd=str(self.tools_dir),
                    capture_output=True,
                    text=True,
                    timeout=300,  # 5分
                    encoding='utf-8'
                )
                
                if result.returncode == 0:
                    self.log("✅ 音声ファイル生成完了")
                    return True
                else:
                    self.log(f"❌ 音声生成エラー (試行 {attempt + 1}): {result.stderr}", "ERROR")
                    if attempt < self.config['max_retry_attempts'] - 1:
                        self.log(f"  {self.config['retry_delay']}秒後にリトライ...")
                        time.sleep(self.config['retry_delay'])
                    
            except subprocess.TimeoutExpired:
                self.log(f"⏰ 音声生成がタイムアウト (試行 {attempt + 1})", "ERROR")
            except Exception as e:
                self.log(f"❌ 音声生成で予期しないエラー (試行 {attempt + 1}): {e}", "ERROR")
        
        return False
    
    def run_full_pipeline(self) -> bool:
        """完全パイプラインの実行"""
        self.log("=" * 60)
        self.log("🚀 自動音声生成パイプライン開始")
        self.log("=" * 60)
        
        pipeline_success = True
        
        # 1. サーバー状態チェック
        status = self.check_servers()
        if not (status['voicevox'] and status['tts_server']):
            self.log("⚠️ サーバーが起動していません。自動起動を試行...")
            if not self.start_servers():
                self.log("❌ サーバー起動に失敗。手動でサーバーを起動してください。", "ERROR")
                pipeline_success = False
        
        # 2. 不足ファイル分析
        if pipeline_success:
            missing_analysis = self.analyze_missing_files()
            if missing_analysis['count'] == 0:
                self.log("✅ すべての音声ファイルが存在します。生成をスキップします。")
            else:
                # 3. 音声ファイル生成
                if not self.generate_voice_files():
                    self.log("❌ 音声ファイル生成に失敗", "ERROR")
                    pipeline_success = False
        
        # 4. 最終検証
        if pipeline_success:
            final_check = self.analyze_missing_files()
            if final_check['count'] == 0:
                self.log("✅ パイプライン完了: すべての音声ファイルが生成されました")
            else:
                self.log(f"⚠️ パイプライン完了: {final_check['count']} 個のファイルが不足しています", "WARNING")
                pipeline_success = False
        
        self.log("=" * 60)
        self.log(f"🏁 パイプライン結果: {'成功' if pipeline_success else '失敗'}")
        self.log("=" * 60)
        
        return pipeline_success
    
    def create_github_actions_workflow(self) -> str:
        """GitHub Actions ワークフロー生成"""
        workflow = """name: 自動音声ファイル生成

on:
  push:
    paths:
      - 'flutter_app/lib/ui/games/**/*.dart'
      - 'tools/voicevox/**/*.py'
  workflow_dispatch:

jobs:
  generate-voice-files:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install Python dependencies
      run: |
        pip install requests pydub pyyaml fastapi uvicorn
    
    - name: Setup VoiceVox
      run: |
        # VoiceVox のセットアップ（実際の環境に合わせて調整）
        echo "VoiceVox setup would go here"
    
    - name: Run voice generation pipeline
      run: |
        cd tools/voicevox
        python automated_voice_pipeline.py
    
    - name: Commit generated files
      run: |
        git config --local user.email "action@github.com"
        git config --local user.name "GitHub Action"
        git add flutter_app/assets/voice/
        git diff --staged --quiet || git commit -m "Auto-generated voice files 🔊"
        git push
"""
        return workflow

def main():
    """メイン関数"""
    pipeline = AutomatedVoicePipeline()
    
    if len(sys.argv) > 1:
        command = sys.argv[1].lower()
        
        if command == 'check':
            pipeline.check_servers()
        elif command == 'analyze':
            result = pipeline.analyze_missing_files()
            print(json.dumps(result, ensure_ascii=False, indent=2))
        elif command == 'generate':
            success = pipeline.generate_voice_files()
            sys.exit(0 if success else 1)
        elif command == 'workflow':
            workflow = pipeline.create_github_actions_workflow()
            workflow_path = pipeline.project_root / '.github' / 'workflows' / 'voice-generation.yml'
            workflow_path.parent.mkdir(parents=True, exist_ok=True)
            workflow_path.write_text(workflow, encoding='utf-8')
            print(f"✅ GitHub Actions ワークフロー作成: {workflow_path}")
        else:
            print("使用法: python automated_voice_pipeline.py [check|analyze|generate|workflow]")
    else:
        # フルパイプライン実行
        success = pipeline.run_full_pipeline()
        sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()