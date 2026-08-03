# SYSTEM_DESIGN_SIMAK_UNIVERSITY_PART_02.md

> Version : 1.0.0
>
> Project : SIMAK Mobile Universitas
>
> Part : 02
>
> Architecture : Clean Architecture + BLoC
>
> Status : Production Ready

---

# 25. Dependency Injection

## Objective

Seluruh object pada aplikasi **WAJIB** dibuat menggunakan Dependency Injection (DI).

Tidak diperbolehkan membuat object menggunakan:

```dart
final api = ApiService();
```

langsung di dalam widget atau bloc.

Semua dependency harus diregister pada satu tempat.

---

## Library

Menggunakan

```
get_it
```

---

## Struktur

```
core/

di/

service_locator.dart

injector.dart

module/

network_module.dart

repository_module.dart

usecase_module.dart

service_module.dart
```

---

## Registration Flow

```
App Start

↓

Initialize Service Locator

↓

Register Core Service

↓

Register Storage

↓

Register API

↓

Register Repository

↓

Register UseCase

↓

Register Bloc Factory

↓

Run Application
```

---

# 26. Environment Configuration

Aplikasi harus mendukung banyak environment.

```
.env.dev

.env.sit

.env.uat

.env.staging

.env.production
```

---

## Contoh

```
APP_NAME=

BASE_URL=

SOCKET_URL=

ONESIGNAL_APP_ID=

API_TIMEOUT=

USE_DUMMY=

ENABLE_LOG=

ENABLE_ANALYTICS=

ENABLE_CRASHLYTICS=
```

---

## Wrapper

Tidak boleh memanggil

```
dotenv.env
```

langsung.

Harus menggunakan wrapper.

```
EnvConfig.baseUrl

EnvConfig.timeout

EnvConfig.useDummy

EnvConfig.oneSignalAppId
```

---

# 27. Build Flavor

Disarankan menggunakan Flavor.

```
Development

↓

SIT

↓

UAT

↓

Staging

↓

Production
```

Masing-masing memiliki icon, app name, dan environment sendiri.

---

# 28. Application Startup Flow

```
Open App

↓

Initialize Flutter Binding

↓

Load Environment

↓

Initialize Logger

↓

Initialize Theme

↓

Initialize Localization

↓

Initialize Shared Preference

↓

Initialize Secure Storage

↓

Initialize Dependency Injection

↓

Initialize OneSignal

↓

Initialize Connectivity Listener

↓

Initialize Remote Config (Future)

↓

Run App
```

---

# 29. Shared Preferences

Digunakan untuk data non sensitif.

Contoh

- Theme
- Locale
- Intro Screen
- Last Selected Menu
- Cache Timestamp

Tidak boleh menyimpan token.

---

# 30. Secure Storage

Digunakan untuk data sensitif.

Contoh

- Access Token
- Refresh Token
- Device Token
- Session

---

# 31. Network Layer

Library

```
Dio
```

Semua request melalui

```
ApiClient
```

Widget tidak boleh menggunakan Dio secara langsung.

Bloc juga tidak boleh.

---

## Struktur

```
network/

api_client.dart

api_interceptor.dart

retry_interceptor.dart

auth_interceptor.dart

logging_interceptor.dart

header_interceptor.dart

dio_factory.dart
```

---

# 32. API Client Flow

```
Page

↓

Bloc

↓

UseCase

↓

Repository

↓

Remote Data Source

↓

ApiClient

↓

Dio

↓

REST API
```

---

# 33. Global Header

Setiap request wajib mengirim

```
Authorization

Accept

Content-Type

Accept-Language

Platform

Device-Model

OS-Version

App-Version

Build-Number

Timezone

Device-ID
```

---

# 34. Request ID

Setiap request dibuatkan

```
X-Request-ID
```

agar backend mudah melakukan tracing log.

---

# 35. Authentication Interceptor

Interceptor bertugas

- Menambahkan token
- Mengecek token
- Refresh token
- Logout otomatis

---

## Flow

```
Expired Token

↓

Refresh Token

↓

Success

↓

Retry Request

```

Jika gagal

```
Logout

↓

Portal Page
```

---

# 36. Retry Interceptor

Jika terjadi

```
Timeout

Socket Error

No Internet
```

otomatis melakukan retry sesuai konfigurasi.

Default

```
3 kali
```

---

# 37. Logging

Development

```
Request

Response

Header

Body

Duration

Error
```

Production

```
Error Only
```

---

# 38. Error Handling

Semua error harus menggunakan model yang sama.

Kategori

```
No Internet

↓

Unauthorized

↓

Forbidden

↓

Not Found

↓

Validation

↓

Server Error

↓

Timeout

↓

Unknown Error
```

---

# 39. Connectivity

Menggunakan

```
connectivity_plus

+

internet_connection_checker_plus
```

Tidak hanya mengecek WiFi.

Tetapi benar-benar mengecek internet.

---

# 40. No Internet Flow

```
Request

↓

No Internet

↓

No Internet Page

↓

Retry

↓

Check Again

↓

Success

↓

Reload Data
```

---

## Halaman

Komponen

- Illustration
- Title
- Description
- Retry Button

---

# 41. Maintenance Mode

Backend menyediakan endpoint

```
GET /app/config
```

response

```
maintenance

title

description

image

```

