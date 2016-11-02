**UYARI:** Bu yazılım geliştirme aşamasındadır ve kullanım sonucu veri kaybına uğratabilir.

# BootableUSB

Sürükle bırak yöntemiyle kullanılabilir önyüklemeli usb sürücü oluşturur. Fat32 dosya sistemi türünü destekleyen her işletim sisteminde çalışır.

Bu yazılım aşağıdaki işlevleri yerine getirmek için hazırlanmıştır.
- Usb bellek üzerinden Windows işletim sisteminin yüklenebilmesi
- Usb bellek üzerinde bulunan iso kalıbından Linux dağıtımlarının başlatılması
- Diskte daha önce kurulmuş işletim sistemlerinin başlatılması

Bu işlemlerin her işletim sistemi üzerinde yapılabilmesine olanak sağlar.

## Çalışma Şekli
Bu yazılım diğer yazılımlardan farklı olarak hem kurulum hem de veri depolanması şeklinde kullanım için hazırlanmıştır. Yazılım kullanılarak bir defalığına usb bellek hazırlanır. 
```
sudo bootableusb --prepare /dev/sdb
```
Bu hazırlama aşamasında yazılım usb belleği fat32 türünde biçimlendirir ve üzerine grubu kurarak ayarlarını yapar.

Bu aşamadan sonra usb bellek istenildiği gibi kullanılabilir. 
Eğer windows kurulmak istenirse kalıp dosyaları usb üzerine çıkarılır ve bilgisayar bellekten başlatılır. Grub ekranından Windows kurulumu seçilerek devam edilir. Yükleme bittiğinde ise bellek üzerindeki Windows dosyaları silinerek normal kullanıma devam edilir.

Linux dağıtımı kurmak ya da canlı olarak başlatmak için linux kalıbı direk linux.iso ismiyle usb belleğin içine kopyalanır. Bilgisayar bellekten başlatılarak grub ekranından Linux kalıbından başlatma seçilerek devam edilir. Kullanım bitince bellek üzerindeki bu iso dosyası silinip kullanıma devam edilir.

Eğer disk üzerindeki grub silinir ya da bozulursa, disk üzerindeki işletim sistemleri usb bellek üzerinden başlatılabilir. Bunun için bilgisayarı usb bellekten başlattıktan sonra grub ekranından Diskteki işletim sistemini başlatma seçilerek devam edilir.

## Kullanım Senaryoları

### Ubuntu yanına Windows kurma

Eğer daha önce yazılım hiç çalıştırılmadıysa ya da belleğin yapısı bozulduysa önce bellek hazırlığı yapılır.
```
sudo bootableusb --prepare /dev/sdb
```

Daha sonra Windows dosyaları usb belleğe kopyalanır. Eğer bu kopyalama işlemi elle yapılmak istenmiyorsa yazılım aracılığı ile yapılabilir.
```
sudo bootableusb --extract /dasda.iso /dev/sdb
```

Artık her şey hazır. Bilgisayar usb bellekten başlatılarak grub ekranında Windows kurulumu seçilir ve Windows kurulur.

Windows kurulumu tamamlandıktan sonra grub yerine Windows'un kendi başlatıcısı yüklenecektir. Diskteki linux dağıtımlarına ulaşabilmek için grub yeniden kurulmalıdır. Bunun için bilgisayar usb bellekten başlatılarak grub ekranında Diskteki işletim sistemini başlat seçeneği seçilir ve yüklü olan linux dağıtımı açılır. Sürekli bellekten başlatmamak için bu diske grub tekrardan kurulur.
```
sudo bootableusb --repairGrub /dev/sda
```

### Ubuntu yanına başka bir linux dağıtımı kurma

Eğer daha önce yazılım hiç çalıştırılmadıysa ya da belleğin yapısı bozulduysa önce bellek hazırlığı yapılır.
```
sudo bootableusb --prepare /dev/sdb
```

Daha sonra kurulacak dağıtımın kalıp dosyası usb belleğe linux.iso ismiyle kopyalanır ve bilgisayar usb bellekten başlatılır. Grub ekranından Linux kalıbından başlatma seçilerek devam edilir.

### Ubuntu'nun bozulması sonucu kurtarma işlemi için başka bir linux dağıtımını kullanma
Yukarıdaki adımlar ile gerçekleştirilir.


## Seçenekler

bootableusb [SEÇENEKLER]... AYGIT

AYGIT: Genellikle /dev/sdb, /dev/sdc gibi /dev/sdX biçiminde usb belleği gösteren aygıt adı

--prepare: 
	Usb belleği biçimlendirir ve grubu kurar.

--format: 
	Usb belleği biçimlendirir.

--installGrub: 
	Eğer usb belleğin yapısı uygunsa grubu kurar.

--extract isoPath: 
	Eğer bellekte grub bulunuyorsa belirtilen iso kalıbını belleğe açar.

--updateGrub: 
	Bellekte bulunan grubu günceller.

--repairGrub: 
	Disk üzerindeki silinen / bozulan grubu tamir eder.


-h, --help:
	Yardım dosyasını görüntüler

-v, --verbose:
	Her adımda ne yapıldığını açıklar.

--version:
	Sürüm bilgisini gösterir.

--listDevices:
	Bilgisayara bağlı olan aygıtları listeler.

## Notlar
https://github.com/slacka/WinUSB projesindeki bazı kodlar kullanılmıştır.