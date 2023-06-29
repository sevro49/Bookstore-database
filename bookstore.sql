CREATE DATABASE bookstore;

--Delete Existing Tables (if any)
DROP TABLE kitaplar CASCADE;
DROP TABLE kitap_yazar CASCADE;
DROP TABLE yazar CASCADE;
DROP TABLE dil CASCADE;
DROP TABLE yayinevi CASCADE;
DROP TABLE adres CASCADE;
DROP TABLE musteri_adres CASCADE;
DROP TABLE musteri CASCADE;
DROP TABLE sepet CASCADE;
DROP TABLE siparis CASCADE;



CREATE TABLE kitaplar (
	kitap_id INT PRIMARY KEY NOT NULL,
	kitap_ismi VARCHAR(100) NOT NULL,
	isbn VARCHAR(50) NOT NULL,
	sayfa_sayisi INT,
	dil_id INT,
	yayinevi_id INT,
	fiyat NUMERIC(8,2)
);

CREATE TABLE yayinevi (
	yayinevi_id INT PRIMARY KEY,
	yayinevi_adi VARCHAR(255)
);

CREATE TABLE dil (
	dil_id INT PRIMARY KEY,
	dil_adi VARCHAR(50)
);

CREATE TABLE kitap_yazar (
	kitap_id INT PRIMARY KEY NOT NULL,
	yazar_id INT 
);

CREATE TABLE yazar (
	yazar_id INT PRIMARY KEY NOT NULL,
	yazar_adi VARCHAR(50) 
);

ALTER TABLE kitap_yazar
ADD CONSTRAINT kitapYazar_yazar_id_fk
FOREIGN KEY (yazar_id) REFERENCES yazar(yazar_id);

CREATE TABLE siparis(
	siparis_id INT PRIMARY KEY,
	musteri_id INT NOT NULL,
	siparis_tarihi TIMESTAMP,
	siparis_adresi_id INT
);

CREATE TABLE sepet(
	sepet_id INT PRIMARY KEY,
	siparis_id INT NOT NULL REFERENCES siparis(siparis_id),
	kitap_id INT REFERENCES kitaplar(kitap_id),
	adet INT,
	toplam_ucret NUMERIC (8,2)
);

CREATE TABLE musteri(
	musteri_id INT PRIMARY KEY,
	ad VARCHAR(25),
	soyad VARCHAR(25),
	telefon VARCHAR(25),
	email VARCHAR(50)
);

CREATE TABLE adres(
	adres_id INT PRIMARY KEY,
	mahalle VARCHAR(50),
	sokak VARCHAR(50),
	sehir VARCHAR(50),
	ulke VARCHAR(50)
);

CREATE TABLE musteri_adres(
	musteri_id INT PRIMARY KEY,
	adres_id INT REFERENCES adres(adres_id)
);

ALTER TABLE kitaplar
ADD CONSTRAINT kitaplar_dil_id_fk
FOREIGN KEY (dil_id) REFERENCES dil(dil_id);

ALTER TABLE kitaplar
ADD CONSTRAINT kitaplar_yayinevi_id_fk
FOREIGN KEY (yayinevi_id) REFERENCES yayinevi(yayinevi_id);

ALTER TABLE siparis
ADD CONSTRAINT siparis_musteri_id_fk
FOREIGN KEY (musteri_id) REFERENCES musteri(musteri_id);

ALTER TABLE siparis
ADD CONSTRAINT siparis_siparisAdresi_id_fk
FOREIGN KEY (siparis_adresi_id) REFERENCES adres(adres_id);

ALTER TABLE musteri_adres
ADD CONSTRAINT musteri_adres_id_fk
FOREIGN KEY (adres_id) REFERENCES adres(adres_id);

CREATE INDEX idx_kitaplar_id ON kitaplar(kitap_id);
CREATE INDEX idx_musteri_id ON musteri(musteri_id);

INSERT INTO dil (dil_id, dil_adi)
VALUES
(1, 'İngilizce'),
(2, 'Almanca'),
(3, 'Fransızca'),
(4, 'İtalyanca'),
(5, 'Türkçe'),
(6, 'Rusça');

INSERT INTO yazar (yazar_id, yazar_adi)
VALUES
(1, 'George Orwell'),
(2, 'Ray Bradbury'),
(3, 'Victor Hugo'),
(4, 'Stefan Zweig'),
(5, 'Anthony Burgess'),
(6, 'Franz Kafka'),
(7, 'Jack London'),
(8, 'William Golding'),
(9, 'Anton Pavloviç Çehov'),
(10, 'Jose Saramago'),
(11, 'J. R. R. Tolkien'),
(12, 'Tolstoy'),
(13,'Dostoyevski');

INSERT INTO yayinevi(yayinevi_id, yayinevi_adi)
VALUES
(1, 'Can Yayınları'),
(2, 'İş Bankası Kültür Yayınları'),
(3, 'İthaki Yayınları'),
(4, 'Epsilon Yayınları'),
(5, 'Timaş Yayınları'),
(6, 'Metis Yayınları');

