# APK Workflow Dokümantasyonu İndeksi
# APK Workflow Documentation Index

Bu dizin, Meshtastic-Android projesinde APK dosyası oluşturma workflow'ları hakkında tüm dokümantasyonu içerir.

This directory contains all documentation about APK generation workflows in the Meshtastic-Android project.

---

## 📚 Mevcut Dokümantasyon / Available Documentation

### 1. 🇹🇷 Türkçe Dokümantasyon / Turkish Documentation

#### [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md)
**Detaylı Türkçe Rehber / Detailed Turkish Guide**

İçerik:
- APK üreten 3 workflow'un detaylı açıklaması
- Her workflow'un nasıl çağrılacağına dair adım adım talimatlar
- Çıktılar ve artifacts'ların nasıl indirileceği
- APK türleri ve kullanım senaryoları
- Gereksinimler ve sorun giderme
- Hızlı başlangıç komutları

**Kimlere Önerilir:** Türkçe konuşan kullanıcılar, detaylı bilgi arayanlar

---

### 2. 🇬🇧 İngilizce Dokümantasyon / English Documentation

#### [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md)
**Detailed English Guide**

Content:
- Detailed explanation of 3 APK-generating workflows
- Step-by-step instructions for invoking each workflow
- How to download outputs and artifacts
- APK types and usage scenarios
- Requirements and troubleshooting
- Quick start commands

**Recommended For:** English-speaking users, those seeking detailed information

---

### 3. 📊 Görsel Diyagram / Visual Diagram

#### [APK_WORKFLOW_DIAGRAM.txt](APK_WORKFLOW_DIAGRAM.txt)
**Görsel Workflow Diyagramı / Visual Workflow Diagram**

İçerik / Content:
- ASCII sanat diyagramları ile workflow gösterimi
- Her workflow için giriş/çıkış diyagramları
- APK türleri karşılaştırma tablosu
- Gereksinimler özeti
- Kullanım kılavuzu akış şeması

**Kimlere Önerilir / Recommended For:** Görsel öğrenenler, hızlı referans isteyenler / Visual learners, quick reference seekers

---

### 4. ⚡ Hızlı Referans / Quick Reference

#### [APK_WORKFLOW_QUICKREF.md](APK_WORKFLOW_QUICKREF.md)
**Hızlı Başvuru Kılavuzu / Quick Reference Guide**

İçerik / Content:
- En hızlı yollar özeti
- Workflow karşılaştırma tablosu
- Sık kullanılan komutlar
- Hangi workflow ne zaman kullanılır
- APK tipleri özeti
- SSS (Sık Sorulan Sorular)

**Kimlere Önerilir / Recommended For:** Deneyimli kullanıcılar, hızlı referans arayanlar / Experienced users, quick reference seekers

---

## 🎯 Hangi Dokümanı Okumalıyım? / Which Document Should I Read?

### Kullanım Senaryosuna Göre / By Use Case:

| Senaryo / Scenario | Önerilen Doküman / Recommended Document |
|-------------------|------------------------------------------|
| 🆕 İlk defa APK oluşturacaksınız / First time generating APK | [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md) veya / or [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md) |
| ⚡ Hızlı komut arıyorsunuz / Looking for quick command | [APK_WORKFLOW_QUICKREF.md](APK_WORKFLOW_QUICKREF.md) |
| 📊 Görsel anlatım istiyorsunuz / Want visual explanation | [APK_WORKFLOW_DIAGRAM.txt](APK_WORKFLOW_DIAGRAM.txt) |
| 🔍 Spesifik sorun çözümü / Specific troubleshooting | [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md) veya / or [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md) |

### Deneyim Seviyesine Göre / By Experience Level:

| Seviye / Level | Önerilen Okuma Sırası / Recommended Reading Order |
|----------------|---------------------------------------------------|
| 🌱 Başlangıç / Beginner | 1. APK_WORKFLOW_QUICKREF.md<br>2. APK_WORKFLOW_TR/EN.md<br>3. APK_WORKFLOW_DIAGRAM.txt |
| 🌿 Orta / Intermediate | 1. APK_WORKFLOW_QUICKREF.md<br>2. APK_WORKFLOW_DIAGRAM.txt |
| 🌳 İleri / Advanced | APK_WORKFLOW_QUICKREF.md |

