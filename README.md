# AdPlus iOS SDK Geliştirici Kılavızı

Bu kılavuz AdPlus iOS SDK kullanımına ait geliştiricilerin ihtiyaç duyacağı bilgileri içermektedir.



- [iOS SDK  Entegrasyonu](#setup)
  - [CocoaPods entegrasyonu](#include-the-sdk)
  - [SDK'nın yüklenmesi](#setup-the-sdk)
- [SDK konfigürasyonu](#add-new-banner)
- [Reklam Oluşturma](#add-new-banner)
  - [1 - Banner Reklam Oluşturma](#init-banner)
    - [Genel Bilgiler](#info-banner)
    - [Reklam İsteği Oluşturma](#banner-parameters)
    - [Reklamların Gösterilmesi ve Geri bildirim methodları](#banner-parameters)
  - [2 - Interstitial Reklam Oluşturma](#init-interstitial)
    - [Genel Bilgiler](#info-banner)
    - [Reklam İsteği Oluşturma](#banner-parameters)
    - [Reklamların Gösterilmesi ve Geri bildirim methodları](#banner-parameters)
- [Gereklilikler](#debugging)

<a name="setup"/>

## iOS SDK  Entegrasyonu

Bu bölümde iOS uygulamanıza AdPlus reklamlarını ekleyebilmeniz için gereken adımlar yer almaktadır.


<a name="include-the-sdk"/>

## SDK'nın yüklenmesi

SDK'yı uygulamanıza eklemek için CocoaPods entegrasyonunu tamamlamanız gerekmektedir. Detaylı bilgi için [CocoaPods](https://cocoapods.org/) sayfasını inceleyebilirsiniz.

POD dosyanızı oluşturduktan sonra, aşşağıdaki satırı bu dosyaya eklemeniz gerekmektedir.

```
pod 'ssp-ios-sdk-public'
```

Ardından;

```
$ pod install
```
komutunu çalıştırdığınızda SDK yüklenecektir.


```
import sspadsdk
import sspadkit
```

SDK yi yukarıda belirtilen satırları projenize ekledikten sonra kullanmaya başlayabilirsiniz.

<a name="#setup-the-sdk"/>

## SDK'nın yüklenmesi

SDK nın modüllerine erişmek için ilk önce InventoryID'niz ve AdUnitID'niz ile konfigürasyon dosyanızı oluşturmalısınız. Ardından SSPAdkit nesnemizi oluşturnak için 
kullanılacak. 

```
let config = SSPAdKitConfig(_inventoryID: "XXXXXXXXX", _adUnitID: "XXXXXXXXX")
let adManager = SSPAdKit.init(_config: config)
```