INSERT INTO kitaplar (
kitap_id, kitap_ismi, isbn, sayfa_sayisi, dil_id, yayinevi_id, fiyat)
VALUES
(1, '1984', '9750718534', 352, 1, 1, 35.00),
(2, 'Yüzüklerin Efendisi: (Tek Cilt)', '9753423470', 1026, 1, 6, 266.00),
(3, 'Denizin Çağrısı', '9750740637', 160, 3, 4, 26.00),
(4, 'Bir Kuzey Macerası', '6052953438', 56, 3, 4, 13.20),
(5, 'Martin Eden', '6053322121', 528, 3, 4, 38.40),
(6, 'Anna Karenina', '6053604097', 1062, 2, 2, 109.90),
(7, 'Suç ve Ceza', '975458902X', 704, 1, 2, 48.00),
(8, 'Otomatik Portakal', '6052957921', 172, 6, 1, 20.40),
(9, 'Fahrenheit 451', '6053757810', 208, 5, 5, 35.33);

INSERT INTO musteri(musteri_id, ad, soyad, telefon, email)
VALUES 
(1, 'Emre', 'Güler', '555-555-55', 'emre@mail.com'),
(2, 'Elif', 'Güler', '555-000-55', 'elif@mail.com'),
(3, 'Ali', 'Başaran', '252-152-65', 'ali@mail.com'),
(4, 'Mert', 'Gezer', '545-354-99', 'mert@mail.com'),
(5, 'Mimar', 'Sinan', '247-332-77', 'sinan@mail.com'),
(6, 'Sefa', 'Yıldız', '478-555-71', 'sefa@mail.com'),
(7, 'Yasin', 'İlgün', '909-852-21', 'yasin@mail.com');

INSERT INTO adres(adres_id, mahalle, sokak, sehir, ulke)
VALUES 
(1, 'Ferah', 'Gezer', 'İstanbul', 'Türkiye'),
(2, 'Cumhuriyet', 'Uluhan', 'İstanbul', 'Türkiye'),
(3, 'Esatpaşa', 'Pınar', 'İstanbul', 'Türkiye'),
(4, 'Çakmak', 'Yayla', 'Ankara', 'Türkiye'),
(5, 'Ataşehir', 'Taşlıbayır', 'İzmir', 'Türkiye'),
(6, 'Bradford', 'St. John', 'Manchester', 'İngiltere'),
(7, 'Ruhla', 'Bermbachtal', 'Berlin', 'Almanya');

INSERT INTO siparis(siparis_id, musteri_id, siparis_tarihi, siparis_adresi_id)
VALUES 
(1, 2, CURRENT_TIMESTAMP, 4),
(2, 4, CURRENT_TIMESTAMP, 1),
(3, 1, CURRENT_TIMESTAMP, 4),
(4, 5, CURRENT_TIMESTAMP, 5),
(5, 3, CURRENT_TIMESTAMP, 7),
(6, 3, CURRENT_TIMESTAMP, 6);

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret)
SELECT 1, 4, 1, 6, fiyat * 6
FROM kitaplar
WHERE kitap_id = 1;

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret) 
SELECT 2, 5, 6, 2, fiyat * 2 
FROM kitaplar 
WHERE kitap_id = 6;

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret) 
SELECT 3, 1, 7, 3, fiyat * 3 
FROM kitaplar 
WHERE kitap_id = 7;

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret) 
SELECT 4, 2, 1, 7, fiyat * 7
FROM kitaplar 
WHERE kitap_id = 1;

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret) 
SELECT 5, 3, 1, 1, fiyat * 1
FROM kitaplar 
WHERE kitap_id = 1;

INSERT INTO sepet(sepet_id, siparis_id, kitap_id, adet, toplam_ucret) 
SELECT 6, 6, 8, 4, fiyat * 4
FROM kitaplar 
WHERE kitap_id = 8;

INSERT INTO musteri_adres(musteri_id, adres_id) 
VALUES
(1,3),
(2,1),
(3,5),
(4,6),
(5,2),
(6,4),
(7,7);

INSERT INTO kitap_yazar(kitap_id, yazar_id) 
VALUES
(1, 1),
(2, 11),
(3, 7),
(4, 7),
(5, 7),
(6, 12),
(7, 13),
(8, 5),
(9, 2);

	
* 40 liradan pahalı olan kitapları listeleyiniz:
SELECT * FROM kitaplar
WHERE fiyat > 40;

* Adı ‘E’ harfi ile başlayan müşterileri bulunuz:
SELECT * FROM musteri
WHERE ad LIKE 'E%';

* Emre Güler adındaki müşteri bir indirim kuponu kazanmıştır. Kendisine ulaşabilmemiz için telefon numarası ve email’ini bulunuz:
SELECT telefon, email FROM musteri
WHERE ad = 'Emre' AND soyad = 'Güler';

