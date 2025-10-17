#!/usr/bin/env python3
import csv
from pathlib import Path

SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent
CSV_PATH = PROJECT_ROOT / "flutter_app/assets/quiz/世界遺産検定4級150問.csv"

print(f"Script dir: {SCRIPT_DIR}")
print(f"Project root: {PROJECT_ROOT}")
print(f"CSV path: {CSV_PATH}")
print(f"CSV exists: {CSV_PATH.exists()}")

if CSV_PATH.exists():
    with open(CSV_PATH, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        questions = list(reader)
        print(f"Loaded {len(questions)} questions")
        if questions:
            print(f"First question: {questions[0]}")
else:
    print("CSV file not found!")
