# APK Üretecek Workflow'ları Nasıl Kullanılır?

Bu rehber, Meshtastic-Android projesinde APK dosyası üreten workflow'ları ve bunların nasıl çağrılacağını açıklar.

## APK Üreten Workflow'lar

Projede APK dosyası üreten **3 farklı workflow** bulunmaktadır:

### 1. 🎯 **Create or Promote Release** (Önerilen - Release APK'ları için)

**Dosya:** `.github/workflows/create-or-promote-release.yml`

**Ne zaman kullanılır:** Resmi release APK'ları oluşturmak için (imzalı, production-ready)

**Nasıl çağrılır:**

1. GitHub deposuna gidin: https://github.com/kaanyaren/mtastic_android
2. **Actions** sekmesine tıklayın
3. Sol menüden **"Create or Promote Release"** workflow'unu seçin
4. Sağ tarafta **"Run workflow"** dropdown'una tıklayın
5. Parametreleri doldurun:
   - **base_version:** Sürüm numarası (örn: `2.4.0`)
   - **channel:** Hedef kanal seçin:
     - `internal` - İlk test için (dahili test)
     - `closed` - Kapalı beta test için
     - `open` - Açık beta test için
     - `production` - Final production release için
   - **dry_run:** `false` (gerçek release için)
6. **"Run workflow"** butonuna tıklayın

**Çıktılar:**
- ✅ Google Play AAB (app-google-release.aab)
- ✅ Google Play APK (app-google-release.apk)
- ✅ F-Droid APK (app-fdroid-release.apk)
- Tüm dosyalar GitHub Release'e eklenir
- Google Play Console'a otomatik yüklenir

**Artifacts'ı indirme:**
- Workflow tamamlandıktan sonra **Releases** sekmesinden veya workflow çalıştırmasının **Artifacts** bölümünden indirin

---

### 2. 🔨 **Reusable Android Build** (Debug APK'ları için)

**Dosya:** `.github/workflows/reusable-android-build.yml`

**Ne zaman kullanılır:** Geliştirme ve test için debug APK'ları oluşturmak için

**Nasıl çağrılır:**

Bu workflow doğrudan manuel olarak çağrılamaz, ancak otomatik olarak şu durumlarda çalışır:
- Pull Request açıldığında (`.github/workflows/pull-request.yml` tarafından)
- Merge queue'ya eklendiğinde

**Manuel olarak debug APK almak için:** Aşağıdaki komutu yerel makinenizde çalıştırın:

```bash
# F-Droid debug APK
./gradlew assembleFdroidDebug

# Google debug APK
./gradlew assembleGoogleDebug

# Her iki APK'yı da oluştur
./gradlew assembleDebug
```

**Çıktılar:**
- Debug APK'lar `app/build/outputs/apk/` dizininde oluşturulur
- CI/CD'de artifacts olarak saklanır (14 gün)

---

### 3. 📦 **Pull Request Workflow** (Otomatik Debug Build)

**Dosya:** `.github/workflows/pull-request.yml`

**Ne zaman kullanılır:** Pull request'lerde otomatik olarak çalışır

**Nasıl çağrılır:**

Bir pull request oluşturduğunuzda otomatik olarak çalışır. Manuel çağırma gerekmez.

**Çıktılar:**
- Debug APK'lar (fdroidDebug ve googleDebug)
- Pull request'in **Checks** bölümünden indirilebilir

---

## Hızlı Başlangıç Kılavuzu

### En Hızlı Yol - Debug APK Almak için:

```bash
# Temiz bir build için
./gradlew clean

# Debug APK oluştur (her iki flavor için)
./gradlew assembleDebug

# APK'ları bul
ls -la app/build/outputs/apk/fdroid/debug/app-fdroid-debug.apk
ls -la app/build/outputs/apk/google/debug/app-google-debug.apk
```

### Production Release APK için:

1. GitHub'da **Actions** → **Create or Promote Release**
2. Version gir (örn: `2.5.0`)
3. Channel olarak `internal` seç (ilk release için)
4. **Run workflow** tıkla
5. Workflow bitince **Releases** sayfasından APK'ları indir

---

## APK Türleri

| Tür | İmzalı | Google Play | F-Droid Uyumlu | Kullanım |
|------|--------|-------------|----------------|----------|
| **google-release.apk** | ✅ Evet | ✅ Evet | ❌ Hayır | Google Play Store |
| **fdroid-release.apk** | ✅ Evet | ❌ Hayır | ✅ Evet | F-Droid Store |
| **google-debug.apk** | ❌ Hayır | ❌ Hayır | ❌ Hayır | Geliştirme/Test |
| **fdroid-debug.apk** | ❌ Hayır | ❌ Hayır | ❌ Hayır | Geliştirme/Test |

---

## Gereksinimler

### Release Build için (GitHub Actions):
- ✅ GitHub repository admin erişimi
- ✅ Secrets yapılandırılmış (KEYSTORE, GOOGLE_PLAY_JSON_KEY, vb.)

### Yerel Build için:
- ✅ JDK 21
- ✅ Android SDK
- ✅ `local.properties` dosyası (secrets.defaults.properties'den kopyalanmış)

---

## Sorun Giderme

**S: Workflow'u bulamıyorum?**
- A: Actions sekmesinde "All workflows" dropdown'undan "Create or Promote Release" seçin

**S: APK'yı nerede bulabilirim?**
- A: Workflow tamamlandıktan sonra:
  1. Releases sayfası (production için)
  2. Workflow run sayfasının "Artifacts" bölümü (test için)

**S: "Run workflow" butonu görünmüyor?**
- A: Deposuna write erişiminiz olmalı. Forked repolarda bu özellik çalışmayabilir.

**S: Build başarısız oluyor?**
- A: Workflow logs'larını kontrol edin ve RELEASE_PROCESS.md dosyasına bakın

---

## İlgili Dosyalar

- **Workflow tanımları:** `.github/workflows/`
- **Release süreci:** `RELEASE_PROCESS.md`
- **Build konfigürasyonu:** `app/build.gradle.kts`
- **Fastlane konfigürasyonu:** `fastlane/Fastfile`

---

## Daha Fazla Bilgi

Detaylı release süreci için: [RELEASE_PROCESS.md](RELEASE_PROCESS.md)