Jika aktif

langsung membuka

```
Maintenance Page
```

---

# 42. Version Checking

Saat Splash

```
GET /app/version
```

Response

```
latest_version

minimum_version

force_update

change_log

play_store

app_store
```

---

## Flow

```
Current Version

↓

Compare

↓

Need Update?

↓

YES

↓

Force Update Page
```

---

# 43. Force Update Page

Berisi

- Logo
- Version
- What's New
- Changelog
- Update Button

Jika

```
force_update=true
```

tidak boleh ditutup.

---

# 44. Optional Update

Jika

```
force_update=false
```

User boleh

```
Later
```

---

# 45. Dummy Data Layer

Selama backend belum selesai

seluruh aplikasi menggunakan

```
Dummy Repository
```

---

## Struktur

```
assets/

dummy/

student/

lecturer/

billing/

notification/

profile/

calendar/

schedule/

grade/

```

---

# 46. Dummy JSON

Contoh

```
student.json

profile.json

grade.json

schedule.json

billing.json

notification.json
```

---

# 47. Dummy Repository

Contoh

```
StudentRepository
```

implementasi

```
DummyStudentRepository
```

mengambil data

```
assets/dummy/student.json
```

---

# 48. API Repository

Saat backend selesai

cukup mengganti

```
DummyStudentRepository

↓

ApiStudentRepository
```

UI

Bloc

UseCase

tidak berubah.

---

# 49. Repository Pattern

```
Presentation

↓

Bloc

↓

UseCase

↓

Repository

↓

RepositoryImpl

↓

Remote

↓

API
```

Repository tidak boleh mengetahui UI.

---

# 50. Entity

Entity merupakan model utama aplikasi.

Tidak bergantung pada API.

Contoh

```
StudentEntity

GradeEntity

ProfileEntity
```

---

# 51. Model

Model mengikuti response backend.

Contoh

```
StudentModel

GradeModel

NotificationModel
```

---

# 52. Mapper

Model

↓

Entity

menggunakan Mapper.

Tidak boleh langsung dipakai.

---

# 53. DTO

Digunakan untuk request.

Contoh

```
LoginRequest

ChangePasswordRequest

PaymentRequest
```

---

# 54. Use Case

Setiap proses bisnis memiliki use case sendiri.

Contoh

```
LoginUseCase

LogoutUseCase

GetProfileUseCase

UpdateProfileUseCase

GetScheduleUseCase

SearchStudentUseCase
```

Satu UseCase hanya satu tanggung jawab.

---

# 55. BLoC Standard

Setiap Feature

```
FeatureBloc

FeatureEvent

FeatureState
```

Tidak boleh membuat

```
AppBloc
```

yang mengurus seluruh aplikasi.

---

# 56. Bloc State

Minimal state

```
Initial

Loading

Loaded

Empty

Error

Refreshing

Loading More
```

---

# 57. Pagination State

Setiap list wajib mendukung

```
Current Page

Page Size

Total Data

Has More

Loading More
```

---

# 58. Infinite Scroll

Semua halaman list menggunakan

```
ScrollController
```

Ketika

```
80%

scroll
```

otomatis

```
Load Next Page
```

---

# 59. Pull To Refresh

Semua halaman list

menggunakan

```
RefreshIndicator
```

---

# 60. Search

Seluruh halaman list memiliki

```
Search Bar
```

menggunakan

```
Debounce

500 ms
```

---

# 61. Back To Top

Saat user scroll lebih dari

```
500 px
```

muncul

Floating Button

```
↑
```

Klik

↓

Scroll ke atas.

Widget ini reusable untuk semua halaman list.

---

# 62. Skeleton Loading

Semua loading menggunakan

```
Shimmer
```

Tidak boleh menggunakan

```
CircularProgressIndicator
```

untuk loading halaman penuh.

---

# 63. Skeleton Type

Minimal tersedia

```
Dashboard Skeleton

Profile Skeleton

Card Skeleton

Table Skeleton

List Skeleton

Grid Skeleton

Detail Skeleton

Form Skeleton
```

Semuanya reusable.

---

# 64. Empty State

Semua halaman wajib memiliki

- Illustration
- Title
- Description
- Refresh Button

---

# 65. Error State

Semua halaman wajib memiliki

- Illustration
- Error Message
- Retry Button

---

# 66. Loading Overlay

Untuk proses submit

gunakan

```
Global Loading Overlay
```

agar user tidak bisa menekan tombol berulang.

---

# 67. Penutup Part 02

Part ini mendefinisikan fondasi implementasi teknis aplikasi:

- Dependency Injection
- Environment & Flavor
- Networking dengan Dio
- Interceptor
- Logging
- Error Handling
- Connectivity
- Version Checker
- Maintenance Mode
- Dummy Data Layer
- Repository Pattern
- Entity, Model, DTO
- UseCase
- Standar BLoC
- Pagination
- Infinite Scroll
- Pull To Refresh
- Search dengan Debounce
- Reusable Back To Top
- Skeleton Shimmer
- Empty & Error State

Pada **PART 03** akan dibahas **Design System, Reusable Widget Library, Reusable Function Library, Theme Manager secara detail, Navigation Pattern, serta standar UI/UX enterprise** yang akan digunakan oleh seluruh halaman aplikasi.