# SYSTEM_DESIGN_SIMAK_UNIVERSITY_PART_01.md

> Version : 1.0.0
>
> Project : SIMAK Mobile Universitas
>
> Frontend : Flutter
>
> Architecture : Clean Architecture + BLoC
>
> Status : Production Ready
>
> Target : Android & iOS
>
> Last Update : July 2026

---

# 1. Introduction

## 1.1 Overview

SIMAK Mobile merupakan aplikasi akademik resmi universitas yang digunakan oleh seluruh civitas akademika untuk mengakses layanan akademik secara mobile.

Aplikasi ini dibangun menggunakan **Flutter** dengan pendekatan **Clean Architecture**, **BLoC Pattern**, **Repository Pattern**, serta menerapkan prinsip-prinsip **SOLID**, **DRY**, **KISS**, dan **Separation of Concerns** agar mudah dikembangkan, mudah diuji, scalable, dan siap digunakan dalam jangka panjang.

Dokumen ini menjadi **single source of truth** bagi seluruh developer frontend maupun backend sehingga seluruh implementasi mengikuti standar yang sama.

---

# 2. Goals

Tujuan utama aplikasi ini adalah:

- Mempermudah akses informasi akademik.
- Menyediakan aplikasi yang cepat, ringan, dan stabil.
- Memiliki UI modern dan konsisten.
- Mudah dikembangkan untuk fitur baru.
- Mendukung banyak role pengguna.
- Mudah dipelihara oleh developer baru.
- Memiliki standar coding yang konsisten.
- Production Ready.
- Enterprise Ready.

---

# 3. Supported Roles

Saat ini sistem mendukung role berikut.

## Mahasiswa

- Login
- Dashboard
- Jadwal Kuliah
- Kalender Akademik
- KRS
- Nilai
- IP
- IPK
- Riwayat Semester
- Tagihan
- Pembayaran
- Pengajuan Cuti
- Informasi Akademik
- Notifikasi
- Profile

---

## Dosen

- Login
- Dashboard
- Jadwal Mengajar
- Daftar Mahasiswa
- Input Nilai
- Input Absensi
- Kalender Akademik
- Informasi
- Notifikasi
- Profile

---

## Future Role

Arsitektur harus mudah mendukung role baru tanpa mengubah struktur project.

Contoh:

- Admin
- Staff Akademik
- Keuangan
- Orang Tua
- Alumni

---

# 4. Non Functional Requirement

Aplikasi wajib memenuhi standar berikut.

## Performance

- Startup < 3 detik
- Scroll 60 FPS
- Tidak ada UI Freeze
- Tidak ada Memory Leak
- Image Cache
- Lazy Loading
- Pagination
- Infinite Scroll

---

## Security

- JWT
- Refresh Token
- Flutter Secure Storage
- SSL Ready
- Root Detection (Optional)
- Jailbreak Detection (Optional)
- Session Timeout
- Auto Logout

---

## Scalability

Project harus mampu berkembang hingga:

- 100+ fitur
- 1000+ halaman
- 50+ developer

tanpa mengubah arsitektur utama.

---

## Maintainability

Seluruh fitur wajib:

- mudah dipahami
- mudah di-test
- mudah diperbaiki
- reusable

---

# 5. Technology Stack

| Category | Technology |
|------------|------------|
| Framework | Flutter Latest Stable |
| Language | Dart |
| State Management | flutter_bloc |
| Router | go_router |
| Networking | Dio |
| Dependency Injection | get_it |
| Local Storage | SharedPreferences |
| Secure Storage | Flutter Secure Storage |
| JSON | json_serializable |
| Model | freezed (opsional) |
| Logging | logger |
| Environment | flutter_dotenv |
| Notification | OneSignal |
| Image | cached_network_image |
| Animation | flutter_animate + Lottie |
| Skeleton | shimmer |
| Connectivity | connectivity_plus |
| Internet Checker | internet_connection_checker_plus |
| Permission | permission_handler |
| Localization | easy_localization |
| Device Info | device_info_plus |
| Package Info | package_info_plus |
| URL Launcher | url_launcher |
| Share | share_plus |
| Biometrics | local_auth |

