# GradProject

Graduation project. Adaptive HR Game

______________________________________________________________________________________________________________________________

## YAPILACAKLAR

- [x] Karakter sağa sola çektiğin zaman gidecek. 
- [x] Karakter olduğu yerde hafif hareket edecek. (spritekit tutorial da var)
- [ ] Karakter ekranın dışına çıkmasın.
- [-] Karaktere düzgün asset bul. Assette sağa ve sola koşu olsun. --
- [-] Sağa yada sola sürüklendiğinde karakter yön değiştirebilsin. --

- [x] Arkaplan ayarla.
- [x] Score vs alanı yukarıya ayarla.

- [x] Topların asset lerini ayarla.
- [x] Toplar otomatik olarak bi senaryoya göre düşsün.

- [x] Çarpışmaları top rengine göre tespit et.

- [x] Skor label koy çarpışmalara (top renklerine göre) göre skor değişsin.

- [x] Start scene ayarla.
- [x] Game Over scene ayarla.
- [x] Main menu scene ayarla,

- [x] Renk testi alanı ayarla alta.
- [x] Stageler arası sceneleri ayarla.

- [ ] Tutorial koy başa.
- [x] Stage 1: renkli toplar
- [x] Stage 2: + renk soruları
- [x] Stage 3: + hız
- [x] Stage 4: herşeyi koy
- [x] Pause/ Play butonu koy.

______________________________________________________________________________________________________________________________

## AYŞE HOCA ile görüşmeden notlar:

- Yukardan düşen topları rastgele yapabiliriz.
- Düşen toplar arasından en iyi senaryoyu hesaplayıp ona göre biz değerlendirebilriz.
- Stageler halinde olsun oyun gittikçe zorlaşsın.
  - Stage 0: Tutorial
  - Stage 1: Sadece renkli toplar düşecek, 
  - Stage 2: Renkli toplar ve renk testi eklenecek
  - Stage 3: Renkli toplar, renk testi ve hız eğişimi eklenecek.
- Topların rengine göre kendi kodlamasın, bazen kırmızı bazen yeşil riskli top olsun. 
- Riskli topun üzerinde bir işaret olsun.
- Arkadaşınla görüş stageler nasıl olmalı konuş.
- Farklı toplar olsun bonus veren hızı yavaşlatan vs
- Tek top düşmeli sıralar da olsun.
- Renk soru testleri alta pencere açılacak orda olsun. "Stroop Effect"
- Renk soru testi altta yazı rengi yada yazıda yazan kelime şeklinde olsun. 
- Topu alana kadar soru yazacak topu alınca pencere açılacak soru seçilecek.

______________________________________________________________________________________________________________________________
Stroop Effect - Alttaki Renk Testi Kısmı:


Butonların arkaplanları ile içinde yazan renkler farklı olacak:
blue-cyan-green-grey-purple-red-yellow : 7 renk buton arka planları
içindeki yazılar ise beyaz(arkaplan renginde) olacak

kullanıcı seçtiği topun renginin yazısını yada rengi işaretleyecek !! 

doğruysa + puan alacak.
-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
Stageler:

bouncer && spark = + bonus puanlar +10 +15 puan

her topun kendi puanı var +1 +2 +3 0 -1 -2 -3

içinde yazan X değerine göre ve X değeri aralığına göre puan verecek.
Örnekler değerler:
0x = puan değeri * 0        
1x = puan değeri * 1    -1x = puan değeri * -1
3x = puan değeri * 3    -3x = puan değeri * -3

Örnek top içerikleri:
0x .. 1x
0x .. 3x
-1x .. 1x
-3x .. 3x

Her kombinasyonun hazır asseti olacak ve unique adı olacak ve bu duruma göre unique risk katsayıları bulunacak

Lane Generator: Risk katsayılarına göre yeni laneler oluşturacak. 
Adaptive kısmı: ilk durumda eski tecrübelerine ve yaşına göre ilk stage i set edecek
Daha sonra yapılan seçimlere göre Lane Generator e o katsayıyı gönderecek. 

alternatifi -> ilk olarak yapılacak: bart a benzet 0 yada puan alıyorsun
yukarda skala olsun o sıraya göre riskin arttığını bilsin. risk katsayıları artsın 0 alma olasılığı. 

______________________________________________________________________________________________________________________________
## GENEL NOTLAR

#### Karakter

- [x] 1.  Sabit dururken kendi kendine hareket edecek.
- [x] 2.  Karakter sağa yada sola sürüklenebilecek. Dokunduğumuz yere gidecek. (İlk oyundan bakarak çöz)
- [ ] 3.  Karakter sürüklendiği yöne göre yön değiştirmeli “asset”

#### Etaplar

