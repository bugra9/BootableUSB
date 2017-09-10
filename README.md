**UYARI:** Bu yazılım geliştirme aşamasındadır ve kullanım sonucu veri kaybına uğratabilir.

# BootableUSB v0.5
Ön yüklemeli usb bellek oluşturmayı en kolay hale getiren yazılım. Bir kere yükle bir daha hep ön yüklemeli kalsın felsefesini benimser.

Bu yazılımla oluşturulmuş usb bellek ile yapabilecekleriniz;
- Windows işletim sisteminin yüklenmesi
- Bir ya da birden fazla linux dağıtımından seçilenin başlatılması
- Diskte daha önce kurulmuş işletim sistemlerinin başlatılması

Bu işlemlerin ne kadar kolay yapılabileceğini öğrenmek istiyorsan gel beraber inceleyelim. Öncelikle bir defalığına usb belleği ön yüklemeli hale getirdiğini düşün. Bundan sonra neler yapabileceklerine bakalım.

**Windows işletim sisteminin ayarlanması**  
Usb belleğin içine kurulum dosyalarını at. Evet bu kadar, herhangi bir yazılım çalıştırman gerekmiyor.

**Linux dağıtımının ayarlanması**  
Kalıp dosyasını bootableusb/linux dizini içine at. Cidden bu kadar :)

**Birden fazla linux dağıtımının ayarlanması (MultiBoot)**  
İstediğin dağıtımlara ait kalıp dosyalarını bootableusb/linux dizini içine at. Bu iş garipleşmeye başladı değil mi?

**Canlı olarak kullandığın dağıtımdaki değişikliklerin kaybolmamasını mı istiyorsun?**  
bootableusb/persistent içerisinde bulunan 1024.tar.gz gibi çeşitli boyut isimlendirmesine sahip dosyalardan istediğini oraya çıkart. Tahmin edebileceğin gibi hepsi bu. Eğer yer sıkıntısı çekersen, kullanmayacağın zamanlarda tekrar sıkıştırırsın.

**Bozulmuş gruba rağmen diskteki işletim sistemini başlatma**  
Bilgisayarındaki dağıtım açılmıyor mu, hemen usb bellek üzerindeki grubu kullanarak erişemediğin yüklü dağıtımı başlat.

## Çalışma Mantığı
Farkettin mi bilmiyorum ama bu işlemlerin hiçbirisi için bu yazılımı kullanman gerekmiyor. Tüm işleri sürükle bırak ile yapıyorsun. Gerçekten kolay değil mi?

Gerçekten böyle bir şey olabilir mi diye merak etmeye mi başladın? Çalışma mantığını mı öğrenmek istiyorsun gel beraber inceleyelim. İlk önce şu meşhur yüklememizi yapalım.
```
bootableusb --install /dev/sdX
```
Evet bu komut ne yapıyorda bundan sonra her şey kendiliğinden oluyor. Hemen ne yaptığına bakalım.
- Usb belleği biçimlendirir.
- İçine grubu kurar.
- Grub yapılandırmasını oluşturur. (Sihirli sözcükleri mi söyledim ne)

Evet çok basit görünse de tüm marifet grub yapılandırmasında bitiyor. Grubu öyle bir ayarlıyorsun ki artık grub tüm işlemleri kendisi yönetiyor. Grubun yeteneklerinin farkında olmayanlar için bu yazılımla yapabileceklerini göstermek istedim. Madem her şeyi anladık bir de bu yazılımı bilgisayarımıza nasıl yükleyeceğimize bakalım.

## Yükleme
**Ubuntu**
```
sudo add-apt-repository ppa:bugra9/ppa
sudo apt-get update
sudo apt-get install bootableusb
```

**Arch Linux**
```
yaourt -S bootableusb
```

**Diğer dağıtımlar için**
```
make
sudo make install
```
komutlarıyla yüklenir. Silmek isterseniz
```
sudo make uninstall
```
komutuyla silebilirsiniz.

**Yüklemeden Çalıştırma**  
Yazılımı isterseniz yüklemeden kullanabilirsiniz. Bu durumda dil İngilizce olacaktır. 
```
./bootableusb
```

## Desteklenen Dağıtımlar
- Ubuntu tabanlı dağıtımlar (Ubuntu, Linux Mint, Elementary OS, Zorin OS vs.)
- Debian tabanlı dağıtımlar (Debian, Kali Linux, Tails, Gparted vs.)
- Fedora
- Arch Linux
- Manjaro
- Remix OS (Android Tabanlı)
- Windows

## Seçenekler

