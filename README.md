# GradProject

Graduation project. Adaptive HR Game

______________________________________________________________________________________________________________________________

## YAPILACAKLAR

- [x] Karakter sağa sola çektiğin zaman gidecek. 
- [x] Karakter olduğu yerde hafif hareket edecek. (spritekit tutorial da var)
- [ ] Karakter ekranın dışına çıkmasın.
- [ ] Karaktere düzgün asset bul. Assette sağa ve sola koşu olsun.
- [ ] Sağa yada sola sürüklendiğinde karakter yön değiştirebilsin.

- [x] Arkaplan ayarla.
- [x] Score vs alanı yukarıya ayarla.

- [x] Topların asset lerini ayarla.
- [x] Toplar otomatik olarak bi senaryoya göre düşsün.

- [x] Çarpışmaları top rengine göre tespit et.

- [x] Skor label koy çarpışmalara (top renklerine göre) göre skor değişsin.

- [ ] Start scene ayarla.
- [ ] Game Over scene ayarla.
- [ ] Main menu scene ayarla,

- [ ] Renk testi alanı ayarla alta.
- [ ] Stageler arası sceneleri ayarla.

- [ ] Tutorial koy başa.
- [ ] Stage 1: renkli toplar
- [ ] Stage 2: + renk soruları
- [ ] Stage 3: + hız
- [ ] Stage 4: herşeyi koy
- [ ] Pause/ Play butonu koy.

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
______________________________________________________________________________________________________________________________
## GENEL NOTLAR

#### Karakter

- [ ] 1.  Sabit dururken kendi kendine hareket edecek.
- [ ] 2.  Karakter sağa yada sola sürüklenebilecek. Dokunduğumuz yere gidecek. (İlk oyundan bakarak çöz)
- [ ] 3.  Karakter sürüklendiği yöne göre yön değiştirmeli “asset”

#### Etaplar

- [ ] 1.  İlk 5 etap öğrenme olacak. Hangi topun kaç puan verdiği gösterilecek.
- [ ] 2.  Renk sorularının ne olduğu anlatılacak.
- [ ] 3.  5 etaptan sonra oyun başlıyor label ı koy.
- [ ] 4.  5 etap standart düşme hızı 2-3 toplu, renk soruları gördüğünü soruyor.
- [ ] 5.  5 etap standart düşme hızı 2-3 toplu, renk soruları içinde yazanı soruyor.
- [ ] 6.  5 etap topların düşme hızı farklı (az zamanda kararı nasıl değiştiği test ediliyor) renk soruları rastgele bazen gördüğü bazen yazan.

#### Renk soruları

- [ ] 1.  Pachinko daki edit ekranı gibi öne gelsin.
- [ ] 2.  Tasarımı sonraya bırak 2-3 buton koy (label).

#### Toplar

- [ ] 1.  Toplar belirli bir sıraya göre düşecek aynı anda 2 ve 3 top düşme senaryosu olsun
- [ ] 2.  Topların içine şekil yada yazı koy verecekleri özelliklere göre

#### Skor

- [ ] 1.  Bir label ekle topların collisionuna göre farklı puanlar alacak
- [ ] 2.  Renk sorularında da doğru verilen cevaplarda puan alınacak

#### Arka Plan

- [ ] 1.  Daha düzgün sade bir şey ekle

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