- [x] 1.  İlk 5 etap öğrenme olacak. Hangi topun kaç puan verdiği gösterilecek.
- [x] 2.  Renk sorularının ne olduğu anlatılacak.
- [x] 3.  5 etaptan sonra oyun başlıyor label ı koy.
- [x] 4.  5 etap standart düşme hızı 2-3 toplu, renk soruları gördüğünü soruyor.
- [x] 5.  5 etap standart düşme hızı 2-3 toplu, renk soruları içinde yazanı soruyor.
- [x] 6.  5 etap topların düşme hızı farklı (az zamanda kararı nasıl değiştiği test ediliyor) renk soruları rastgele bazen gördüğü bazen yazan.

#### Renk soruları

- [x] 1.  Pachinko daki edit ekranı gibi öne gelsin.
- [x] 2.  Tasarımı sonraya bırak 2-3 buton koy (label).

#### Toplar

- [x] 1.  Toplar belirli bir sıraya göre düşecek aynı anda 2 ve 3 top düşme senaryosu olsun
- [x] 2.  Topların içine şekil yada yazı koy verecekleri özelliklere göre

#### Skor

- [x] 1.  Bir label ekle topların collisionuna göre farklı puanlar alacak
- [x] 2.  Renk sorularında da doğru verilen cevaplarda puan alınacak

#### Arka Plan

- [x] 1.  Daha düzgün sade bir şey ekle

#### Puanlama [ Yardım iste, Düşünülecek!! ] 

Yeşil klasik +2 puan Kırmızı -+15 Risk alıp başarısız olduklarında aynı riski almaya devam ediyorlar mı bunu gözleyeceğiz. Yada risk alıp başarılı olduklarında bu durumu nasıl değiştiriyor. Olayımız yüksek puan aldırmakmış gibi gösterip. Verdiği kararları incelmek.

#### Müzik

- [ ] 1.  Çarpışmalara müzik ekle
- [ ] 2.  Arkaplan müziği ekle
- [ ] 3.  Renk sorularında müzik değiş dursun vs.

## ÖNEMLİ LİNKLER

