# Sorunuza Cevap: APK Verecek Workflow ve Nasıl Çağrılır?
# Answer to Your Question: Which Workflow Provides APK and How to Call It?

---

## 🎯 Kısa Cevap / Short Answer

**Soru:** Şimdi bana APK verecek bir workflow lazım. Bu workflow hangisi? Bunu nasıl çağırırım?

**Cevap:** APK verecek **3 farklı workflow** var:

### 1. ⭐ **Create or Promote Release** (EN POPÜLER / MOST POPULAR)

**Workflow Dosyası:** `.github/workflows/create-or-promote-release.yml`

**Nasıl Çağrılır:**

1. https://github.com/kaanyaren/mtastic_android adresine git
2. **Actions** sekmesine tıkla
3. Sol menüden **"Create or Promote Release"** seç
4. Sağda **"Run workflow"** dropdown'una tıkla
5. Parametreleri doldur:
   - `base_version`: Örn: `2.4.0`
   - `channel`: `internal` seç (ilk seferde)
   - `dry_run`: `false` seç
6. **"Run workflow"** butonuna tıkla

**Ne Verir:**
- ✅ `app-google-release.apk` (imzalı, Google Play için)
- ✅ `app-google-release.aab` (imzalı, Google Play için)
- ✅ `app-fdroid-release.apk` (imzalı, F-Droid için)

**APK'yı Nerede Bulursun:**
- GitHub **Releases** sayfasından indir
- Veya workflow'un **Artifacts** bölümünden

---

### 2. 🔨 **Reusable Android Build** (OTOMATIK)

**Workflow Dosyası:** `.github/workflows/reusable-android-build.yml`

**Nasıl Çağrılır:**
- Otomatik çalışır (Pull Request açtığında)
- Manuel çağrılamaz

**Ne Verir:**
- ⚙️ `app-fdroid-debug.apk` (imzasız, test için)
- ⚙️ `app-google-debug.apk` (imzasız, test için)

---

### 3. 💻 **Yerel Gradle Build** (YEREL MAKİNENDE)

**Nasıl Çağrılır:**

Terminal'de şu komutu çalıştır:

```bash
# Her iki debug APK'yı da oluştur
./gradlew assembleDebug

# Sadece F-Droid
./gradlew assembleFdroidDebug

# Sadece Google
./gradlew assembleGoogleDebug
```

**Ne Verir:**
- APK'lar `app/build/outputs/apk/` dizininde oluşturulur

---

## 🚀 Hangisini Kullanmalısın? / Which One Should You Use?

| Amaç | Kullanılacak Yöntem | Sonuç |
|------|---------------------|-------|
| **Production APK (Store için)** | GitHub Actions → Create or Promote Release | Release APK (imzalı) |
| **Hızlı test APK** | `./gradlew assembleDebug` | Debug APK (local) |
| **PR test otomatik** | Pull Request aç | Debug APK (otomatik) |

---

## 📖 Detaylı Dokümantasyon / Detailed Documentation

Bu soruya tam cevap vermek için **5 ayrı dokümantasyon dosyası** oluşturdum:

### 1. [APK_WORKFLOW_INDEX.md](APK_WORKFLOW_INDEX.md)
**Ana İndeks Dosyası** - Tüm dokümantasyona buradan erişebilirsin

### 2. [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md)
**Türkçe Detaylı Rehber** - Her şeyin detaylı Türkçe açıklaması

### 3. [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md)
**English Detailed Guide** - Detailed English explanations

### 4. [APK_WORKFLOW_QUICKREF.md](APK_WORKFLOW_QUICKREF.md)
**Hızlı Referans** - En çok kullanılan komutlar ve kısa yol

### 5. [APK_WORKFLOW_DIAGRAM.txt](APK_WORKFLOW_DIAGRAM.txt)
**Görsel Diyagram** - Workflow'ların görsel gösterimi

---

## 🎯 En Hızlı Yol / Fastest Way

### Senaryo 1: Hemen Test APK İstiyorum

```bash
cd /home/runner/work/mtastic_android/mtastic_android
./gradlew clean
./gradlew assembleDebug
ls -lh app/build/outputs/apk/*/debug/*.apk
```

**Sonuç:** 2-3 dakika içinde debug APK'lar hazır

---

### Senaryo 2: Production Release APK İstiyorum

1. GitHub'a git: https://github.com/kaanyaren/mtastic_android
2. **Actions** → **Create or Promote Release**
3. Girdiler:
   - Version: `2.5.0` (örnek)
   - Channel: `internal`
   - Dry run: `false`
4. **Run workflow** tıkla
5. Bekle (10-15 dakika)
6. **Releases** sayfasından APK'ları indir

**Sonuç:** Production-ready imzalı APK'lar

---

## 📊 Workflow Karşılaştırması / Workflow Comparison

