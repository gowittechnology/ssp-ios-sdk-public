# AdPlus iOS SDK Geliştirici Kılavızı

Bu kılavuz **AdPlus** iOS SDK kullanımına ait geliştiricilerin ihtiyaç duyacağı bilgileri içermektedir.


[Örnek Uygulama](https://github.com/gowittechnology/ssp-ios-sdk-public/tree/main/example)

[Örnek Kod Dosyaları](https://github.com/gowittechnology/ssp-ios-sdk-public/tree/main/sspadsdk/Samples)


- [iOS SDK  Entegrasyonu](#setup)
  - [CocoaPods entegrasyonu](#include-the-sdk)
  - [SDK'nın yüklenmesi](#setup-the-sdk)
- [SDK konfigürasyonu](#sdk-config)
- [Reklam Oluşturma](#create-add)
  - [1 - Banner Reklam Oluşturma](#init-banner)
    - [Genel Bilgiler](#info-banner)
    - [Reklam İsteği Oluşturma](#req-banner)
    - [Reklamların Gösterilmesi ve Geri bildirim methodları](#callback-banner)
  - [2 - Interstitial Reklam Oluşturma](#init-interstitial)
    - [Genel Bilgiler](#info-interstitial)
    - [Reklam İsteği Oluşturma](#req-interstitial)
    - [Reklamların Gösterilmesi ve Geri bildirim methodları](#callback-interstitial)
- [Gereklilikler](#req)

<a name="setup"/>

# iOS SDK  Entegrasyonu

Bu bölümde iOS uygulamanıza **AdPlus** reklamlarını ekleyebilmeniz için gereken adımlar yer almaktadır.


<a name="include-the-sdk"/>

## CocoaPods entegrasyonu

SDK'yı uygulamanıza eklemek için **CocoaPods** entegrasyonunu tamamlamanız gerekmektedir. Detaylı bilgi için [CocoaPods](https://cocoapods.org/) sayfasını inceleyebilirsiniz.

**POD** dosyanızı oluşturduktan sonra, aşşağıdaki satırı bu dosyaya eklemeniz gerekmektedir.

```
pod 'ssp-ios-sdk-public'
```

Ardından;

```
$ pod install
```
komutunu çalıştırdığınızda SDK yüklenecektir.


```swift
import sspadkit
```

SDK yi yukarıda belirtilen satırları projenize ekledikten sonra kullanmaya başlayabilirsiniz.

<a name="setup-the-sdk"/>

## SDK'nın yüklenmesi

**SDK** nın modüllerine erişmek için ilk önce **InventoryID**'niz ve **AdUnitID**'niz ile konfigürasyon dosyanızı oluşturmalısınız. Ardından **SSPAdkit** nesnemizi oluşturmak için aşşağıda ki örnek kodu kullanabilirsiniz.

```swift
let config = SSPAdKitConfig(_inventoryID: "XXXXXXXXX", _adUnitID: "XXXXXXXXX")
let adManager = SSPAdKit.init(_config: config)
```

<a name="sdk-config"/>

# SDK konfigürasyonu

Bu bölümde iOS uygulamanızda **AdPlus** reklamlarını özelleştirmeniz için gereken adımlar yer almaktadır.

Reklam isteklerini özelleştirmek için yarattığımız **SSPAdkit** nesnesi üzerindeki **.config** değişkenini kullanabilirsiniz.

Özelleştirmek için kullanılan parametreler aşşağıdaki gibidir.

```swift
    public var yearOfBirth : Int?               //Cihaz sahibinin doğum yılı.
    public var gender : GenderTypes = .unknown  //Cihaz sahibinin cinsiyeti.
    public var categories:[String:String] = [:] //Sayfa iceriğinin IAB kategorileri.
    public var latitude : String?               //Eğer cihaz konum alıyorsa enlem verisi.
    public var longtitude : String?             //Eğer cihaz konum alıyorsa boylam verisi.
    public var customdata:[String:String] = [:] //Geliştiricinin göndermek istediği diğer datalar. Key-Value Dizisi
    public var applicationVersion : String?     //Uygulamanın versiyonu.
    public var language : String?               //Alpha-2/ISO 639-1
```
Bu parametrelir reklam isteği oluşturmadan önce belirlemelisiniz.

Konfigürasyon nesnesi üzerinden SDK davranışlarını özelleştirmek için aşşağıdaki parametreleri kullanabilirsiniz.

```swift
    public var shouldAskForIDFA = false   //SDK idfa bilgisi toplamak için kullanıcıdan izin sormasını yönetmek için kullanılır
    public var addTimeOutInterval : Int?  //Reklam istekleri için time-out süresi. - Varsayılan ve Alt değer = 30
```
Bu parametreleri SDK nesnenizi oluşturmadan önce belirlemelisiniz.

<a name="create-add"/>

# Reklam Oluşturma

Bu bölümde iOS uygulamanızda **AdPlus** reklamlarını oluşturmanız için gereken adımlar yer almaktadır.

<a name="init-banner"/>

## 1 - Banner Reklam Oluşturma

<a name="info-banner"/>

### Genel Bilgiler

**Banner** reklamlar sayfanızın içeriğine dahil olacak şekilde görünecek ebatları ve pozisyonu belirlenebilen **statik görünümlü** reklamlardır. Bir sayfada **birden çok** banner reklam yer alabilir. 

<a name="req-banner"/>

### Reklam İsteği Oluşturma

**Banner** reklam isteği oluşturmadan önce yarattığımız **SSPAdkit** nesnesi üzerindeki **.bannerDelegate** parametresine **BannerAdDelegate** protokolünü uyguladığınız sınıfınızı belirtmelisiniz.

Bu protokol aşşağıdaki gibi tanımlanmıştır.

```swift
    protocol BannerAdDelegate: NSObjectProtocol {
    
      func addReceived(forBanner adItem: SSPBannerAd)
      func failedToLoadAdd(forBanner adItem: SSPBannerAd, reason: SSPResult)
    
      @objc optional func addWillAppear(forBanner adItem: SSPBannerAd)
    }
```

Bu parametreyi belirledikten sonra reklam isteğinizi aşşağıdaki methodu çağırarak oluşturabilirsiniz.

```swift
    public func requestBanner(for _size:SSPBannerSizes, _identifier : Int? = nil) -> SSPRequestResponse {}
```

<a name="callback-banner"/>

### Reklamların Gösterilmesi ve Geri bildirim methodları

Reklam isteğiniz başarılı bir şekilde oluşturulduktan sonra, bu isteğin sonucu **BannerAdDelegate** protokolünü uyguladığınız sınıfınıza iletilecektir.

Reklam isteğiniz sonucunda, gösterilecek reklam olması halinde

```swift
    func addReceived(forBanner adItem: SSPBannerAd)
```
methodu çağırılacaktır.

Bu aşamada reklamı göstermek istedğiniz **UIView** objenizi SDK ya göndermeniz gerekmektedir. Bu işlem için bu kod örneği aşşağıdaki gibidir.

```swift
    func addReceived(forBanner adItem: SSPBannerAd) {
        adItem.show(in: bannerContainerView )
    }
```

Reklam isteğiniz sonucunda ya da reklam gösterilmesi sırasında bir hata oluşması halinde

```swift
    func failedToLoadAdd(forBanner adItem: SSPBannerAd, reason: SSPResult)
```
methodu çağırılacaktır.

Reklam isteği ile ilgili tüm işlemler tamamlandıktan sonra, reklam nesnesi arayüze eklenmeden hemen önce eğer uygulandı ise

```swift
    @objc optional func addWillAppear(forBanner adItem: SSPBannerAd)
```
methodu çağırılacaktır. 

<a name="init-interstitial"/>

## 2 - Interstitial Reklam Oluşturma

<a name="info-interstitial"/>

### Genel Bilgiler

**Interstitial** reklamlar çalıştığı uygulamanın tümünü kaplayacak şekilde görünecek **dinamik görünümlü** reklamlardır. Bir sayfada **sadece bir** interstitial reklam yer alabilir. 

<a name="req-interstitial"/>

### Reklam İsteği Oluşturma

**Interstitial** reklam isteği oluşturmadan önce yarattığımız **SSPAdkit** nesnesi üzerindeki **.popUpDelegate** parametresine **PopUpAdDelegate** protokolünü uyguladığınız sınıfınızı belirtmelisiniz.

Bu protokol aşşağıdaki gibi tanımlanmıştır.

```swift
    protocol PopUpAdDelegate: NSObjectProtocol {
    
      func addReceived(forPopUp adItem: SSPPopUpAd)
      func failedToLoadAdd(forPopUp adItem: SSPPopUpAd, reason: SSPResult)
      func closePopUp(forPopUp adItem: SSPPopUpAd)
    
      @objc optional func addWillAppear(forPopUp adItem: SSPPopUpAd)
    }
```

Bu parametreyi belirledikten sonra reklam isteğinizi aşşağıdaki methodu çağırarak oluşturabilirsiniz.

```swift
    public func requestPopup(for _size:SSPPopUpSizes, _identifier : Int? = nil) -> SSPRequestResponse {}
```

<a name="callback-interstitial"/>

### Reklamların Gösterilmesi ve Geri bildirim methodları

Reklam isteğiniz başarılı bir şekilde oluşturulduktan sonra, bu isteğin sonucu **PopUpAdDelegate** protokolünü uyguladığınız sınıfınıza iletilecektir.

Reklam isteğiniz sonucunda, gösterilecek reklam olması halinde

```swift
    func addReceived(forPopUp adItem: SSPPopUpAd)
```
methodu çağırılacaktır.

Bu aşamada reklamı göstermek istedğiniz **UIView** objenizi SDK ya göndermeniz gerekmektedir. Bu işlem için bu kod örneği aşşağıdaki gibidir.

```swift
    func addReceived(forPopUp adItem: SSPPopUpAd) {
        adItem.show(in: popUpContainerView)
    }
```

Reklam isteğiniz sonucunda ya da reklam gösterilmesi sırasında bir hata oluşması halinde

```swift
    func closePopUp(forPopUp adItem: SSPPopUpAd)
```
methodu çağırılacaktır.

Reklam gösterildikten sonra, kullanıcı kapatma düğmesine bastığında

```swift
    func failedToLoadAdd(forPopUp adItem: SSPPopUpAd, reason: SSPResult)
```
Reklam isteği ile ilgili tüm işlemler tamamlandıktan sonra, reklam nesnesi arayüze eklenmeden hemen önce eğer uygulandı ise

```swift
    @objc optional func addWillAppear(forBanner adItem: SSPBannerAd)
```
methodu çağırılacaktır. 

<a name="#req"/>

# Gereklilikler

- iOS 10.0 ve üzeri
- Xcode 12.5 ve üzeri
- Swift 5

 