---

# 6. Project Principles

Seluruh developer WAJIB mengikuti prinsip berikut.

## SOLID

Seluruh class memiliki satu tanggung jawab.

---

## DRY

Tidak boleh ada kode yang berulang.

Semua harus reusable.

---

## KISS

Implementasi sederhana lebih baik dibanding rumit.

---

## Clean Architecture

UI tidak boleh mengetahui API.

Bloc tidak boleh mengetahui Dio.

UseCase tidak boleh mengetahui Flutter.

Repository tidak boleh mengetahui Widget.

---

## Separation of Concerns

Setiap layer hanya mengurus pekerjaannya masing-masing.

---

# 7. Application Architecture

```
Presentation

↓

Bloc

↓

Use Case

↓

Repository

↓

Repository Implementation

↓

Remote Data Source
        │
        │
Local Data Source

↓

REST API
```

---

# 8. Feature First Structure

Project menggunakan Feature First.

```
lib/

core/

shared/

features/

main.dart
```

---

# 9. Folder Structure

```
lib/

core/

shared/

features/

main.dart
```

---

## Core

Core berisi komponen global.

```
core/

config/

constants/

env/

theme/

router/

di/

network/

storage/

utils/

extensions/

services/

base/

error/

helper/

language/

validators/

```

Tidak boleh ada business logic.

---

## Shared

Shared berisi reusable widget.

```
shared/

widgets/

components/

dialogs/

cards/

buttons/

textfields/

dropdown/

loading/

shimmer/

empty/

error/

bottomsheet/

appbar/

menu/

forms/

```

---

## Features

```
features/

authentication/

dashboard/

profile/

notification/

billing/

schedule/

calendar/

grade/

krs/

student/

lecturer/

attendance/

leave/

news/

settings/

```

---

# 10. Feature Standard

Setiap feature WAJIB mengikuti struktur berikut.

```
feature/

data/

domain/

presentation/

```

---

## Data

```
data/

datasource/

repository/

models/

dto/

mapper/

```

---

## Domain

```
domain/

entities/

repositories/

usecases/

```

---

## Presentation

```
presentation/

pages/

bloc/

widgets/

controllers/

```

---

# 11. Naming Convention

Repository

```
StudentRepository
```

Repository Implementation

```
StudentRepositoryImpl
```

Use Case

```
GetStudentProfileUseCase
```

Bloc

```
StudentBloc
```

State

```
StudentState
```

Event

```
StudentEvent
```

Page

```
StudentProfilePage
```

Widget

```
StudentCard
```

Model

```
StudentModel
```

Entity

```
StudentEntity
```

---

# 12. Routing

Menggunakan:

```
go_router
```

Alasan:

- Official Recommendation
- Authentication Redirect
- Nested Navigation
- Deep Link
- Web Support
- ShellRoute
- Stateful Navigation
- Mudah dikembangkan

---

# 13. Route Structure

```
/

splash

portal

login

forgot-password

dashboard

profile

notification

settings

about

contact-us

billing

payment

schedule

calendar

krs

grade

leave

news

```

Semua route menggunakan named route.

Contoh:

```
RouteName.dashboard
```

Bukan string literal.

---

# 14. Authentication Flow

```
App Start

↓

Splash

↓

Check Internet

↓

Check Maintenance

↓

Check Version

↓

Check Token

↓

Portal

↓

Login

↓

Dashboard
```

---

# 15. Portal Page

Portal merupakan halaman pertama yang muncul setelah splash jika pengguna belum login.

## Komponen