| Özellik | Create or Promote Release | Reusable Android Build | Local Gradle |
|---------|---------------------------|------------------------|--------------|
| **Çağırma** | GitHub Actions (Manuel) | Otomatik (PR'da) | Terminal komutu |
| **APK Türü** | Release (İmzalı) | Debug (İmzasız) | İkisi de |
| **Süre** | 10-15 dakika | 5-10 dakika | 2-5 dakika |
| **Kullanım** | Production | Testing | Local test |
| **Artifacts** | GitHub Releases | Workflow artifacts | Local dosya |

---

## ⚙️ Gereksinimler / Requirements

### GitHub Actions için:
- ✅ Repository'ye write erişimi
- ✅ Secrets yapılandırılmış (otomatik zaten var)

### Local build için:
- ✅ JDK 21 kurulu
- ✅ Android SDK kurulu
- ✅ `local.properties` dosyası hazır

---

## 🎓 Adım Adım Örnek / Step-by-Step Example

### Örnek: İlk Release APK'nı Oluşturma

**Adım 1:** GitHub'a git
```
https://github.com/kaanyaren/mtastic_android
```

**Adım 2:** Actions sekmesine tıkla
(Üst menüde "Actions" yazısını göreceksin)

**Adım 3:** "Create or Promote Release" workflow'unu seç
(Sol menüdeki listeden seç)

**Adım 4:** "Run workflow" butonuna tıkla
(Sağ tarafta yeşil buton olacak)

**Adım 5:** Formu doldur:
```
base_version: 2.5.0
channel: internal
dry_run: false
```

**Adım 6:** Yeşil "Run workflow" butonuna tıkla

**Adım 7:** Bekle (10-15 dakika)

**Adım 8:** Releases sayfasına git ve APK'ları indir
```
https://github.com/kaanyaren/mtastic_android/releases
```

**SONUÇ:** 
- ✅ app-google-release.apk
- ✅ app-google-release.aab
- ✅ app-fdroid-release.apk

---

## ❓ Sık Sorulan Sorular / FAQ

### S1: "Run workflow" butonu göremiyorum?
**C:** Repository'ye write erişimin olması gerekiyor. Eğer forked repo ise, kendi fork'unda çalıştırman gerekir.

### S2: APK'yı indiremedim?
**C:** İki yerden indirebilirsin:
1. **Releases sayfası:** https://github.com/kaanyaren/mtastic_android/releases
2. **Workflow run sayfası:** Actions → Workflow seç → Artifacts bölümü

### S3: Build başarısız oldu?
**C:** Workflow logs'larına bak. En yaygın sorunlar:
- Secrets eksik veya yanlış
- Version numarası zaten kullanılmış
- Git tag conflict

### S4: Debug APK ile Release APK arasındaki fark nedir?
**C:**
- **Debug APK:** İmzasız, sadece test için, daha hızlı build
- **Release APK:** İmzalı, store'lara yüklenebilir, optimize edilmiş

---

## 🔗 Ek Kaynaklar / Additional Resources

- 📖 **Release Process:** [RELEASE_PROCESS.md](RELEASE_PROCESS.md)
- 📖 **Contributing:** [CONTRIBUTING.md](CONTRIBUTING.md)
- 📖 **Project README:** [README.md](README.md)
- 💬 **Discord:** https://discord.gg/meshtastic
- 🐛 **Issues:** https://github.com/kaanyaren/mtastic_android/issues

---

## 📝 Özet / Summary

**Sorduğun soru:** APK verecek workflow hangisi ve nasıl çağırılır?

**Cevap:**

1. **Production APK için:** GitHub Actions → "Create or Promote Release" → Run workflow
2. **Test APK için:** Terminal'de `./gradlew assembleDebug`
3. **Otomatik test:** Pull Request aç, otomatik çalışır

**En iyi seçenek:** Kullanım amacına göre:
- Store'a yükleyeceksen: **Create or Promote Release**
- Hızlı test yapacaksan: **./gradlew assembleDebug**

**Detaylı bilgi için:** [APK_WORKFLOW_INDEX.md](APK_WORKFLOW_INDEX.md) dosyasına bak

---

## ✅ Sonuç / Conclusion

Bu dokümantasyon paketi ile:
- ✅ Hangi workflow'un APK verdiğini öğrendin
- ✅ Her workflow'u nasıl çağıracağını öğrendin
- ✅ APK'ları nerede bulacağını öğrendin
- ✅ Hangi durumda hangi yöntemi kullanacağını öğrendin
- ✅ Tüm detaylı dokümantasyona erişim sağladın

**Başarılar! / Good luck!** 🚀

---

**Oluşturulma Tarihi / Created:** 2025-10-14
**Versiyon / Version:** 1.0.0
**Durum / Status:** ✅ Tamamlandı / Complete
