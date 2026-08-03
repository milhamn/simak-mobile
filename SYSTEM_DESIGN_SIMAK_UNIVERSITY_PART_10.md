# SYSTEM_DESIGN_SIMAK_UNIVERSITY_PART_10.md

> Version : 1.0.0
>
> Project : SIMAK Mobile Universitas
>
> Part : 10
>
> Module : Backend API Standard, Security & REST Contract
>
> Status : Production Ready
>
> Target Backend : **Java 17 (LTS) + Spring Boot 3.x**
>
> Database : mysql
>
> Authentication : JWT + Refresh Token
>
> API Style : RESTful API

---

# 432. Backend Technology Stack

Backend menggunakan teknologi berikut.

```
Java 17 (LTS)

Spring Boot 3.x

Spring Security 6

Spring Data JPA

Hibernate ORM

PostgreSQL 16+

Flyway Migration

Gradle

JWT

OpenAPI 3 / Swagger

MapStruct

Lombok

Bean Validation

SLF4J

Logback
```

Future Ready

```
Redis

RabbitMQ

Kafka

MinIO

ElasticSearch
```

---

# 433. REST API Principle

Seluruh API wajib mengikuti prinsip berikut.

- RESTful
- Stateless
- Consistent Response
- Secure
- Versioning
- Pagination Ready
- Search Ready
- Filter Ready
- Localization Ready
- Backend Driven
- Mobile Friendly

---

# 434. Base URL

Development

```
https://dev-api.university.ac.id/api/v1
```

Staging

```
https://staging-api.university.ac.id/api/v1
```

Production

```
https://api.university.ac.id/api/v1
```

Frontend membaca Base URL dari file `.env`.

Tidak boleh ada endpoint yang di-hardcode.

---

# 435. API Versioning

Gunakan URI Versioning.

```
/api/v1
```

Future

```
/api/v2
```

Jangan mengubah endpoint lama.

---

# 436. HTTP Method Standard

```
GET
```

Mengambil data.

```
POST
```

Menambah data.

```
PUT
```

Mengubah seluruh data.

```
PATCH
```

Mengubah sebagian data.

```
DELETE
```

Menghapus data.

---

# 437. URL Naming Convention

Gunakan bentuk noun.

Benar

```
/students

/courses

/payments

/notifications

/profile
```

Salah

```
/getStudent

/doLogin

/getAllCourse

/savePayment
```

---

# 438. Standard Success Response

Semua endpoint menggunakan format yang sama.

```json
{
  "success": true,
  "message": "Success",
  "data": {},
  "meta": null,
  "errors": []
}
```

---

# 439. Standard Error Response

```json
{
  "success": false,
  "message": "Validation Error",
  "data": null,
  "errors": [
    {
      "code": "VALIDATION_ERROR",
      "field": "email",
      "message": "Email wajib diisi."
    }
  ]
}
```

---

# 440. Pagination Response

```json
{
  "success": true,
  "data": [],
  "meta": {
    "page": 1,
    "limit": 20,
    "totalData": 200,
    "totalPage": 10,
    "hasNext": true,
    "hasPrevious": false
  }
}
```

---

# 441. Pagination Standard

Seluruh endpoint list wajib mendukung.

```
?page=1

&limit=20
```

---

# 442. Search Standard

Semua endpoint list mendukung.

```
?search=ilham
```

Backend melakukan pencarian.

Frontend hanya mengirim keyword.

---

# 443. Sorting Standard

```
?sort=name

&direction=asc
```

Direction

```
asc

desc
```

---

# 444. Filter Standard

Contoh

```
?faculty=Teknik

?semester=Genap

?status=ACTIVE
```

Support multi filter.

---

# 445. Authentication

Menggunakan JWT.

Flow

```
Login

↓

Access Token

↓

Refresh Token

↓

API

↓

Expired

↓

Refresh Token

↓

Retry
```

---

# 446. Authorization Header

```
Authorization

Bearer {access_token}
```

---

# 447. Device Header

Seluruh request mengirim informasi device.

```
Device-Id

Device-Model

Device-Brand

Platform

OS-Version

App-Version

Build-Number

Language

Timezone
```

Contoh

```
Platform : Android

Language : id

Timezone : Asia/Jakarta
```

---

# 448. Request ID

Seluruh request mengirim.

```
X-Request-Id
```

Digunakan untuk tracing log.

---

# 449. Correlation ID

Backend mengembalikan.

```
X-Correlation-Id
```

Digunakan saat debugging.

---

# 450. Localization

Header

```
Accept-Language

id

en
```

Backend mengirim pesan sesuai bahasa.

---

# 451. HTTP Status Standard

```
200 OK

201 Created

204 No Content

400 Bad Request

401 Unauthorized

403 Forbidden

404 Not Found

409 Conflict

422 Unprocessable Entity

429 Too Many Requests

500 Internal Server Error
```

---

# 452. Error Code Standard

Contoh

```
AUTH_001

TOKEN_INVALID

AUTH_002

TOKEN_EXPIRED

AUTH_003

LOGIN_FAILED

DATA_001

DATA_NOT_FOUND

DATA_002

VALIDATION_ERROR

SERVER_001

INTERNAL_SERVER_ERROR
```

---

# 453. Validation

Gunakan Bean Validation.

```
@NotBlank

@NotNull

@Email

@Size

@Positive

@Min

@Max
```

Tidak melakukan validasi hanya di frontend.

---

# 454. Global Exception Handler

Gunakan.

```
@RestControllerAdvice
```