#### 1.  Örnek Kaynaklar 
a. Benzer oyun yağmur düşüyor vs.  [https://www.smashingmagazine.com/2016/11/how-to-build-a-spritekit-game-in-swift-3-part-1/](https://www.smashingmagazine.com/2016/11/how-to-build-a-spritekit-game-in-swift-3-part-1/)  
b. Pachinko, güzel tutorial  [https://www.hackingwithswift.com/read/11/overview](https://www.hackingwithswift.com/read/11/overview)  
c. Güzel tutorial 
[http://spritekitlessons.com/swift-3-and-sprite-kit-tutorial-part-1-the-sprite-kit-starting-template/#](http://spritekitlessons.com/swift-3-and-sprite-kit-tutorial-part-1-the-sprite-kit-starting-template/#)
d. İncelenmeli  [https://subscription.packtpub.com/book/game_development/9781784393557/4](https://subscription.packtpub.com/book/game_development/9781784393557/4)

#### 2.  Game Over - Main Menu Scene ekleme: 
a.  [https://subscription.packtpub.com/book/game_development/9781784393557/4](https://subscription.packtpub.com/book/game_development/9781784393557/4)  
b. 
[https://stackoverflow.com/questions/33321071/swift-spritekit-how-to-restart-gamescene-after-game-over-stop-lagging](https://stackoverflow.com/questions/33321071/swift-spritekit-how-to-restart-gamescene-after-game-over-stop-lagging)

______________________________________________________________________________________________________________________________
## GELİŞTİRME NOTLARI

PLAY PAUSE - > 
butonları timer ı bozduğu için timer ın ayarlanması gerek en son yapılacak.

TUTORIAL - > 
Top yakalacıkça bir sonraki top yollanıyor eğer yakalayamazsa baştan başlayacak
20 sıra top yakalamayı tam bitirene kadar tekrar başlatacak
Statik yolluyoruz top kaçarsa uyarı verecek vs. 

STAGE 1 ->
[x] random line generator de tekrar aynı renk üretmeyi durdur.

++ ANA MENUYE DÖN BUTONU -> koy ok

STAGE 2 -> 
hallolacak düşün

STAGE 3 TIMER // TAM ÇÖZ 
[x] didset ile label a ekleyeceğiz scheduled timer bi count ı artıracak her sn de onu yazacağız anlık olarak

LEADERBOARDS
userdefault a kaydedilecek multi array olarak
textfield lazım bunun için hepsi birlikte

BİRDEN FAZLA TOP ALMA SORUNU // ÇÖZĞLECEK BASİT
bir çarpışma detect edilince Z değerini değiştir. karakterin Z değerini değiştir.

Bir line daki top sayısının randomluğunu da biz bi random generator ile ayarlayalım. yaklaşık olarak bilelim.

MUZİK EKLE bg muziği ve puan durumuna göre farklı sesler eklenmeli.

STAGE 3- timer koymak çok mantıklı olmadı
orada renk testi sorularını karıştırabiliriz
kiminde rengi seç kiminde yazıyı seç şeklinde olursa 
kuralı ezberleyerek de devam edemez.


______________________________________________________________________________________________________________________________
## Bitirme Görüşmesi 
## 30.10.2019

- Stage 3 düzenlenmesi. Hem renk hem yazı seçimi [ ], seçim süresi gittikçe azalan [ ].

- Stage 2 düzenlenmesi. Seçim süresi sabit 3 sn [-test-]. Timer görünecek ekranda [-test-]. Risk alıp puan kazanamadığında animasyon renk değişimi vb efekt [x]. Risk alıp kazanamadığında puanında %k düşme [ ]. 

- Pause çalışmıyordu, düzelecek [-test-]. Oyun başlamadan soruyu verip ileri diyince başlayacak [x]. 

- Alttaki topların skor ve risk değerleri gösterilecek [ ]. 

- Hipotez – psikoloji açısından nedir? [ ]

______________________________________________________________________
- Aklıma geldi YAP1 - > Ayşe Hocaya sor.
CAN: seçim süresi max 3sn -> ne kadar erken seçerse o kadar çok puan alsın
Doğru:
1sn de seçer ve doğru bilirse 10 
2sn de seçer ve doğru bilirse 5
3sn de seçer ve  doğru bilirse 3
Yanlış:
1sn de seçer yanlış yaparsa - 1 yada - 5
2sn de seçer yanlış yaparsa - 2 yada - 3
3sn de seçer yanlış yaparsa - 3 yada - 1

-> bu fazla - alma korkusundan hiç cevap vermemeye götürebilir.
Cevap veremezse de -5 puan

- YAP2
Geri sayım sonucu doğru bilirse bir yeşil olarak puanı bas
Yanlış bilirse kırmızı olarak eksi puanı yaz
Cevap veremezse gri olarak 0 yaz

-YAP3
karakter stage giriş ekranındaki gibi scale olsun top vs aldığında bişeler yapsın 

______________________________________________________________________

------------   Yapılanlar   -------------
[x] Karakter topa değince topta yanma animasyonu
[x] Karakter topa değince karakterde gaz  animasyonu
[x] Oyun başlamadan önce farklı Scene koy bilgi ver ordan stage başlat.
[x] Giriş scene de karakter şekil oldu.
[x] Stage 2 countdown eklendi top yakala butona tıkla arası

___________________
[x][x][x][x][x][x][x][x][x]
MenuScene ile GameScene arasına yeni bir Scene oluştur.
Ordaki messagebox içine stage kurallarını vs belirt.
karakteri de koyabiliriz karakter start a giderse başlat.
küçük bir şekilde start stage X yazısına çarptığında git. 
butonu koy karakter üstüne gidince buton çöksün 1 sn sonra da stage başlasın. 
________________________________________________________________________________________________

## Bitirme Görüşmesi 
## 12.11.2019

- [x] Stage giriş ekranlarındaki metinler ve soru metinleri düzeltilecek.

- [x] Soru yeni toplar düşmeye başladığında gösterilecek. Seçimden sonra kapalı kalacak.


- [x] Stage değişiklikleri:

- [x] Stage 2: 

- [x] Metin eşleme soruları.
- [x] Renk Testi: yanlış cevaba ve boşa ceza yok. 
- [x] Doğru cevap süresine göre fazla puan ver.

- [x] Stage 3: 

- [x] hem renk hem metin eşleme soruları.

- [x] Renk Testi: yanlış cevaba ve boşa ceza yok.
- [x] Doğru cevap süresine göre fazla puan ver.

- [x] Stage 4: ( Yeni Eklenecek )

- [x] hem renk hem metin eşleme soruları.

- [x] Renk Testi: yanlış cevaba ve boşa cezalar başlayacak.
- [x] Doğru cevap süresine göre fazla puan ver.

- [x] Stage Tasarımları:

- [x] Risk değerleri ve puanlar en yukarda olacak. ( Bunun yerine giriş ekranına koyuldu. Stagelerde sadece sıralama olacak )

- [x] Remaining ball sayısını yaz.

- [ ] Verileri Tut:

- [ ] Düşen top seti ve yaptığı seçimi aldığı puanı
- [ ] Buton seçimini kaç saniyede yaptığını

- [x] Karakter aynı anda 2 top almayacak.(physicDelegate nil yapıp tekrar bağlıyorum. alamadığı topla çarpışıp sekiyor.)

Yetişirse:

- [ ] Girişte kullanıcı adı tut.

- [ ] Leaderboards gibi bir şey yap.

- [ ] Müzik koy.

- [ ] Puan alma kısmının tasarımını düzelt. Animasyon vs 1 2 hareket getir.