- Logo Universitas
- Lottie Animation
- Nama Aplikasi
- Versi Aplikasi
- Login Mahasiswa
- Login Dosen
- Tentang
- Kontak
- Kebijakan Privasi

Portal tidak memerlukan autentikasi.

---

# 16. Splash Screen

Splash screen dibuat terpisah agar mudah dikustomisasi.

## Komponen

- Lottie Logo
- Logo Universitas
- Loading Indicator
- Progress Text
- App Version
- Build Number

## Flow

```
Open App

↓

Load Theme

↓

Load Localization

↓

Load Environment

↓

Initialize Dependency Injection

↓

Initialize Logger

↓

Initialize Local Storage

↓

Initialize Secure Storage

↓

Initialize OneSignal

↓

Initialize Connectivity Listener

↓

Check Internet

↓

Check Maintenance

↓

Check Version

↓

Check Authentication

↓

Navigate
```

---

# 17. Theme System

Seluruh warna aplikasi TIDAK BOLEH ditulis langsung pada widget.

Contoh yang dilarang:

```dart
Container(
  color: Colors.blue,
)
```

Semua harus berasal dari Theme Manager.

Contoh:

```dart
Container(
  color: AppColors.primary,
)
```

---

# 18. Theme Manager

Seluruh tema berada pada satu lokasi.

```
core/theme/

app_theme.dart

app_colors.dart

app_radius.dart

app_spacing.dart

app_typography.dart

app_shadow.dart

app_icon.dart

app_button_theme.dart

app_input_theme.dart

app_card_theme.dart

app_dialog_theme.dart

app_bottom_sheet_theme.dart
```

Jika branding universitas berubah, cukup ubah file di folder `core/theme` tanpa mengubah halaman lain.

---

# 19. Typography

Font utama:

**Plus Jakarta Sans**

Fallback:

- Inter
- Roboto

Ukuran font menggunakan skala yang konsisten:

- Display
- Headline
- Title
- Body
- Label

Tidak menggunakan ukuran angka secara langsung di widget.

---

# 20. Color Palette

Semua warna disimpan dalam `AppColors`.

Kategori minimal:

- Primary
- Secondary
- Background
- Surface
- Success
- Warning
- Error
- Info
- Text Primary
- Text Secondary
- Border
- Divider
- Skeleton Base
- Skeleton Highlight

---

# 21. Design Tokens

Seluruh spacing, radius, elevation, dan durasi animasi disimpan sebagai design token.

Contoh:

- Spacing XS, SM, MD, LG, XL
- Radius SM, MD, LG
- Elevation 1–5
- Animation Duration Fast, Normal, Slow

Widget tidak boleh menggunakan angka "magic number" seperti `8`, `12`, `16`, `24` secara langsung jika sudah tersedia token.

---

# 22. Localization

Aplikasi mendukung multi bahasa.

Versi awal:

- Bahasa Indonesia
- English

Struktur:

```
assets/translations/

id.json

en.json
```

Semua teks UI harus berasal dari file translasi, bukan string yang ditulis langsung di widget.

---

# 23. Device Information

Setiap request ke server wajib menyertakan informasi perangkat melalui header atau payload sesuai kontrak backend.

Minimal meliputi:

- Platform
- Device Model
- OS Version
- App Version
- Build Number
- Language
- Timezone
- Device Identifier (sesuai kebijakan platform)

Informasi ini digunakan untuk analitik, troubleshooting, dan kompatibilitas versi.

---

# 24. Penutup Part 01

Part 01 mendefinisikan fondasi proyek:

- Visi aplikasi
- Prinsip pengembangan
- Technology Stack
- Clean Architecture
- Struktur folder
- Routing
- Splash Flow
- Portal
- Theme System
- Typography
- Localization

Part berikutnya akan membahas implementasi teknis yang lebih rinci, termasuk Dependency Injection, Environment, Networking, Dummy Data Layer, Repository Pattern, BLoC Standard, dan alur data end-to-end.