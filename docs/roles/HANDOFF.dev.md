# Dev Handoff — Anima App

Этот файл — контекст для нового дев-чата. Прочитай его полностью перед началом работы.

## Кто я
Claude Code в VS Code. Работаю как дев-ассистент на проекте Anima.
Пишу код, не принимаю продуктовых решений.
Требования беру из `docs/product/features/`.

## Что такое Anima
Мобильное приложение (iOS + Android) для ухода за питомцами.
Один аккаунт — много питомцев любых видов и пород.
Фичи: календарь событий, фотогалерея, трекинг роста, курсы обучения.
Бесплатное приложение, монетизации нет.

## Стек
- Flutter (Dart) — мобильный клиент
- Supabase (PostgreSQL) — бэкенд, запущен локально через Docker
- Supabase Auth — аутентификация
- go_router — навигация
- flutter_riverpod — state management
- google_sign_in — Google OAuth на Android
- sign_in_with_apple — Apple OAuth на iOS (пока не настроен)

## Где что лежит
```
Anima/
  mobile/                        — Flutter проект
    lib/
      main.dart                  — точка входа, Supabase init, router
      core/
        theme/app_theme.dart     — цвета, тема (AppColors, AppTheme)
        router/app_router.dart   — go_router + auth guard
      features/
        auth/
          data/auth_repository.dart        — все методы авторизации
          presentation/pages/login_page.dart
          presentation/pages/register_page.dart
          presentation/widgets/social_button.dart
    assets/icons/                — google.svg, apple.svg
    android/app/
      google-services.json       — Firebase config (dev.anima.app)
      build.gradle.kts           — applicationId = dev.anima.app
  supabase/
    config.toml                  — Google OAuth настроен (skip_nonce_check = true)
    migrations/
      20260626000001_init.sql    — все таблицы с RLS
  docs/
    architecture/schema.md       — схема БД
    architecture/design-reference.md — цвета из Figma
    product/features/            — требования к фичам (читай перед имплементацией)
    DOR.md                       — чеклист готовности фичи
```

## Что уже сделано
- [x] Dev environment: Flutter, Android Studio, WSL2, Docker, Supabase CLI
- [x] Android эмулятор Pixel 8 API 37
- [x] Supabase локально запущен на порту 54321
- [x] БД: миграция с 7 таблицами (profiles, pets, events, photos, measurements, courses, course_progress)
- [x] Тема приложения (AppColors, AppTheme) на базе дизайна Figma
- [x] Auth feature: email/password + Google Sign-In (Android)
- [x] go_router с auth guard (редирект на /login если не залогинен)
- [x] Firebase проект "Anima" (anima-5ec5d), Google Sign-In включён
- [x] Google Sign-In работает на эмуляторе

## Что делать дальше
1. Pets feature — список питомцев, добавить питомца, карточка питомца
2. Home screen — дашборд после логина
3. Apple Sign-In (нужен Apple Developer аккаунт)
4. Codemagic CI для iOS сборки

## Ключевые договорённости
- Пакет приложения: `dev.anima.app`
- Supabase URL на эмуляторе: `http://10.0.2.2:54321` (не 127.0.0.1!)
- Файлы без BOM: всегда использовать `[System.Text.UTF8Encoding]::new($false)`
- Комментарии в коде не пишем без необходимости
- Em dash (—) и en dash (–) запрещены везде
- Коммиты без Co-Authored-By Claude

## Локальные credentials (не коммитить)
- Supabase publishable key: `sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH`
- Firebase project: `anima-5ec5d`
- Google OAuth client ID: `447942549828-bbl7nick2100kdsfh5fou1d6capeq43r.apps.googleusercontent.com`
- Google OAuth server client ID в auth_repository.dart уже прописан