```
bootableusb [SEÇENEKLER]... AYGIT

Bir  defalığına usb belleği ön yüklemeli hale getirirsiniz, 
daha sonra yazılıma ihtiyaç duymadan sürükle bırak ile 
windows ve linux dağıtımlarını usb bellek üzerinden başlatırsınız.

AYGIT: Genellikle /dev/sdb, /dev/sdc gibi /dev/sdX biçiminde usb belleği gösteren aygıt adı. 
bootableusb --listDevices komutuyla bağlı aygıtlar listelenip ilgili aygıt adı öğrenilir.

-l, --listDevices:
	Bilgisayara bağlı olan aygıtları listeler.

-i, --install: 
	Usb belleği biçimlendirir, grubu kurar ve yapılandırmasını ayarlar. 
	Kısaca kullanılmaya hazır duruma getirir.
	Dikkat: Aygıt içerisinde bulunan tüm veriler silinecektir.

--type SEÇENEK:
	İstediğiniz türde grub kurulumu yapar.
	bios: -
	uefi: -
	all: her iki grubu da kurar.

--scheme SEÇENEK:
	Aygıtı hangi tablo ile bölümleyeceğinizi seçin.
	mbr: -
	gpt: -
	hybrid: İki tabloyu da barındıracak şekilde ayarlar.

-u, --updateGrub: 
	Usb bellekte bulunan grubun ayarlarını günceller. 
	Bu güncellemeyle hatalar giderilebilir, daha çok dağıtım desteklenebilir.

-r, --repairGrub: 
	Disk üzerindeki silinen / bozulan grubu tamir eder.

-e, --extract KALIPKONUMU: 
	Windows kurulum dosyaları kalıp halinde ise bu komutla kolayca 
	kalıbın içindekiler usb belleğin içine çıkarılır.

-p, --persistent BOYUT:
	Canlı olarak kullanılan dağıtımlar üzerinde yaptığınız değişikliklerin 
	kalıcı olması için bu değişikliklerin kaydedileceği boş bir kalıp dosyasını 
	bootableusb/persistent dizininde oluşturur.
	BOYUT: bu kalıp dosyasının megabyte olarak boyutu. Örn: 1024, 2048, 500

-pr, --resizePersistent BOYUT:
	Değişikliklerin kaydedildiği kalıp dosyasının boyutunu değiştirir.
	BOYUT: bu kalıp dosyasına megabyte olarak ne kadar ekleneceği. Örn: 1024, 2048, 500

--format: 
	Usb belleği biçimlendirir.
	Dikkat: Aygıt içerisinde bulunan tüm veriler silinecektir.

--installGrub: 
	Grubu kurar ve yapılandırmasını ayarlar. Biçimlendirme istenmeyen durumlarda kullanılır.


--verbose:
	Her adımda ne yapıldığını açıklar.

-h, --help:
	Yardım dosyasını görüntüler

-v, --version:
	Sürüm bilgisini gösterir.
```

## Katkıda Bulunma
Bu yazılım açık kaynaklı ve özgürdür. Eğer katkıda bulunmak istiyor ama ne yapacağınızı bilmiyorsanız aşağıdaki maddeler ile fikir edinebilirsiniz.

- Denediğiniz linux dağıtımı çalışmıyorsa hata kaydı açarak bildirebilirsiniz.
- Yazılımın bir yerinde sorun gördüyseniz hata kaydı açarak bildirebilirsiniz.
- Çeviri hatalarını düzeltip yeni çevirilerde bulunabilirsiniz.
- Dökümantasyonları genişletebilir, çevirilerde bulunabilirsiniz.
- Faydalı olabilecek özellikleri bildirebilirsiniz.

Bildirim yapmak için: <https://github.com/bugra9/BootableUSB/issues/new>  
Çeviri Bağlantısı: <https://translations.launchpad.net/bootableusb>  
Çeviri dosyaları: <https://github.com/bugra9/BootableUSB/tree/master/po>  
Man Sayfaları: <https://github.com/bugra9/BootableUSB/tree/master/man>  
Beni Oku Sayfası: <https://github.com/bugra9/BootableUSB/blob/master/README.md>  
Kaynak Kodlar: <https://github.com/bugra9/BootableUSB/blob/master/src/bootableusb>  

## Notlar
**Lisans**  
GPLv3 <https://github.com/bugra9/BootableUSB/blob/master/LICENSE>  
Bu programın KESİNLİKLE HİÇBİR TEMİNATI YOKTUR  

**Yararlanılan Kaynaklar**  
<https://www.gnu.org/software/grub/manual/grub.html>  
<https://github.com/slacka/WinUSB>  
<https://wiki.archlinux.org/index.php/Multiboot_USB_drive>  
<https://help.ubuntu.com/community/Grub2/ISOBoot>  
<https://help.ubuntu.com/community/Grub2/ISOBoot/Examples>  