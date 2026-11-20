# 호타이쿤 런처 배포 파일

호타이쿤 런처(Helios 기반)가 내려받는 distribution.json 과 모드·라이브러리 파일입니다.

## 기본 모드 (servers/hobaektycoon-26.2/fabricmods/required)

| 모드 | 버전 |
|---|---|
| Fabric API | 0.156.0+26.2 |
| Fabric Language Kotlin | 1.13.14 |
| 호타이쿤 클라이언트 · 광장 | 1.0.0 |
| Plasmo Voice | 2.2.0-beta.4 (26.2 는 베타만 있음) |
| JourneyMap | 6.0.10 |
| Sodium | 0.9.2 |
| Iris Shaders | 1.11.4 |
| Hangul 한글 (한글 입력) | 1.3.0-beta.12 |

## 모드 바꾸기 → 기존 설치자 자동 반영

1. `servers/hobaektycoon-26.2/fabricmods/required/` 에 jar 를 넣거나 빼거나 교체
2. `powershell -ExecutionPolicy Bypass -File update-mods.ps1 "메모"`
   (Nebula 로 `distribution.json` 재생성 → 커밋 → push)

런처는 실행할 때마다 `distribution.json` 을 받아 파일 해시를 비교하므로, 이미 설치한 사람도
다음 실행 때 바뀐 파일만 받습니다. raw.githubusercontent.com 캐시 때문에 반영까지 최대 5분.
