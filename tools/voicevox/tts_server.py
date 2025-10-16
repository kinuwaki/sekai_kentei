#!/usr/bin/env python3
"""
VOICEVOX TTS Server with MP3 output
VOICEVOXサーバーからWAVを取得してMP3に変換するTTSサーバー
"""

from fastapi import FastAPI, Response, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import requests
from pydub import AudioSegment
from io import BytesIO
import logging
import sys

# ログ設定
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# FastAPI app
app = FastAPI(title="TTS Cache Server", version="1.0.0")

# CORS設定
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# VOICEVOXサーバーのURL
VOICEVOX_URL = "http://127.0.0.1:50021"

@app.on_event("startup")
async def startup_event():
    """サーバー起動時の処理"""
    logger.info("TTS Server starting...")
    logger.info(f"VOICEVOX URL: {VOICEVOX_URL}")
    
    # VOICEVOXサーバーの確認
    try:
        response = requests.get(f"{VOICEVOX_URL}/version", timeout=3)
        if response.status_code == 200:
            logger.info(f"✅ VOICEVOX server is running")
        else:
            logger.warning("⚠️ VOICEVOX server returned unexpected status")
    except Exception as e:
        logger.error(f"❌ Cannot connect to VOICEVOX server: {e}")
        logger.error("Please make sure VOICEVOX is running")

@app.get("/")
async def root():
    """ルートエンドポイント"""
    return {
        "service": "TTS Cache Server",
        "version": "1.0.0",
        "endpoints": {
            "/tts": "Text-to-Speech endpoint (GET)",
            "/health": "Health check"
        }
    }

@app.get("/health")
async def health_check():
    """ヘルスチェック"""
    try:
        response = requests.get(f"{VOICEVOX_URL}/version", timeout=3)
        voicevox_status = "ok" if response.status_code == 200 else "error"
    except:
        voicevox_status = "offline"
    
    return {
        "status": "ok",
        "voicevox": voicevox_status
    }

@app.get("/tts")
def tts(text: str, speaker: int = 1, speed: float = 1.0, pitch: float = 0.0, intonation: float = 1.0):
    """
    VOICEVOXで音声を生成し、MP3として返すAPI
    :param text: 読み上げテキスト
    :param speaker: 話者ID (デフォルト: 1)
    :param speed: 話速 (1.0が標準)
    :param pitch: ピッチ (0.0が標準)
    :param intonation: 抑揚 (1.0が標準)
    """
    
    if not text:
        raise HTTPException(status_code=400, detail="Text is required")
    
    logger.info(f"TTS request: text='{text}', speaker={speaker}, speed={speed}")
    
    try:
        # 1. 音声クエリを生成
        query_response = requests.post(
            f"{VOICEVOX_URL}/audio_query",
            params={"text": text, "speaker": speaker},
            timeout=10
        )

        if query_response.status_code != 200:
            logger.error(f"Audio query failed: {query_response.status_code}")
            raise HTTPException(status_code=503, detail="VOICEVOX audio_query failed")

        query = query_response.json()

        # クエリ調整
        query["speedScale"] = speed
        query["pitchScale"] = pitch
        query["intonationScale"] = intonation

        # 2. 音声合成 (WAV)
        synthesis_response = requests.post(
            f"{VOICEVOX_URL}/synthesis",
            params={"speaker": speaker},
            json=query,
            timeout=30
        )

        if synthesis_response.status_code != 200:
            logger.error(f"Synthesis failed: {synthesis_response.status_code}")
            raise HTTPException(status_code=503, detail="VOICEVOX synthesis failed")

        wav_data = synthesis_response.content

        # 3. WAV → MP3変換（音量調整付き）
        audio = AudioSegment.from_file(BytesIO(wav_data), format="wav")
        
        # 音量を6dB上げる（約2倍の音量）
        audio = audio + 6
        
        mp3_io = BytesIO()
        audio.export(mp3_io, format="mp3", bitrate="128k")
        
        logger.info(f"Successfully generated MP3: {len(mp3_io.getvalue())} bytes")

        # 4. MP3としてレスポンス返却
        return Response(
            content=mp3_io.getvalue(), 
            media_type="audio/mpeg",
            headers={
                "Content-Disposition": f'inline; filename="speech.mp3"'
            }
        )
        
    except requests.exceptions.ConnectionError:
        logger.error("Cannot connect to VOICEVOX server")
        raise HTTPException(status_code=503, detail="VOICEVOX server not available")
    except requests.exceptions.Timeout:
        logger.error("Request to VOICEVOX timed out")
        raise HTTPException(status_code=504, detail="VOICEVOX server timeout")
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        raise HTTPException(status_code=500, detail=str(e))

def check_dependencies():
    """依存関係の確認"""
    dependencies = []
    
    # ffmpegの確認
    try:
        import subprocess
        result = subprocess.run(["ffmpeg", "-version"], capture_output=True, text=True)
        if result.returncode == 0:
            dependencies.append("✅ ffmpeg is installed")
        else:
            dependencies.append("❌ ffmpeg is not working properly")
    except FileNotFoundError:
        dependencies.append("❌ ffmpeg is not installed (required for MP3 conversion)")
        dependencies.append("  Install: https://ffmpeg.org/download.html")
    
    # pydubの確認
    try:
        import pydub
        dependencies.append("✅ pydub is installed")
    except ImportError:
        dependencies.append("❌ pydub is not installed")
        dependencies.append("  Install: pip install pydub")
    
    # requestsの確認
    try:
        import requests
        dependencies.append("✅ requests is installed")
    except ImportError:
        dependencies.append("❌ requests is not installed")
        dependencies.append("  Install: pip install requests")
    
    # fastapi/uvicornの確認
    try:
        import fastapi
        import uvicorn
        dependencies.append("✅ FastAPI and uvicorn are installed")
    except ImportError:
        dependencies.append("❌ FastAPI or uvicorn is not installed")
        dependencies.append("  Install: pip install fastapi uvicorn")
    
    return dependencies

if __name__ == "__main__":
    import uvicorn
    
    print("=" * 50)
    print("VOICEVOX TTS Server with MP3 output")
    print("=" * 50)
    
    # 依存関係チェック
    print("\nChecking dependencies...")
    deps = check_dependencies()
    for dep in deps:
        print(dep)
    
    # エラーがある場合は警告
    if any("❌" in dep for dep in deps):
        print("\n⚠️  Some dependencies are missing!")
        print("Please install the missing dependencies before running the server.")
        response = input("\nContinue anyway? (y/n): ")
        if response.lower() != 'y':
            sys.exit(1)
    
    print("\n" + "=" * 50)
    print("Starting TTS Server...")
    print(f"Server URL: http://127.0.0.1:8000")
    print(f"VOICEVOX URL: {VOICEVOX_URL}")
    print("=" * 50 + "\n")
    
    # サーバー起動
    uvicorn.run("tts_server:app", host="127.0.0.1", port=8000, log_level="info")