use w8402312_vtwork;

/*
CREATE TABLE role (
	id int(11) PRIMARY KEY AUTO_INCREMENT,
	rooli varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO role (id, rooli) 
VALUES
    	(1, 'Järjestelmänvalvoja'),
    	(2, 'Työnantaja'),
		(3, 'Työntekijä');

CREATE TABLE account (
  	id int(11) PRIMARY KEY AUTO_INCREMENT,
  	titteli varchar(255) DEFAULT NULL,
  	etunimi varchar(255) NOT NULL,
  	sukunimi varchar(255) NOT NULL,
  	email varchar(255) DEFAULT NULL,
  	salasana varchar(255) NOT NULL,
  	rooli_id int(11) NOT NULL,
  	status boolean DEFAULT TRUE,
  	CONSTRAINT fk_account_role
			FOREIGN KEY (rooli_id) REFERENCES role (id)
    		ON DELETE RESTRICT 
			ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO account (titteli, etunimi, sukunimi, email, salasana, rooli_id, status) 
values
	('Järjestelmänvalvoja', 'Tuukka', 'Bordi', 'bortu@varatoimari.com', '2fdf1cf1746117ea2576123f26b8e0bb90d6d4e446be94db1b31cc577733e327', 1, '1'),
	('Työntekijä', 'James', 'Chocolatey', 'employee@test.com',  '*********', 3, '1'), 
	('Työnantaja', 'Boss', 'Truman', 'trubo@varatoimari.com', '*********', 2, '1'), 
	('Työntekijä', 'Joe', 'Thyme', 'thyjo@varatoimari.com', '*********', 3, '1');

create table product_category (
	id INT(11) PRIMARY KEY,
	nimi VARCHAR(50) NOT NULL,
	CONSTRAINT nimi_unique UNIQUE (nimi)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO product_category (id, nimi)
VALUES 
	('1', 'IT-tukipalvelut'),
	('2', 'Kehityspalvelut'),
	('3', 'Kaapelit ja adapterit'),
	('4', 'Tietokoneet ja laitteet');

CREATE TABLE product (
  	tuotekoodi INT(11) PRIMARY KEY,
  	tuotenimike VARCHAR(50) NOT NULL,
	tuote VARCHAR(50) NOT NULL,
	yksikko VARCHAR(15) NOT NULL,
	hinta decimal(9,2) DEFAULT NULL,
	alv decimal(5,2) DEFAULT NULL,
  	ilman_alv decimal(9,2) DEFAULT NULL,
	CONSTRAINT fk_tuotenimike_id
		FOREIGN KEY (tuotenimike) REFERENCES product_category (nimi)
		ON DELETE RESTRICT 
		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO product (tuotekoodi, tuotenimike, tuote, yksikko, hinta, alv, ilman_alv)
VALUES
	(1, 'Tietokoneet ja laitteet', 'Tietokone', 'KPL', 750.00, 24.00, 604.83),
	(2, 'Kehityspalvelut', 'Verkkosivukehitys', 'Tunti', 340.00, 24.00, 274.19),
	(3, 'Kaapelit ja adapterit', 'HDMI-kaapeli', 'KPL', 60.00, 24.00, 48.39),
	(4, 'IT-tukipalvelut', 'IT-tuki', 'Tunti', 50.00, 24.00, 40.32);

CREATE TABLE customer (
    	ytunnus varchar(15) PRIMARY KEY,
    	nimi varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO customer (ytunnus, nimi) 
VALUES
	('1234567-7', 'Metso Oy'),
	('1234567-8', 'Metsa Oy'),
	('7654321-0', 'Grilli-21'),
	('7654321-1', 'Grilli-22');

CREATE TABLE activity (
  	id int(11) PRIMARY KEY AUTO_INCREMENT,
  	asiakas_id VARCHAR(15) NOT NULL,
  	aloituspaiva date NOT NULL,
  	lopetuspaiva date DEFAULT NULL,
  	huomiot TEXT DEFAULT NULL,
  	CONSTRAINT fk_asiakas_id
		FOREIGN KEY (asiakas_id) REFERENCES customer (ytunnus)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO activity (asiakas_id, aloituspaiva, lopetuspaiva, huomiot) 
VALUES
	('1234567-7', '2020.4.24', '2020.4.25', 'ilmoja pidelly'),
	('1234567-8', '2020.2.28', '2020.2.29', NULL),
	('7654321-0', '2020.1.03', '2020.1.04', 'korjattiin grilli'),
	('7654321-1', '2020.3.25', '2020.3.27', 'meni kaks paivaa');

CREATE TABLE timesheet (
  	id int(11)  PRIMARY KEY AUTO_INCREMENT,
  	tyontekija_id int(11)  NOT NULL,
  	aktiviteetti_id int(11) NOT NULL,
  	tuotekoodi int(11)  NOT NULL,
  	paivamaara date NOT NULL,
  	aloitusaika TIME DEFAULT NULL,
  	lopetusaika TIME DEFAULT NULL,
  	maara decimal(6,2) NOT NULL,
  	alennus decimal(5,2) DEFAULT NULL,
  	loppusumma decimal(9,2) NOT NULL,
  	rivikommentti varchar(50) DEFAULT NULL,
  	muistiinpanoja TEXT DEFAULT NULL,
  	CONSTRAINT fk_tyontekija_id 
		FOREIGN KEY (tyontekija_id) REFERENCES account (id)
		ON DELETE RESTRICT 
		ON UPDATE CASCADE,
  	CONSTRAINT fk_aktiviteetti_id 
		FOREIGN KEY (aktiviteetti_id) REFERENCES activity (id)
    	ON DELETE RESTRICT
		ON UPDATE CASCADE,
  	CONSTRAINT fk_tuotekoodi
		FOREIGN KEY (tuotekoodi) REFERENCES product (tuotekoodi)
		ON DELETE RESTRICT
		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

INSERT INTO timesheet (tyontekija_id, aktiviteetti_id, tuotekoodi, paivamaara, aloitusaika, lopetusaika, maara, alennus, loppusumma, rivikommentti, muistiinpanoja) 
VALUES
   	(2, 1, 1, '2018-01-10', '15:53:00', '16:07:00', 1.00, 0, 750.00, 'testi', 'testi'),
	(1, 2, 2, '2018-02-11', '16:53:00', '22:07:00', 2.00, 0, 680.00, 'Kiitos ja mukavaa kevään jatko!', 'Mukava asiakas'),
	(3, 3, 3, '2018-03-12', '17:53:00', '21:07:00', 3.00, 0, 180.00, 'It was a pleasure to do business with you!', 'What a nice old man :)'),
	(4, 4, 4, '2018-04-13', '18:53:00', '20:07:00', 1.25, 0, 62.50, 'Korjattiin ongelma tulostimen kanssa', 'testi');
*/