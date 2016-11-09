**UYARI:** Bu yazılım geliştirme aşamasındadır ve kullanım sonucu veri kaybına uğratabilir.

# BootableUSB

Sürükle bırak yöntemiyle kullanılabilir ön yüklemeli usb sürücü oluşturur. Fat32 dosya sistemi türünü destekleyen her işletim sisteminde çalışır.

Bu yazılım aşağıdaki işlevleri yerine getirmek için hazırlanmıştır.
- Usb bellek üzerinden Windows işletim sisteminin yüklenebilmesi
- Usb bellek üzerinde bulunan iso kalıbından Linux dağıtımlarının başlatılması
- Diskte daha önce kurulmuş işletim sistemlerinin başlatılması

## Yükleme
**Ubuntu**
```
sudo add-apt-repository ppa:bugra9/ppa
sudo apt update
sudo apt install bootableusb
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

## Çalışma Şekli
Bu yazılım diğer yazılımlardan farklı olarak hem kurulum hem de veri depolanması şeklinde kullanım için hazırlanmıştır. Yazılım kullanılarak bir defalığına usb bellek hazırlanır.  
**Dikkat:** Aygıt içerisinde bulunan tüm veriler silinecektir.
```
sudo bootableusb --prepare /dev/sdX
```
Bu hazırlama aşamasında yazılım usb belleği fat32 türünde biçimlendirir ve üzerine grubu kurarak ayarlarını yapar.

Bu aşamadan sonra usb bellek istenildiği gibi kullanılabilir. 
Eğer windows kurulmak istenirse kalıp dosyaları usb üzerine çıkarılır ve bilgisayar usb bellekten başlatılır. Grub ekranından Windows kurulumu seçilerek devam edilir. Yükleme bittiğinde ise usb bellek üzerindeki Windows dosyaları silinerek normal kullanıma devam edilir. Dikkat edilecek nokta, usb bellek içindeki grub klasörü silinmemelidir.

Linux dağıtımı kurmak ya da canlı olarak başlatmak için linux kalıbı direk linux.iso ismiyle usb belleğin içine kopyalanır. Bilgisayar usb bellekten başlatılarak grub ekranından Linux kalıbından başlatma seçilerek devam edilir. Kullanım bitince bellek üzerindeki bu iso dosyası silinip kullanıma devam edilir.

Eğer disk üzerindeki grub silinir ya da bozulursa, disk üzerindeki işletim sistemleri usb bellek üzerinden başlatılabilir. Bunun için bilgisayarı usb bellekten başlattıktan sonra grub ekranından diskte bulunan bir işletim sistemi seçilerek devam edilir.

## Kullanım Senaryoları

### Ubuntu yanına Windows kurma

İlk önce usb belleğimizin /dev/sdX biçiminde olan ismini öğrenmek için bilgisayara bağlı olan aygıtlar listelenir.
```
bootableusb --listDevices
```

Eğer daha önce yazılım hiç çalıştırılmadıysa ya da usb belleğin yapısı bozulduysa önce hazırlık yapılır.  
**Dikkat:** Aygıt içerisinde bulunan tüm veriler silinecektir.
```
sudo bootableusb --prepare /dev/sdX
```

Daha sonra Windows dosyaları usb belleğe kopyalanır. Eğer bu kopyalama işlemi elle yapılmak istenmiyorsa yazılım aracılığı ile yapılabilir.
```
sudo bootableusb --extract ~/windowsIsoPath.iso /dev/sdX
```

Artık her şey hazır. Bilgisayar usb bellekten başlatılarak grub ekranında Windows kurulumu seçilir ve Windows kurulur.

Windows kurulumu tamamlandıktan sonra grub yerine Windows'un kendi başlatıcısı yüklenecektir. Diskteki linux dağıtımlarına ulaşabilmek için grub yeniden kurulmalıdır. Bunun için bilgisayar usb bellekten başlatılarak grub ekranından diskte yüklü olan bir linux dağıtımı seçilerek açılır. Sürekli usb bellekten başlatmamak için bu diske grub tekrardan kurulur.
```
sudo bootableusb --repairGrub /dev/sdY
```

### Ubuntu yanına başka bir linux dağıtımı kurma

Eğer daha önce yazılım hiç çalıştırılmadıysa ya da usb belleğin yapısı bozulduysa önce hazırlık yapılır.  
**Dikkat:** Aygıt içerisinde bulunan tüm veriler silinecektir.
```
sudo bootableusb --prepare /dev/sdX
```

Daha sonra kurulacak dağıtımın kalıp dosyası usb belleğe linux.iso ismiyle kopyalanır ve bilgisayar usb bellekten başlatılır. Grub ekranından Linux kalıbından başlatma seçilerek devam edilir.

### Ubuntu'nun bozulması sonucu kurtarma işlemi için başka bir linux dağıtımını kullanma
Yukarıdaki adımlar ile gerçekleştirilir.


## Seçenekler

```
bootableusb [SEÇENEKLER]... AYGIT

AYGIT: Genellikle /dev/sdb, /dev/sdc gibi /dev/sdX biçiminde usb belleği gösteren aygıt adı. 
bootableusb --listDevices komutuyla bağlı aygıtlar listelenip ilgili aygıt adı öğrenilir.

--prepare: 
	Usb belleği biçimlendirir ve grubu kurar.
	Dikkat: Aygıt içerisinde bulunan tüm veriler silinecektir.

--format: 
	Usb belleği biçimlendirir.
	Dikkat: Aygıt içerisinde bulunan tüm veriler silinecektir.

--installGrub: 
	Eğer usb belleğin yapısı uygunsa grubu kurar.

--extract isoPath: 
	Eğer usb bellekte grub bulunuyorsa belirtilen iso kalıbını belleğe açar.

--updateGrub: 
	Usb bellekte bulunan grubun ayarlarını günceller.

--repairGrub: 
	Disk üzerindeki silinen / bozulan grubu tamir eder.


-v, --verbose:
	Her adımda ne yapıldığını açıklar.

-h, --help:
	Yardım dosyasını görüntüler

--version:
	Sürüm bilgisini gösterir.

-l, --listDevices:
	Bilgisayara bağlı olan aygıtları listeler.
```

## Notlar
Lisans: GPLv3

https://github.com/slacka/WinUSB projesindeki bazı kodlar kullanılmıştır.