* Esatpaşa mahallesine kargo götüecek olan saha görevlsi sokağın adını unutmuş, Kendisine sokak adını iletebilmemiz için lütfen Esatpaşa mahallesindeki sokağın adını bulunuz:
SELECT sokak FROM adres
WHERE mahalle = 'Esatpaşa';

	
* Mert Gezer adlı müşterinin sipariş ettiği kitabın adını bulunuz:
SELECT kitap_ismi FROM kitaplar
INNER JOIN sepet
ON kitaplar.kitap_id = sepet.sepet_id
INNER JOIN siparis
ON sepet.siparis_id = siparis.siparis_id
INNER JOIN musteri
ON musteri.musteri_id = siparis.siparis_id
WHERE ad = 'Mert' AND soyad = 'Gezer';

* J. R. R. Tolkien adlı yazara ait kitabın haklarının hangi yayınevine ait olduğunu bulunuz:
SELECT yayinevi_adi FROM yayinevi
INNER JOIN kitaplar
ON kitaplar.yayinevi_id = yayinevi.yayinevi_id
INNER JOIN kitap_yazar
ON kitaplar.kitap_id = kitap_yazar.kitap_id
INNER JOIN yazar
ON yazar.yazar_id = kitap_yazar.yazar_id
WHERE yazar_adi = 'J. R. R. Tolkien';

* ‘Fahrenheit 451’ adlı kitabın hangi dilde basıldığını bulun:
SELECT dil_adi FROM dil
INNER JOIN kitaplar 
ON kitaplar.dil_id = dil.dil_id
WHERE kitap_ismi = 'Fahrenheit 451';

* Hangi yazara ait kaç kitap olduğunu bulunuz:
SELECT COUNT (kitaplar.kitap_id), yazar.yazar_adi
FROM kitaplar
INNER JOIN kitap_yazar
ON kitaplar.kitap_id = kitap_yazar.kitap_id
INNER JOIN yazar
ON yazar.yazar_id = kitap_yazar.yazar_id
GROUP BY yazar_adi; 

* Hangi dilden kaç tane kitap basıldığını bulunuz:
SELECT COUNT(kitaplar.dil_id), dil.dil_adi FROM kitaplar
INNER JOIN dil
ON dil.dil_id = kitaplar.dil_id
GROUP BY dil.dil_adi
HAVING COUNT(kitaplar.dil_id) > 0
ORDER BY dil.dil_adi DESC;

* Satış yapan yayınevlerinin kazançlarını küçükten büyüğe sıraların:
SELECT AVG(toplam_ucret), yayinevi_adi FROM sepet
INNER JOIN kitaplar
ON sepet.kitap_id = kitaplar.kitap_id
INNER JOIN yayinevi
ON yayinevi.yayinevi_id = kitaplar.yayinevi_id
GROUP BY (yayinevi_adi)
HAVING AVG(toplam_ucret) >= 0
ORDER BY AVG(toplam_ucret);

* Her ülkedeki siparişlerin minimum olanlarını bulun:
SELECT MIN(toplam_ucret), ulke FROM sepet
INNER JOIN siparis
ON siparis.siparis_id = sepet.siparis_id
INNER JOIN adres
ON siparis.siparis_adresi_id = adres.adres_id
GROUP BY ulke
HAVING MIN(toplam_ucret) > 0;

* Sefa Yıldız adlı müşteri telefon numarasını ‘536-246-00' yapmıştır, lütfen gerekli değiştirmeyi yapın:
UPDATE musteri
SET telefon = '536-246-00'
WHERE ad = 'Sefa' AND soyad = 'Yıldız';

* Mimar Sinan adlı müşteri Çankaya mahallesi, Akdeniz sokak Ankara’ya taşınmıştır, lütfen gerekli değişikliği yapın:
UPDATE adres
SET mahalle = 'Çankaya', sokak = 'Akdeniz', sehir = 'Ankara'
FROM musteri, musteri_adres
WHERE musteri.ad = 'Mimar' AND musteri.soyad = 'Sinan';

* Mert Gezer adlı kullanıcı hesabını kapatmıştır. Blgilerini silin:
Bu silme işlemini doğrudan yapamıyoruz çünkü musteri_id bir başka tabloda foreign key olarak tutuluyor.  (ERROR: update or delete on table "musteri" violates foreign key constraint "siparis_musteri_id_fk" on table "siparis" hatasını alırız) Bunun için foreign key constraint’i kaldırmalıyız:
ALTER TABLE siparis 
DROP CONSTRAINT siparis_musteri_id_fk

DELETE FROM musteri
WHERE ad = 'Mert' AND soyad = 'Gezer';

* Franz Kafka adlı yazarı silin:	
DELETE FROM yazar
WHERE yazar_adi = 'Franz Kafka';