Seluruh exception dikonversi menjadi response standar.

---

# 455. Logging

Gunakan

```
SLF4J

Logback
```

Minimal log.

- Login
- Logout
- Payment
- Error
- Exception
- Upload File

---

# 456. Audit Trail

Gunakan JPA Audit.

Semua tabel minimal memiliki.

```
createdAt

createdBy

updatedAt

updatedBy
```

Optional

```
deletedAt

deletedBy
```

---

# 457. Soft Delete

Gunakan Soft Delete.

Contoh.

```
isDeleted

deletedAt
```

Data tidak langsung dihapus.

---

# 458. Date Standard

Gunakan.

```
ISO 8601
```

Contoh.

```
2026-07-26T08:30:00Z
```

---

# 459. Number Standard

Backend mengirim angka.

```
2500000
```

Frontend melakukan formatting.

```
Rp2.500.000
```

---

# 460. Boolean Standard

Gunakan.

```
true

false
```

Jangan menggunakan.

```
Y

N

1

0
```

---

# 461. Enum Standard

Gunakan enum uppercase.

Contoh.

```
ACTIVE

INACTIVE

PENDING

APPROVED

REJECTED
```

---

# 462. File Upload

Gunakan.

```
multipart/form-data
```

Support.

- Foto Profil
- Bukti Pembayaran
- Lampiran

---

# 463. File Download

Backend mengembalikan.

```
Content-Disposition
```

Frontend cukup melakukan download.

---

# 464. API Timeout

Default.

```
Connect

30 detik

Receive

30 detik

Send

30 detik
```

Diatur melalui `.env`.

---

# 465. Retry Policy

Retry hanya dilakukan jika.

- Socket Exception
- Timeout
- Connection Error

Tidak melakukan retry.

```
401

403

422
```

---

# 466. Force Update API

Contoh Response.

```json
{
  "forceUpdate": true,
  "minimumVersion": "1.2.0",
  "latestVersion": "1.3.0",
  "title": "Update Aplikasi",
  "description": [
    "Perbaikan bug",
    "Peningkatan performa",
    "Peningkatan keamanan"
  ]
}
```

---

# 467. Maintenance API

```json
{
  "maintenance": true,
  "title": "Maintenance",
  "message": "Server sedang maintenance."
}
```

Frontend membuka halaman Maintenance.

---

# 468. OpenAPI Documentation

Seluruh endpoint wajib tersedia pada.

```
Swagger UI

OpenAPI 3
```

---

# 469. Flyway Migration

Seluruh perubahan database menggunakan.

```
Flyway
```

Tidak boleh mengubah tabel secara manual di Production.

---

# 470. DTO Rule

Gunakan DTO.

```
Request DTO

Response DTO
```

Jangan mengirim Entity langsung ke frontend.

---

# 471. Entity Rule

Entity hanya digunakan pada layer persistence.

Tidak boleh digunakan langsung pada Controller.

---

# 472. Mapper Rule

Gunakan.

```
MapStruct
```

Untuk konversi.

```
Entity

↓

DTO
```

---

# 473. Repository Rule

Repository hanya berisi operasi database.

Tidak boleh berisi Business Logic.

---

# 474. Service Rule

Business Logic hanya berada pada.

```
Service Layer
```

Controller tidak boleh memiliki business logic.

---

# 475. Controller Rule

Controller hanya bertugas.

- Validasi Request
- Memanggil Service
- Mengembalikan Response

---

# 476. Security Best Practice

- HTTPS Only
- JWT Authentication
- Refresh Token
- Password BCrypt
- Input Validation
- SQL Injection Protection
- XSS Protection
- Rate Limiting
- Audit Log
- Request Logging

---

# 477. Production Checklist

Seluruh endpoint wajib memiliki.

- Authentication
- Authorization
- Validation
- Logging
- Audit Trail
- Pagination
- Search
- Filter
- Sorting
- Localization
- API Documentation
- Unit Test
- Integration Test

---

# 478. Backend Development Guideline

Seluruh backend harus mengikuti prinsip.

- Single Responsibility Principle
- Clean Code
- SOLID Principle
- Clean Architecture
- Layered Architecture
- Reusable Service
- Reusable Utility
- Reusable Validation
- Centralized Exception Handler
- Centralized Response Builder
- No Hardcode Configuration

---

# 479. Production Ready Goals

Backend harus mampu menangani seluruh kebutuhan aplikasi SIMAK tanpa perubahan besar pada arsitektur.

Target utama.

- Mudah dikembangkan
- Mudah dipelihara
- Aman
- Performa tinggi
- Konsisten
- Mudah diintegrasikan dengan Flutter
- Siap digunakan untuk ribuan hingga puluhan ribu pengguna aktif

---

# 480. Penutup Part 10

Dokumen ini menjadi standar resmi pengembangan Backend SIMAK Universitas menggunakan **Java 17 (LTS)** dan **Spring Boot 3.x**. Seluruh tim backend maupun AI generator wajib mengikuti spesifikasi ini agar API tetap konsisten, aman, mudah di-maintain, dan kompatibel dengan arsitektur Flutter Clean Architecture yang telah dirancang pada bagian sebelumnya.

**PART 11** akan membahas secara lengkap:

- Folder Structure Flutter
- Naming Convention
- Reusable Component Rules
- Coding Guideline
- Theme Guideline
- Localization Guideline
- BLoC Best Practice
- Dependency Injection Rules
- Repository Rules
- Widget Rules
- Performance Guideline
- Lint Rules
- Production Coding Standard