---

## 🚀 Hızlı Başlangıç / Quick Start

### Debug APK İstiyorum / Want Debug APK
```bash
./gradlew assembleDebug
```
📖 Detay için / For details: [APK_WORKFLOW_QUICKREF.md](APK_WORKFLOW_QUICKREF.md)

### Production APK İstiyorum / Want Production APK
1. GitHub → Actions → Create or Promote Release
2. Version: `2.4.0`
3. Channel: `internal`
4. Run workflow

📖 Detay için / For details: [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md) or [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md)

---

## 📋 Workflow Özeti / Workflow Summary

| Workflow | Type | Nasıl Çalışır / How to Run |
|----------|------|----------------------------|
| **Create or Promote Release** | Release | GitHub Actions (Manuel/Manual) |
| **Reusable Android Build** | Debug | Otomatik PR'da / Auto on PR |
| **Local Gradle Build** | Both | `./gradlew assemble...` |

---

## 🔗 İlgili Dokümantasyon / Related Documentation

- 📖 [RELEASE_PROCESS.md](RELEASE_PROCESS.md) - Tam release süreci / Complete release process
- 📖 [README.md](README.md) - Proje genel bakış / Project overview
- 📖 [CONTRIBUTING.md](CONTRIBUTING.md) - Katkıda bulunma rehberi / Contributing guide
- 📖 [AGENT.md](AGENT.md) - Proje yapısı ve komutlar / Project structure and commands

---

## ❓ Sık Sorulan Sorular / Frequently Asked Questions

### S: Hangi workflow APK verir? / Q: Which workflow provides APK?
**C / A:** 3 workflow APK verir:
1. **Create or Promote Release** - Release APK'lar (imzalı)
2. **Reusable Android Build** - Debug APK'lar (otomatik)
3. **Local Build** - Her iki tür (manuel)

Detay için / For details: [APK_WORKFLOW_TR.md](APK_WORKFLOW_TR.md)

### S: Nasıl çağırırım? / Q: How do I call it?
**C / A:** 
- **Release için / For Release:** GitHub Actions → Create or Promote Release → Run workflow
- **Debug için / For Debug:** `./gradlew assembleDebug`

Detay için / For details: [APK_WORKFLOW_QUICKREF.md](APK_WORKFLOW_QUICKREF.md)

### S: APK'yı nerede bulabilirim? / Q: Where can I find the APK?
**C / A:**
- **Release:** GitHub Releases sayfası / GitHub Releases page
- **Debug:** `app/build/outputs/apk/` dizini / directory

Detay için / For details: [APK_WORKFLOW_EN.md](APK_WORKFLOW_EN.md)

---

## 📞 Yardım ve Destek / Help and Support

Eğer bu dokümantasyon sorununuzu çözmezse:

If this documentation doesn't solve your issue:

- 💬 **Discord:** https://discord.gg/meshtastic
- 🐛 **GitHub Issues:** https://github.com/kaanyaren/mtastic_android/issues
- 📖 **Forum:** https://github.com/orgs/meshtastic/discussions

---

## 📝 Dokümantasyon Güncellemeleri / Documentation Updates

**Son Güncelleme / Last Updated:** 2025-10-14

**Versiyon / Version:** 1.0.0

**Durum / Status:** ✅ Tamamlandı / Complete

---

## 🤝 Katkıda Bulunma / Contributing

Bu dokümantasyonu geliştirmek için:

To improve this documentation:

1. Issue aç / Open an issue
2. Pull request gönder / Submit a pull request
3. Discord'da tartış / Discuss on Discord

Katkıda bulunma rehberi: [CONTRIBUTING.md](CONTRIBUTING.md)

Contributing guide: [CONTRIBUTING.md](CONTRIBUTING.md)

---

**Not / Note:** Bu dokümantasyon Meshtastic-Android projesinin APK oluşturma süreçlerini açıklar. Genel proje dokümantasyonu için README.md'ye bakın.

**Note:** This documentation explains the APK generation processes for the Meshtastic-Android project. For general project documentation, see README.md.
