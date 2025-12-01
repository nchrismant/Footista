CREATE TABLE utilisateurs (
    id SERIAL NOT NULL PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(200) NOT NULL,
    inscription_date TIMESTAMP NOT NULL,
    mail VARCHAR(50) NOT NULL UNIQUE,
    activate BOOLEAN NOT NULL DEFAULT FALSE,
    code VARCHAR(60) NOT NULL UNIQUE,
    recuperation CHAR(6) NULL UNIQUE
);

CREATE TABLE clubs (
    no_club SERIAL NOT NULL PRIMARY KEY,
    nom_club VARCHAR(30) NOT NULL,
    pays_club VARCHAR(20) NOT NULL,
    stade_club VARCHAR(40) NULL,
    surnom_club VARCHAR(30) NULL
);

CREATE TABLE equipes_nationales (
    no_equipe SERIAL NOT NULL PRIMARY KEY,
    pays_equipe VARCHAR(40) NOT NULL,
    surnom_equipe VARCHAR(60) NULL,
    stade_equipe VARCHAR(60) NOT NULL
);

CREATE TABLE joueurs (
    no_joueur SERIAL NOT NULL PRIMARY KEY,
    nom VARCHAR(30) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    date_naissance DATE NOT NULL,
    numero INT NOT NULL CHECK (numero BETWEEN 1 AND 99),
    taille INT NOT NULL,
    nationalite VARCHAR(20) NOT NULL,
    poste VARCHAR(30) NOT NULL,
    pied_fort VARCHAR(15) NULL CHECK (pied_fort IN ('Droit', 'Gauche', 'Ambidextre')),
    surnom VARCHAR(30) NULL,
    no_club INT NOT NULL REFERENCES clubs(no_club),
    no_equipe INT NOT NULL REFERENCES equipes_nationales(no_equipe)
);

CREATE TABLE icones (
    no_joueur_icone INT NOT NULL PRIMARY KEY REFERENCES joueurs(no_joueur),
    debut_carriere DATE NOT NULL,
    fin_carriere DATE NOT NULL,
    profession_actuelle VARCHAR(60) NULL,
    moment_memorable TEXT NULL,
    decede BOOLEAN NOT NULL DEFAULT FALSE,
    date_deces DATE NULL
);

CREATE TABLE saisons (
    no_saison SERIAL NOT NULL PRIMARY KEY,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL
);

CREATE TABLE statistiques (
    no_joueur INT NOT NULL REFERENCES joueurs(no_joueur),
    no_saison INT NOT NULL REFERENCES saisons(no_saison),
    buts INT NULL,
    passes_decisives INT NULL,
    cartons_jaunes INT NULL,
    cartons_rouges INT NULL,
    nb_matchs INT NULL,
    PRIMARY KEY (no_joueur, no_saison)
);

CREATE TABLE transferts (
    no_transfert SERIAL NOT NULL PRIMARY KEY,
    montant FLOAT NULL,
    date_transfert DATE NOT NULL,
    no_joueur INT NOT NULL REFERENCES joueurs(no_joueur),
    no_club_depart INT NOT NULL REFERENCES clubs(no_club),
    no_club_arrivee INT NOT NULL REFERENCES clubs(no_club)
);

CREATE TABLE blessures (
    no_blessure SERIAL NOT NULL PRIMARY KEY,
    date_debut_blessure DATE NOT NULL,
    nom_blessure VARCHAR(60) NOT NULL,
    date_fin_blessure DATE NULL,
    no_joueur INT NOT NULL REFERENCES joueurs(no_joueur)
);

CREATE TABLE competitions (
    no_compet SERIAL NOT NULL PRIMARY KEY,
    nom_compet VARCHAR(30) NOT NULL,
    pays_compet VARCHAR(20) NULL,
    organisateur VARCHAR(30) NOT NULL,
    type_compet VARCHAR(20) NOT NULL CHECK (type_compet IN ('Club', 'Equipe nationale'))
);

CREATE TABLE trophees (
    no_tr SERIAL NOT NULL PRIMARY KEY,
    nom_tr VARCHAR(40) NOT NULL,
    description TEXT NULL,
    type_tr VARCHAR(20) NOT NULL CHECK (type_tr IN ('Club', 'Equipe nationale', 'Individuel')),
    no_compet INT NULL REFERENCES competitions(no_compet),
    no_saison INT NOT NULL REFERENCES saisons(no_saison),
    no_club INT NULL REFERENCES clubs(no_club),
    no_equipe INT NULL REFERENCES equipes_nationales(no_equipe),
    no_joueur INT NULL REFERENCES joueurs(no_joueur)
);

INSERT INTO clubs(no_club,nom_club,pays_club,stade_club,surnom_club)
    VALUES
    (1,'Real Madrid','Espagne','Santiago Bernabeu','La Casa Blanca'),
    (2,'Paris Saint Germain','France','Parc des Princes','Les Parisiens'),
    (3,'Liverpool','Angleterre','Anfield','The Reds'),
    (4,'Bayern Munich','Allemagne','Allianz Arena','die Roten'),
    (5,'Juventus','Italie','Allianz Stadium','La Vieille Dame'),
    (6,'FC Barcelone','Espagne','Camp Nou','Blaugranas'),
    (7,'Olympique Lyonnais','France','Groupama Stadium','Les Gones'),
    (8,'Manchester United','Angleterre','Old Trafford','Red Devils'),
    (9,'Borussia Dortmund','Allemagne','Signal Iduna Park','BVB'),
    (10,'FC Internazionale Milano','Italie','San Siro','I Nerazzurri'),
    (11,'Chelsea','Angleterre','Stamford Bridge','The Blues'),
    (12,'Villareal CF','Espagne','Estadio de la Cerámica','Le Sous-marin jaune'),
    (13,'Manchester City','Angleterre','Etihad Stadium','The Skyblues'),
    (14,'Atlético de Madrid','Espagne','Wanda Metropolitano','Los Colchoneros'),
    (15,'Lille','France','Stade Pierre-Mauroy','Les Dogues'),
    (16,'Monaco','France','Stade Louis-II','Les Monégasques'),
    (17,'SS Lazio','Italie','Stadio Olimpico','Biancocelesti'),
    (18,'Naples','Italie','Stade Diego Armando Maradona','Gli Azzurri'),
    (19,'Santos FC','Brésil','Urbano Caldeira','Peixe'),
    (20,'Ajax Amsterdam','Pays-Bas','Johan Cruyff Arena','Les Ajacides');

INSERT INTO equipes_nationales(no_equipe,pays_equipe,surnom_equipe,stade_equipe)
    VALUES
    (1,'Espagne','La Roja','Estadio de la Cartuja'),
    (3,'France','Les Bleus','Stade de France'),
    (2,'Brésil','La Seleção','Maracanã'),
    (4,'Croatie','Vatreni','Stade Maksimir'),
    (5,'Uruguay','La Celeste','Stade Centenario'),
    (6,'Belgique','Les Diables Rouges','Stade Roi Baudouin'),
    (7,'Allemagne','Die Mannschaft','Allianz Arena'),
    (8,'Pays de Galles','Les Dragons','Millennium Stadium'),
    (9,'Ukraine','Jovto-Blakytni','Stade olympique de Kiev'),
    (10,'Autriche','Das Team','Stade Ernst-Happel'),
    (11,'République Dominicaine','Los Quisqueyanos','Estadio Olímpico Félix Sánchez'),
    (12,'Serbie','Les Aigles blancs','Stade Rajko Mitic'),
    (13,'Costa Rica','Los Ticos','Stade national du Costa Rica'),
    (14,'Argentine','L''Albiceleste','Estadio Monumental Antonio Vespucio Liberti'),
    (15,'Portugal','A Seleção','Estádio da Luz'),
    (16,'Sénégal','Les Lions de la Teranga','Stade Léopold Sédar Senghor'),
    (17,'Italie','La Nazionale','Stade Olympique de Rome'),
    (18,'Angleterre','The Three Lions','Wembley'),
    (19,'Pays Bas','De Oranjes','Johan Cruyff Arena'),
    (20,'Maroc','Les Lions de l''Atlas','Complexe Sportif Moulay-Abdallah'),
    (21,'Guinée','Le Syli national de Guinée','Stade de Nongo'),
    (22,'Algérie','Les Fennecs','Stade Mustapha-Tchaker'),
    (23,'Egypte','Les Pharaons','Stade international du Caire'),
    (24,'Japon','Samourai Blue','Stade Olympique national de Tokyo'),
    (25,'Cameroun','Les Lions indomptables','Stade Ahmadou Ahidjo'),
    (26,'Grèce','Le Bateau Pirate','Stade olympique Athènes'),
    (27,'Irlande','The Boys in Green','Aviva Stadium'),
    (28,'Irlande du Nord','Green and White Army','Windsor Park'),
    (29,'Ecosse','The Tartan Army','Hampden Park'),
    (30,'Canada','The Canucks','BMO Field'),
    (31,'Pologne','Blanc et rouge','Stade national de Varsovie'),
    (32,'Etats-Unis','Team USA','Nissan Stadium'),
    (33,'Colombie','Los Cafeteros','Stade Metropolitano Roberto Melendez'),
    (34,'Suède','Bleu et Jaune','Friends Arena'),
    (35,'Danemark','Les Dynamites danoises','Parken Stadium'),
    (36,'Togo','Les Eperviers','Stade de Kégué'),
    (37,'Côte d''Ivoire','Les Eléphants','Stade olympique d''Ebimpe'),
    (38,'Zimbabwe','The Warriors','National Sports Stadium'),
    (39,'Suisse','La Nati','Stade du Wankdorf'),
    (40,'Norvège','Drillos','Ullevaal Stadion'),
    (41,'Chili','La Roja de todos','Estadio Nacional de Chile'),
    (42,'Bosnie-Herzégovine','Zmajevi','Stade Bilino Polje'),
    (43,'Turquie','Ay-Yildizlilar','Stade Olympique Atatürk'),
    (44,'Slovaquie','Repre','Stade Antona Malatinského'),
    (45,'Slovénie','Zmajceki','Stadion Ljudski vrt'),
    (46,'Roumanie','Tricolorii','Arena Nationala'),
    (47,'Libéria','Lone Stars','Samuel Kanyon Doe Sports Complex'),
    (48,'Monténégro','Hrabri Sokoli','Podgorica City Stadium'),
    (49,'Albanie','Kuq e Zinjte','Air Albania Stadium'),
    (50,'Russie','Sbornaja','Stade Loujniki'),
    (51,'Mozambique','Os Mambas','Stade national de Maputo');

INSERT INTO joueurs(no_joueur,nom,prenom,date_naissance,numero,taille,nationalite,poste,pied_fort,surnom,no_club,no_equipe)
    VALUES
    (1,'Courtois','Thibaut','1992-05-11',1,199,'Belge','Gardien de But','Gauche',NULL,1,6)
    ,(2,'Lunin','Andrii','1999-02-11',13,191,'Ukrainien','Gardien de But','Droit',NULL,1,9)
    ,(3,'Carvajal','Daniel','1992-01-11',2,173,'Espagnol','Défenseur','Droit','Tête de Kiwi',1,1)
    ,(4,'Militao','Eder','1998-01-18',3,186,'Brésilien','Défenseur','Droit',NULL,1,2)
    ,(5,'Alaba','David','1992-06-24',4,180,'Autrichien','Défenseur','Gauche',NULL,1,10)
    ,(6,'Vallejo','Jesus','1997-01-05',5,184,'Espagnol','Défenseur','Droit',NULL,1,1)
    ,(7,'Fernandez','Nacho','1990-01-18',6,180,'Espagnol','Défenseur','Droit',NULL,1,1)
    ,(8,'Da silva','Marcelo','1988-05-12',12,174,'Brésilien','Défenseur','Gauche',NULL,1,2)
    ,(9,'Vazquez','Lucas','1991-07-01',17,173,'Espagnol','Défenseur','Droit',NULL,1,1)
    ,(10,'Mendy','Ferland','1995-06-08',23,180,'Français','Défenseur','Gauche',NULL,1,3)
    ,(11,'Ceballos','Dani','1996-08-07',19,179,'Espagnol','Milieu','Droit',NULL,1,1)
    ,(12,'Kroos','Toni','1990-01-04',8,183,'Allemand','Milieu','Ambidextre',NULL,1,7)
    ,(13,'Modric','Luka','1985-09-09',10,172,'Croate','Milieu','Droit','Vinaigre',1,4)
    ,(14,'Casemiro','Carlos Henrique','1992-02-23',14,185,'Brésilien','Milieu','Droit',NULL,1,2)
    ,(15,'Alarcón','Isco','1992-04-21',22,176,'Espagnol','Milieu','Droit','Magie',1,1)
    ,(16,'Camavinga','Eduardo','2002-11-10',25,182,'Français','Milieu','Gauche',NULL,1,3)
    ,(17,'Blanco','Antonio','2000-07-23',27,175,'Espagnol','Milieu',NULL,NULL,1,1)
    ,(18,'Hazard','Eden','1991-01-07',7,175,'Belge','Attaquant','Ambidextre',NULL,1,6)
    ,(19,'Benzema','Karim','1987-12-19',9,185,'Français','Attaquant','Ambidextre','Monsieur',1,3)
    ,(20,'Asensio','Marco','1996-01-21',11,182,'Espagnol','Attaquant','Gauche','Asendios',1,1)
    ,(21,'Valverde','Federico','1998-07-22',15,182,'Urugayen','Milieu','Droit',NULL,1,5)
    ,(22,'Jovic','Luka','1997-12-23',16,182,'Serbe','Attaquant','Droit',NULL,1,12)
    ,(23,'Bale','Gareth','1989-07-16',18,185,'Gallois','Attaquant','Gauche',NULL,1,8)
    ,(24,'Oliveira','Vinicius','2000-07-12',20,176,'Brésilien','Attaquant','Droit',NULL,1,2)
    ,(25,'Goes','Rodrygo','2001-01-09',21,174,'Brésilien','Attaquant','Droit',NULL,1,2)
    ,(26,'Diaz','Mariano','1993-08-01',24,180,'Dominicain','Attaquant','Droit',NULL,1,11)
    ,(27,'Navas','Keylor','1986-12-15',1,185,'Costa Ricain','Gardien de But','Droit',NULL,2,13)
    ,(28,'Donnarumma','Gianluigi','1999-02-25',50,196,'Italien','Gardien de But','Droit',NULL,2,17)
    ,(29,'Ramos','Sergio','1986-03-30',4,184,'Espagnol','Défenseur','Droit',NULL,2,1)
    ,(30,'Hakimi','Achraf','1998-11-04',2,181,'Marocain','Défenseur','Droit',NULL,2,20)
    ,(31,'Kimpembe','Presnel','1995-08-13',3,183,'Français','Défenseur','Gauche',NULL,2,3)
    ,(32,'Aoás Corrêa','Marquinhos','1994-05-14',5,183,'Brésilien','Défenseur','Droit','Maroquinhos',2,2)
    ,(33,'Bernat','Juan','1993-03-01',14,177,'Espagnol','Défenseur','Gauche',NULL,2,1)
    ,(34,'Dagba','Colin','1998-09-09',17,170,'Français','Défenseur','Droit',NULL,2,3)
    ,(35,'Kurzawa','Layvin','1992-09-04',20,182,'Français','Défenseur','Gauche',NULL,2,3)
    ,(36,'Diallo','Abdou','1996-05-04',22,187,'Français','Défenseur','Gauche',NULL,2,3)
    ,(37,'Kehrer','Thilo','1996-09-21',24,186,'Allemand','Défenseur','Droit',NULL,2,7)
    ,(38,'Mendes','Nuno','2002-06-19',25,176,'Portugais','Défenseur','Gauche',NULL,2,15)
    ,(39,'Verratti','Marco','1992-11-05',6,165,'Italien','Milieu','Droit',NULL,2,17)
    ,(40,'Paredes','Leandro','1994-06-29',8,180,'Argentin','Milieu','Droit',NULL,2,14)
    ,(41,'Da Silva Santos','Neymar','1992-02-05',10,175,'Brésilien','Attaquant','Droit','Ney',2,2)
    ,(42,'Di María','Ángel','1988-02-14',11,180,'Argentin','Milieu','Gauche','El fideo',2,14)
    ,(43,'Pereira','Danilo','1991-09-09',15,188,'Portugais','Milieu','Droit',NULL,2,15)
    ,(44,'Wijnaldum','Georginio','1990-11-11',18,175,'Néerlandais','Milieu','Droit','Gini',2,19)
    ,(45,'Herrera','Ander','1989-08-14',21,182,'Espagnol','Milieu','Droit',NULL,2,1)
    ,(46,'Gana Gueye','Idrissa','1989-09-26',27,174,'Sénégalais','Milieu','Droit',NULL,2,16)
    ,(47,'Dina Ebimbe','Eric Junior','2000-11-21',28,175,'Français','Milieu','Droit',NULL,2,3)
    ,(48,'Messi','Lionel','1987-06-24',30,170,'Argentin','Attaquant','Gauche','La Pulga',2,14)
    ,(49,'Mbappé','Kylian','1998-12-20',7,178,'Français','Attaquant','Droit','Donatello',2,3)
    ,(50,'Icardi','Mauro','1993-02-19',9,181,'Argentin','Attaquant','Droit',NULL,2,14)
    ,(51,'Alcântara','Rafinha','1993-02-12',12,174,'Brésilien','Milieu','Gauche',NULL,2,2)
    ,(52,'Draxler','Julian','1993-09-20',23,185,'Allemand','Milieu','Droit',NULL,2,7)
    ,(53,'Becker','Alisson','1992-10-02',1,193,'Brésilien','Gardien de But','Droit',NULL,3,2)
    ,(54,'Adrián','Adrián','1987-01-03',13,190,'Espagnol','Gardien de But','Droit',NULL,3,1)
    ,(55,'Van Dijk','Virgil','1991-07-08',4,193,'Néerlandais','Défenseur','Droit',NULL,3,19)
    ,(56,'Konaté','Ibrahima','1999-05-25',5,192,'Français','Défenseur','Droit',NULL,3,3)
    ,(57,'Gomez','Joe','1997-05-23',12,188,'Anglais','Défenseur','Droit',NULL,3,18)
    ,(58,'Tsimikas','Konstantinos','1996-05-12',21,177,'Grec','Défenseur','Gauche',NULL,3,26)
    ,(59,'Robertson','Andrew','1994-03-11',26,178,'Ecossais','Défenseur','Gauche',NULL,3,29)
    ,(60,'Matip','Joël','1991-08-08',32,195,'Camerounais','Défenseur','Droit',NULL,3,25)
    ,(61,'Phillips','Nathaniel','1997-03-21',47,190,'Anglais','Défenseur','Droit',NULL,3,18)
    ,(62,'Alexander-Arnold','Trent','1998-10-07',66,175,'Anglais','Défenseur','Droit',NULL,3,18)
    ,(63,'Williams','Neco','2001-04-13',2,183,'Gallois','Défenseur','Droit',NULL,3,8)
    ,(64,'Tavares','Fabinho','1993-10-23',3,188,'Brésilien','Milieu','Droit',NULL,3,2)
    ,(65,'Alcântara','Thiago','1991-04-11',6,174,'Espagnol','Milieu','Droit',NULL,3,1)
    ,(66,'Milner','James','1986-01-04',7,175,'Anglais','Milieu','Droit',NULL,3,18)
    ,(67,'Keïta','Naby','1995-02-10',8,172,'Guinéen','Milieu','Droit',NULL,3,21)
    ,(68,'Henderson','Jordan','1990-06-17',14,182,'Anglais','Milieu','Droit',NULL,3,18)
    ,(69,'Oxlade-Chamberlain','Alex','1993-08-15',15,180,'Anglais','Milieu','Ambidextre',NULL,3,18)
    ,(70,'Jones','Curtis','2001-01-30',17,185,'Anglais','Milieu','Droit',NULL,3,18)
    ,(71,'Elliott','Harvey','2003-04-04',67,170,'Anglais','Milieu','Gauche',NULL,3,18)
    ,(72,'Firmino','Roberto','1991-10-02',9,181,'Brésilien','Attaquant','Droit','Bobby',3,2)
    ,(73,'Mané','Sadio','1992-04-10',10,175,'Sénégalais','Attaquant','Droit','Ballonbuwa',3,16)
    ,(74,'Balagizi','James','2003-09-20',85,189,'Anglais','Attaquant',NULL,NULL,3,18)
    ,(75,'Salah','Mohamed','1992-06-15',11,175,'Egyptien','Attaquant','Gauche','Egyptian King',3,23)
    ,(76,'Minamino','Takumi','1995-01-16',18,174,'Japonais','Attaquant','Droit',NULL,3,24)
    ,(77,'Jota','Diogo','1996-12-04',20,178,'Portugais','Attaquant','Droit',NULL,3,15)
    ,(78,'Origi','Divock','1995-04-18',27,185,'Belge','Attaquant','Ambidextre',NULL,3,6)
    ,(79,'Neuer','Manuel','1986-03-27',1,193,'Allemand','Gardien de But','Droit',NULL,4,7)
    ,(80,'Ulreich','Sven','1988-08-03',26,192,'Allemand','Gardien de But','Droit',NULL,4,7)
    ,(81,'Upamecano','Dayot','1998-10-27',2,186,'Français','Défenseur','Droit',NULL,4,3)
    ,(82,'Sule','Niklas','1995-09-03',4,195,'Allemand','Défenseur','Droit',NULL,4,7)
    ,(83,'Pavard','Benjamin','1996-03-28',5,186,'Français','Défenseur','Droit',NULL,4,3)
    ,(84,'Davies','Alphonso','2000-11-02',19,183,'Canadien','Défenseur','Gauche','Roadrunner',4,30)
    ,(85,'Sarr','Bouna','1992-01-31',20,177,'Sénégalais','Défenseur','Droit',NULL,4,16)
    ,(86,'Hernandez','Lucas','1996-02-14',21,184,'Français','Défenseur','Gauche',NULL,4,3)
    ,(87,'Kouassi','Tanguy','2002-06-07',23,187,'Français','Défenseur','Droit',NULL,4,3)
    ,(88,'Stanisic','Josip','2000-04-02',44,186,'Croate','Défenseur','Droit',NULL,4,4)
    ,(89,'Kimmich','Joshua','1995-02-08',6,177,'Allemand','Milieu','Droit',NULL,4,7)
    ,(90,'Gnabry','Serge','1995-07-14',7,176,'Allemand','Milieu','Droit',NULL,4,7)
    ,(91,'Goretzka','Leon','1995-02-06',8,189,'Allemand','Milieu','Droit',NULL,4,7)
    ,(92,'Sané','Leroy','1996-01-11',10,183,'Allemand','Attaquant','Gauche',NULL,4,7)
    ,(93,'Coman','Kingsley','1996-06-13',11,180,'Français','Attaquant','Droit',NULL,4,3)
    ,(94,'Sabitzer','Marcel','1994-03-17',18,178,'Autrichien','Milieu','Droit',NULL,4,10)
    ,(95,'Tolisso','Corentin','1994-08-03',24,181,'Français','Milieu','Droit',NULL,4,3)
    ,(96,'Muller','Thomas','1989-09-13',25,185,'Allemand','Attaquant','Droit','Raumdauter',4,7)
    ,(97,'Musiala','Jamal','2003-02-26',42,180,'Allemand','Milieu','Droit',NULL,4,7)
    ,(98,'Lewandowski','Robert','1988-08-21',9,185,'Polonais','Attaquant','Droit','Lewangoalski',4,31)
    ,(99,'Choupo-Moting','Eric Maxim','1989-03-23',13,191,'Camerounais','Attaquant','Droit',NULL,4,25)
    ,(100,'Szczesny','Wojciech','1990-04-18',1,195,'Polonais','Gardien de But','Droit',NULL,5,31)
    ,(101,'Pinsoglio','Carlo','1990-03-16',23,194,'Italien','Gardien de But','Gauche',NULL,5,17)
    ,(102,'De Sciglio','Mattia','1992-10-20',2,182,'Italien','Défenseur','Droit',NULL,5,17)
    ,(103,'Chiellini','Giorgio','1984-08-14',3,187,'Italien','Défenseur','Gauche',NULL,5,17)
    ,(104,'De Ligt','Matthijs','1999-08-12',4,188,'Néerlandais','Défenseur','Droit',NULL,5,19)
    ,(105,'Da Silva','Danilo','1991-07-15',6,184,'Brésilien','Défenseur','Droit',NULL,5,2)
    ,(106,'Sandro','Alex','1991-01-26',12,180,'Brésilien','Défenseur','Gauche',NULL,5,2)
    ,(107,'Bonucci','Leonardo','1987-05-01',19,190,'Italien','Défenseur','Droit',NULL,5,17)
    ,(108,'Rugani','Daniele','1994-07-29',24,190,'Italien','Défenseur','Droit',NULL,5,17)
    ,(109,'Melo','Arthur','1996-08-12',5,171,'Brésilien','Milieu','Droit',NULL,5,2)
    ,(110,'Ramsey','Aaron','1990-12-26',8,178,'Gallois','Milieu','Ambidextre',NULL,5,8)
    ,(111,'Cuadrado','Juan','1988-05-26',11,179,'Colombien','Milieu','Droit',NULL,5,33)
    ,(112,'McKennie','Weston','1998-08-28',14,185,'Américain','Milieu','Droit',NULL,5,32)
    ,(113,'Bernardeschi','Federico','1994-02-16',20,185,'Italien','Attaquant','Gauche',NULL,5,17)
    ,(114,'Chiesa','Federico','1997-10-25',22,175,'Italien','Attaquant','Droit',NULL,5,17)
    ,(115,'Rabiot','Adrien','1995-04-03',25,188,'Français','Milieu','Droit','Poupou',5,3)
    ,(116,'Locatelli','Manuel','1998-01-08',27,185,'Italien','Milieu','Droit',NULL,5,17)
    ,(117,'Bentacur','Rodrigo','1997-06-25',30,187,'Urugayen','Milieu','Droit',NULL,5,5)
    ,(118,'Morata','Alvaro','1992-10-23',9,190,'Espagnol','Attaquant','Droit',NULL,5,1)
    ,(119,'Dybala','Paulo','1993-11-15',10,177,'Argentin','Attaquant','Gauche',NULL,5,14)
    ,(120,'Kean','Moise','2000-02-28',18,182,'Italien','Attaquant','Droit',NULL,5,17)
    ,(121,'Kulusevski','Dejan','2000-04-25',44,186,'Suédois','Milieu','Gauche',NULL,5,34)
    ,(122,'ter Stegen','Marc-André','1992-04-30',1,187,'Allemand','Gardien de But','Droit',NULL,6,7)
    ,(123,'Iñaki','Peña','1999-03-02',26,184,'Espagnol','Gardien de But','Droit',NULL,6,1)
    ,(124,'Piqué','Gerard','1987-02-02',3,194,'Espagnol','Défenseur','Droit',NULL,6,1)
    ,(125,'Lenglet','Clément','1995-06-17',15,186,'Français','Défenseur','Gauche',NULL,6,3)
    ,(126,'Alba','Jordi','1989-03-21',18,170,'Espagnol','Défenseur','Gauche',NULL,6,1)
    ,(127,'Roberto','Sergi','1992-02-07',20,178,'Espagnol','Défenseur','Droit',NULL,6,1)
    ,(128,'Umtiti','Samuel','1993-11-14',23,182,'Français','Défenseur','Gauche',NULL,6,3)
    ,(129,'García','Eric','2001-01-09',24,182,'Espagnol','Défenseur','Droit',NULL,6,1)
    ,(130,'Busquets','Sergio','1988-07-16',5,189,'Espagnol','Milieu','Droit',NULL,6,1)
    ,(131,'Puig','Riqui','1999-08-13',6,169,'Espagnol','Milieu','Droit',NULL,6,1)
    ,(132,'Demir','Yusuf','2003-06-02',11,173,'Autrichien','Attaquant','Gauche',NULL,6,10)
    ,(133,'González','Pedri','2002-11-25',16,174,'Espagnol','Milieu','Droit',NULL,6,1)
    ,(134,'De Jong','Frenkie','1997-05-12',21,180,'Néerlandais','Milieu','Droit',NULL,6,19)
    ,(135,'González','Nico','2002-01-03',28,188,'Espagnol','Milieu','Droit',NULL,6,1)
    ,(136,'Pablo Martin','Gavi','2004-08-05',30,173,'Espagnol','Milieu','Droit',NULL,6,1)
    ,(137,'Dest','Sergiño','2000-11-03',2,175,'Américain','Défenseur','Droit',NULL,6,32)
    ,(138,'Dembélé','Ousmane','1997-05-15',7,178,'Français','Attaquant','Ambidextre',NULL,6,3)
    ,(139,'Depay','Memphis','1994-02-13',9,176,'Néerlandais','Attaquant','Droit',NULL,6,19)
    ,(140,'Fati','Ansu','2002-10-31',10,178,'Espagnol','Attaquant','Droit',NULL,6,1)
    ,(141,'Braithwaite','Martin','1991-06-05',12,177,'Danois','Attaquant','Droit',NULL,6,35)
    ,(142,'Coutinho','Phillippe','1992-06-12',14,172,'Brésilien','Attaquant','Droit',NULL,6,2)
    ,(143,'De Jong','Luuk','1990-08-27',17,188,'Néerlandais','Attaquant','Droit',NULL,6,19)
    ,(144,'Agüero','Sergio','1988-06-02',19,173,'Argentin','Attaquant','Droit',NULL,6,14)
    ,(145,'Lopes','Anthony','1990-10-01',1,184,'Portugais','Gardien de But','Gauche',NULL,7,15)
    ,(146,'Barcola','Malcolm','1999-05-14',40,195,'Togolais','Gardien de But','Droit',NULL,7,36)
    ,(147,'Diomandé','Sinaly','2001-04-09',2,184,'Ivoirien','Défenseur','Droit',NULL,7,37)
    ,(148,'da Conçeiçao','Emerson','1994-08-03',3,176,'Italien','Défenseur','Gauche',NULL,7,17)
    ,(149,'Denayer','Jason','1995-06-28',5,184,'Belge','Défenseur','Droit',NULL,7,6)
    ,(150,'Dubois','Léo','1994-09-14',14,178,'Français','Défenseur','Droit',NULL,7,3)
    ,(151,'Da Silva','Damien','1988-05-17',21,184,'Français','Défenseur','Droit',NULL,7,3)
    ,(152,'Boateng','Jérôme','1988-09-03',27,192,'Allemand','Défenseur','Droit',NULL,7,7)
    ,(153,'Toko Ekambi','Karl','1992-09-14',7,185,'Camerounais','Attaquant','Droit',NULL,7,25)
    ,(154,'Aouar','Houssem','1998-06-30',8,175,'Français','Milieu','Droit',NULL,7,3)
    ,(155,'Paquetá','Lucas','1997-08-27',10,180,'Brésilien','Milieu','Gauche',NULL,7,2)
    ,(156,'Mendes','Thiago','1992-03-15',23,176,'Brésilien','Milieu','Droit',NULL,7,2)
    ,(157,'Caqueret','Maxence','2000-02-15',25,174,'Français','Milieu','Droit',NULL,7,3)
    ,(158,'Shaqiri','Xherdan','1991-10-10',29,169,'Suisse','Milieu','Ambidextre',NULL,7,39)
    ,(159,'Guimarães','Bruno','1997-11-16',39,182,'Brésilien','Milieu','Droit',NULL,7,2)
    ,(160,'Dembélé','Moussa','1996-07-12',9,183,'Français','Attaquant','Droit',NULL,7,3)
    ,(161,'Kadewere','Tino','1996-01-05',11,183,'Zimbabwéen','Attaquant','Droit',NULL,7,38)
    ,(162,'Cherki','Ryan','2003-08-17',18,176,'Français','Attaquant','Gauche',NULL,7,3)
    ,(163,'Slimani','Islam','1988-06-18',20,188,'Algérien','Attaquant','Droit',NULL,7,22)
    ,(164,'de Gea','David','1990-11-07',1,192,'Espagnol','Gardien de But','Droit',NULL,8,1)
    ,(165,'Henderson','Dean','1997-03-12',26,188,'Anglais','Gardien de But','Droit',NULL,8,18)
    ,(166,'Lindelöf','Victor','1994-07-17',2,187,'Suédois','Défenseur','Droit',NULL,8,34)
    ,(167,'Bailly','Eric','1994-04-12',3,187,'Ivoirien','Défenseur','Droit',NULL,8,37)
    ,(168,'Maguire','Harry','1993-03-05',5,194,'Anglais','Défenseur','Droit',NULL,8,18)
    ,(169,'Varane','Raphaël','1993-04-25',19,191,'Français','Défenseur','Droit',NULL,8,3)
    ,(170,'Dalot','Diogo','1999-03-18',20,183,'Portugais','Défenseur','Droit',NULL,8,15)
    ,(171,'Shaw','Luke','1995-07-12',23,185,'Anglais','Défenseur','Gauche',NULL,8,18)
    ,(172,'Telles','Alex','1992-12-15',27,181,'Brésilien','Défenseur','Gauche',NULL,8,2)
    ,(173,'Wan-Bissaka','Aaron','1997-11-26',29,183,'Anglais','Défenseur','Droit',NULL,8,18)
    ,(174,'Pogba','Paul','1993-03-15',6,191,'Français','Milieu','Ambidextre',NULL,8,3)
    ,(175,'Mata','Juan','1988-04-28',8,170,'Espagnol','Milieu','Gauche',NULL,8,1)
    ,(176,'Martial','Anthony','1995-12-05',9,181,'Français','Attaquant','Droit',NULL,8,3)
    ,(177,'Rashford','Marcus','1997-10-31',10,180,'Anglais','Attaquant','Droit',NULL,8,18)
    ,(178,'de Paula Santos','Fred','1993-03-05',17,169,'Brésilien','Milieu','Gauche',NULL,8,2)
    ,(179,'Fernandes','Bruno','1994-09-08',18,179,'Portugais','Milieu','Droit',NULL,8,15)
    ,(180,'Sancho','Jadon','2000-03-25',25,180,'Anglais','Attaquant','Droit',NULL,8,18)
    ,(181,'Matic','Nemanja','1988-08-01',31,194,'Serbe','Milieu','Gauche',NULL,8,12)
    ,(182,'van de Beek','Donny','1997-04-18',34,184,'Néerlandais','Milieu','Droit',NULL,8,19)
    ,(183,'McTominay','Scott','1996-12-08',39,193,'Ecossais','Milieu','Droit',NULL,8,29)
    ,(184,'Ronaldo','Cristiano','1985-02-05',7,187,'Portugais','Attaquant','Droit','CR7',8,15)
    ,(185,'Greenwood','Mason','2001-10-01',11,181,'Anglais','Attaquant','Gauche',NULL,8,18)
    ,(186,'Lingard','Jesse','1992-12-15',14,175,'Anglais','Milieu','Droit',NULL,8,18)
    ,(187,'Cavani','Edinson','1987-02-14',21,184,'Urugayen','Attaquant','Droit','El Matador',8,5)
    ,(188,'Kobel','Gregor','1997-12-06',1,196,'Suisse','Gardien de But','Droit',NULL,9,39)
    ,(189,'Bürki','Roman','1990-11-14',38,187,'Suisse','Gardien de But','Droit',NULL,9,39)
    ,(190,'Maloney','Lennard','1999-10-08',4,187,'Allemand','Défenseur',NULL,NULL,9,7)
    ,(191,'Zagadou','Dan-Axel','1999-06-03',5,196,'Français','Défenseur','Gauche',NULL,9,3)
    ,(192,'Guerreiro','Raphaël','1993-12-22',13,170,'Portugais','Défenseur','Gauche',NULL,9,15)
    ,(193,'Schulz','Nico','1993-04-01',14,180,'Allemand','Défenseur','Gauche',NULL,9,7)
    ,(194,'Hummels','Mats','1988-12-16',15,191,'Allemand','Défenseur','Droit',NULL,9,7)
    ,(195,'Akanji','Manuel','1995-07-19',16,187,'Suisse','Défenseur','Droit',NULL,9,39)
    ,(196,'Meunier','Thomas','1991-09-12',24,190,'Belge','Défenseur','Droit','Ivan Drago',9,6)
    ,(197,'Passlack','Felix','1998-05-29',30,170,'Allemand','Milieu','Droit',NULL,9,7)
    ,(198,'Pongracic','Marin','1997-09-11',34,190,'Croate','Défenseur','Droit',NULL,9,4)
    ,(199,'Reyna','Giovanni','2002-11-13',7,185,'Américain','Milieu','Droit',NULL,9,32)
    ,(200,'Dahoud','Mahmoud','1996-01-01',8,178,'Allemand','Milieu','Droit',NULL,9,7)
    ,(201,'Hazard','Thorgan','1993-03-29',10,175,'Belge','Milieu','Ambidextre',NULL,9,6)
    ,(202,'Reus','Marco','1989-05-31',11,180,'Allemand','Attaquant','Droit',NULL,9,7)
    ,(203,'Brandt','Julian','1996-05-02',19,185,'Allemand','Milieu','Droit',NULL,9,7)
    ,(204,'Bellingham','Jude','2003-06-29',22,186,'Anglais','Milieu','Droit',NULL,9,18)
    ,(205,'Can','Emre','1994-01-12',23,186,'Allemand','Milieu','Droit',NULL,9,7)
    ,(206,'Witsel','Axel','1989-01-12',28,186,'Belge','Milieu','Droit',NULL,9,6)
    ,(207,'Knauff','Ansgar','2002-01-10',36,180,'Allemand','Milieu','Droit',NULL,9,7)
    ,(208,'Wolf','Marius','1995-05-27',39,188,'Allemand','Milieu','Droit',NULL,9,7)
    ,(209,'Haaland','Erling','2000-07-21',9,194,'Norvégien','Attaquant','Gauche',NULL,9,40)
    ,(210,'Moukoko','Youssoufa','2004-11-20',18,179,'Allemand','Attaquant','Gauche',NULL,9,7)
    ,(211,'Malen','Donyell','1999-01-19',21,176,'Néerlandais','Attaquant','Droit',NULL,9,19)
    ,(212,'Tigges','Steffen','1998-07-31',27,193,'Allemand','Attaquant','Ambidextre',NULL,9,7)
    ,(213,'Handanovic','Samir','1984-07-14',1,193,'Slovène','Gardien de But','Droit',NULL,10,45)
    ,(214,'Radu','Ionut','1997-05-28',97,188,'Roumain','Gardien de But','Droit',NULL,10,46)
    ,(215,'de Vrij','Stefan','1992-02-05',6,189,'Néerlandais','Défenseur','Droit',NULL,10,19)
    ,(216,'Kolarov','Aleksandar','1985-11-10',11,187,'Serbe','Défenseur','Gauche',NULL,10,12)
    ,(217,'Ranocchia','Andrea','1988-02-16',13,195,'Italien','Défenseur','Droit',NULL,10,17)
    ,(218,'D''Ambrosio','Danilo','1988-09-09',33,180,'Italien','Défenseur','Droit',NULL,10,17)
    ,(219,'Škriniar','Milan','1995-02-11',37,187,'Slovaque','Défenseur','Gauche',NULL,10,44)
    ,(220,'Bastoni','Alessandro','1999-04-13',95,190,'Italien','Défenseur','Gauche',NULL,10,17)
    ,(221,'Dumfries','Denzel','1996-04-18',2,188,'Néerlandais','Défenseur','Droit',NULL,10,19)
    ,(222,'Gagliardini','Roberto','1994-04-07',5,190,'Italien','Milieu','Droit',NULL,10,17)
    ,(223,'Vecino','Matías','1991-08-24',8,187,'Urugayen','Milieu','Droit',NULL,10,5)
    ,(224,'Sensi','Stefano','1995-08-05',12,168,'Italien','Milieu','Droit',NULL,10,17)
    ,(225,'Perišic','Ivan','1989-02-02',14,186,'Croate','Milieu','Ambidextre',NULL,10,4)
    ,(226,'Çalhanoglu','Hakan','1994-02-08',20,178,'Turc','Milieu','Droit',NULL,10,43)
    ,(227,'Vidal','Arturo','1987-05-22',22,180,'Chilien','Milieu','Droit',NULL,10,41)
    ,(228,'Barella','Nicolò','1997-02-07',23,175,'Italien','Milieu','Droit',NULL,10,17)
    ,(229,'Eriksen','Christian','1992-02-14',24,182,'Danois','Milieu','Ambidextre',NULL,10,35)
    ,(230,'Dimarco','Federico','1997-11-10',32,175,'Italien','Défenseur','Gauche',NULL,10,17)
    ,(231,'Darmian','Matteo','1989-12-02',36,182,'Italien','Défenseur','Droit',NULL,10,17)
    ,(232,'Brozovic','Marcelo','1992-11-16',77,181,'Croate','Milieu','Ambidextre',NULL,10,4)
    ,(233,'Sánchez','Alexis','1988-12-19',7,169,'Chilien','Attaquant','Droit',NULL,10,41)
    ,(234,'Džeko','Edin','1986-03-17',9,193,'Bosnien','Attaquant','Ambidextre',NULL,10,42)
    ,(235,'Martínez','Lautaro','1997-08-22',10,174,'Argentin','Attaquant','Droit',NULL,10,14)
    ,(236,'Correa','Joaquín','1994-08-13',19,189,'Argentin','Milieu','Droit',NULL,10,14)
    ,(237,'Immobile','Ciro','1990-02-20',17,185,'Italien','Attaquant','Droit',NULL,17,17)
    ,(238,'Strakosha','Thomas','1995-03-19',1,186,'Albanais','Gardien de But','Droit',NULL,17,49)
    ,(239,'Acerbi','Francesco','1988-02-10',33,192,'Italien','Défenseur','Gauche',NULL,17,17)
    ,(240,'Hysaj','Elseid','1994-02-02',23,182,'Albanais','Défenseur','Droit',NULL,17,49)
    ,(241,'Felipe','Luiz','1997-03-22',3,187,'Brésilien','Défenseur','Droit',NULL,17,2)
    ,(242,'Lazzari','Manuel','1993-11-29',29,174,'Italien','Milieu','Droit',NULL,17,17)
    ,(243,'Basic','Toma','1996-11-25',88,189,'Croate','Milieu','Droit',NULL,17,4)
    ,(244,'Leiva','Lucas','1987-01-09',6,179,'Brésilien','Milieu','Droit',NULL,17,2)
    ,(245,'Alberto','Luis','1992-09-28',10,182,'Espagnol','Milieu','Droit',NULL,17,1)
    ,(246,'Rodriguez','Pedro','1987-07-28',9,169,'Espagnol','Attaquant','Ambidextre',NULL,17,1)
    ,(247,'Anderson','Felipe','1993-04-15',7,175,'Brésilien','Attaquant','Droit',NULL,17,2)
    ,(248,'Mendy','Edouard','1992-03-01',16,197,'Sénégalais','Gardien de But','Droit',NULL,11,16)
    ,(249,'Rudiger','Antonio','1993-03-03',2,190,'Allemand','Défenseur','Droit',NULL,11,7)
    ,(250,'Silva','Thiago','1984-09-22',6,183,'Brésilien','Défenseur','Droit',NULL,11,2)
    ,(251,'Christensen','Andreas','1996-04-10',4,187,'Danois','Défenseur','Droit',NULL,11,35)
    ,(252,'Alonso','Marcos','1990-12-28',3,188,'Espagnol','Défenseur','Gauche',NULL,11,1)
    ,(253,'Kanté','N''Golo','1991-03-29',7,168,'Français','Milieu','Droit',NULL,11,3)
    ,(254,'Azpilicueta','César','1989-08-28',28,178,'Espagnol','Défenseur','Droit',NULL,11,1)
    ,(255,'Hudson-Odoi','Callum','2000-11-07',20,182,'Anglais','Attaquant','Droit',NULL,11,18)
    ,(256,'Ziyech','Hakim','1993-03-19',22,181,'Marocain','Milieu','Gauche',NULL,11,20)
    ,(257,'Lukaku','Romelu','1993-05-13',9,190,'Belge','Attaquant','Gauche',NULL,11,6)
    ,(258,'Luiz','Jorge','1991-12-20',5,180,'Italien','Milieu','Ambidextre',NULL,11,17)
    ,(259,'Rulli','Geronimo','1992-05-20',13,189,'Argentin','Gardien de But','Droit',NULL,12,14)
    ,(260,'Torres','Pau','1990-01-16',4,191,'Espagnol','Défenseur','Gauche',NULL,12,1)
    ,(261,'Pedraza','Alfonso','1996-04-09',24,184,'Espagnol','Milieu','Gauche',NULL,12,1)
    ,(262,'Albiol','Raul','1985-09-04',3,187,'Espagnol','Défenseur','Droit',NULL,12,1)
    ,(263,'Foyth','Juan','1998-01-12',8,179,'Argentin','Défenseur','Droit',NULL,12,14)
    ,(264,'Gomez','Moi','1994-06-23',23,176,'Espagnol','Milieu','Ambidextre',NULL,12,1)
    ,(265,'Parejo','Dani','1989-04-16',5,182,'Espagnol','Milieu','Droit',NULL,12,1)
    ,(266,'Capoue','Etienne','1988-07-11',6,189,'Français','Milieu','Droit',NULL,12,3)
    ,(267,'Pino','Yeremi','2002-10-20',21,172,'Espagnol','Milieu',NULL,NULL,12,1)
    ,(268,'Groeneveld','Arnaut','1997-01-31',15,178,'Néerlandais','Attaquant','Ambidextre',NULL,12,19)
    ,(269,'Trigueros','Manuel','1991-10-17',14,178,'Espagnol','Milieu','Droit',NULL,12,1)
    ,(270,'Moraes','Ederson','1993-08-17',31,188,'Brésilien','Gardien de But','Gauche',NULL,13,2)
    ,(271,'Cancelo','Joao','1994-05-27',27,182,'Portugais','Défenseur','Droit',NULL,13,15)
    ,(272,'Laporte','Aymeric','1994-05-27',14,191,'Espagnol','Défenseur','Gauche',NULL,13,1)
    ,(273,'Dias','Ruben','1997-05-14',3,186,'Portugais','Défenseur','Ambidextre',NULL,13,15)
    ,(274,'Walker','Kyle','1990-05-28',2,178,'Anglais','Défenseur','Droit',NULL,13,18)
    ,(275,'Silva','Bernardo','1994-08-10',20,173,'Portugais','Milieu','Gauche',NULL,13,15)
    ,(276,'Hernandez','Rodrigo','1996-06-22',16,191,'Espagnol','Milieu','Droit',NULL,13,1)
    ,(277,'Gundogan','Ilkay','1990-10-24',8,180,'Allemand','Milieu','Droit',NULL,13,7)
    ,(278,'Grealish','Jack','1995-09-10',10,175,'Anglais','Milieu','Droit',NULL,13,18)
    ,(279,'Foden','Phil','2000-05-28',47,171,'Anglais','Milieu','Gauche',NULL,13,18)
    ,(280,'Mahrez','Riyad','1991-02-21',26,179,'Algérien','Attaquant','Gauche',NULL,13,22)
    ,(281,'Oblak','Jan','1993-01-07',13,188,'Slovène','Gardien de But','Droit',NULL,14,45)
    ,(282,'Hermoso','Mario','1995-06-18',22,184,'Espagnol','Défenseur','Gauche',NULL,14,1)
    ,(283,'Gimenez','José','1995-01-20',2,185,'Urugayen','Défenseur','Droit',NULL,14,5)
    ,(284,'Savic','Stefan','1991-01-08',15,187,'Monténégrin','Défenseur','Droit',NULL,14,48)
    ,(285,'Resurreccion','Koke','1992-01-08',6,176,'Espagnol','Milieu','Droit',NULL,14,1)
    ,(286,'Carrasco','Yannick','1993-09-04',21,185,'Belge','Milieu','Ambidextre',NULL,14,6)
    ,(287,'Llorente','Marcos','1995-01-30',14,184,'Espagnol','Milieu','Droit',NULL,14,1)
    ,(288,'Lemar','Thomas','1995-11-12',11,171,'Français','Milieu','Gauche',NULL,14,3)
    ,(289,'De Paul','Rodrigo','1994-05-24',5,180,'Argentin','Milieu','Droit',NULL,14,14)
    ,(290,'Suarez','Luis','1987-01-24',9,182,'Urugayen','Attaquant','Droit',NULL,14,5)
    ,(291,'Griezmann','Antoine','1991-03-21',8,176,'Français','Attaquant','Gauche',NULL,14,3)
    ,(292,'Grbic','Ivo','1996-01-18',1,195,'Croate','Gardien de But','Droit',NULL,15,4)
    ,(293,'Mandava','Reinildo','1994-01-21',28,180,'Mozambicain','Défenseur','Gauche',NULL,15,51)
    ,(294,'Djalo','Tiago','2000-04-09',3,190,'Portugais','Défenseur','Droit',NULL,15,15)
    ,(295,'Fonte','José','1983-12-22',6,187,'Portugais','Défenseur','Droit',NULL,15,15)
    ,(296,'Celik','Zeki','1997-02-17',2,180,'Turc','Défenseur','Droit',NULL,15,43)
    ,(297,'Bamba','Jonathan','1996-03-26',7,175,'Français','Attaquant','Droit',NULL,15,3)
    ,(298,'Da Silva','Miguel Angelo','10//11/1994',8,185,'Portugais','Milieu','Droit',NULL,15,15)
    ,(299,'André','Benjamin','1990-08-03',21,180,'Français','Milieu','Droit',NULL,15,3)
    ,(300,'Weah','Timothy','2000-02-22',22,183,'Américain','Attaquant','Droit',NULL,15,32)
    ,(301,'Yilmaz','Burak','1985-07-15',17,188,'Turc','Attaquant','Droit',NULL,15,43)
    ,(302,'David','Jonathan','2000-01-14',9,177,'Canadien','Attaquant','Droit',NULL,15,30)
    ,(303,'Nubel','Alexander','1996-09-30',16,193,'Allemand','Gardien de But','Droit',NULL,16,7)
    ,(304,'Henrique','Caio','1997-07-31',12,179,'Brésilien','Défenseur','Gauche',NULL,16,2)
    ,(305,'Badiashile','Benoit','2001-03-26',5,194,'Français','Défenseur','Droit',NULL,16,3)
    ,(306,'Disasi','Axel','1998-03-11',6,190,'Français','Défenseur','Droit',NULL,16,3)
    ,(307,'Sidibé','Djibril','1992-07-29',19,182,'Français','Défenseur','Droit',NULL,16,3)
    ,(308,'Golovin','Aleksandr','1996-05-30',17,180,'Russe','Milieu','Droit',NULL,16,50)
    ,(309,'Tchouaméni','Aurélien','2000-01-27',8,185,'Français','Milieu','Droit',NULL,16,3)
    ,(310,'Fofana','Youssouf','1999-01-10',22,178,'Français','Milieu',NULL,NULL,16,3)
    ,(311,'Martins','Gelson','1995-05-11',7,173,'Portugais','Milieu','Droit',NULL,16,15)
    ,(312,'Volland','Kevin','1992-07-30',31,178,'Allemand','Attaquant','Gauche',NULL,16,7)
    ,(313,'Ben Yedder','Wissam','1990-08-12',10,170,'Français','Attaquant','Droit',NULL,16,3)
    ,(314,'Weah','George','1966-10-01',9,184,'Libérien','Attaquant',NULL,'King George',16,47)
    ,(315,'Drogba','Didier','1978-03-11',11,189,'Ivoirien','Attaquant','Droit','Drogbadaboum',11,37)
    ,(316,'Maradona','Diego','1960-10-30',10,167,'Argentin','Milieu','Gauche','El Pibe de Oro',18,14)
    ,(317,'do Nascimento','Pelé','1940-10-23',10,173,'Brésilien','Attaquant','Ambidextre','Le Roi Pelé',19,2)
    ,(318,'Nazario','Ronaldo','1976-09-22',9,183,'Brésilien','Attaquant',NULL,'El Fenomeno',1,2)
    ,(319,'Moreira','Ronaldinho','1980-03-21',10,182,'Brésilien','Milieu','Droit','Ronnie',6,2)
    ,(320,'Cruyff','Johan','1947-04-25',14,178,'Néerlandais','Attaquant','Ambidextre','Le Hollandais Volant',20,19)
    ,(321,'Beckham','David','1975-05-02',7,180,'Anglais','Milieu','Droit','Le Spice Boy',8,18)
    ,(322,'Beckenbauer','Franz','1945-09-11',5,181,'Allemand','Défenseur',NULL,'Der Kaiser',4,7)
    ,(323,'Muller','Gerd','1945-11-03',9,177,'Allemand','Attaquant',NULL,'Der Bomber',4,7)
    ,(324,'Zidane','Zinédine','1972-06-23',5,185,'Français','Milieu','Droit','Zizou',1,3)
    ,(325,'Platini','Michel','1955-06-21',10,178,'Français','Milieu',NULL,'Platoch''',5,3)
    ,(326,'Cantona','Eric','1966-05-24',7,188,'Français','Attaquant',NULL,'Eric the King',8,3)
    ,(327,'Deschamps','Didier','1968-10-15',14,174,'Français','Milieu','Droit','Dédé',5,3);

INSERT INTO icones(no_joueur_icone,debut_carriere,fin_carriere,profession_actuelle,moment_memorable,decede,date_deces)
    VALUES
    (314,'1988-08-17','2001-02-17','Président du Libéria','Ballon d''or 1995','false',NULL),
    (315,'2002-01-30','2018-11-09',NULL,'Vainqueur Ligue des Champions 2012','false',NULL),
    (316,'1976-10-20','1997-11-01',NULL,'But contre l''Angleterre','true','2020-11-25'),
    (317,'1956-09-07','1977-10-01',NULL,'Meilleur joueur mondial du siècle','false',NULL),
    (318,'1990-08-12','2011-02-14',NULL,'Deux fois Ballon d''or','false',NULL),
    (319,'2001-08-04','2018-01-16',NULL,'Vainqueur coupe du monde 2002','false',NULL),
    (320,'1964-11-15','1984-07-01',NULL,'Trois fois Ballon d''or','true','2016-03-24'),
    (321,'1995-04-02','2013-05-18','Propriétaire de L''inter Miami CF','Premier League Hall of Fame','false',NULL),
    (322,'1964-06-06','1983-07-01',NULL,'Deux fois Ballon d''or','false',NULL),
    (323,'1963-07-01','1982-07-01',NULL,'Ballon d''or 1970','true','2021-08-15'),
    (324,'1989-05-20','2006-05-07','Entraineur','Ballon d''or 1998','false',NULL),
    (325,'1973-05-02','1987-05-17',NULL,'Trois fois Ballon d''or','false',NULL),
    (326,'1983-11-05','1987-05-18',NULL,'Prix du président de l''UEFA 2019','false',NULL),
    (327,'1985-09-27','2001-07-01','Sélectionneur Equipe de France','Vainqueur coupe du monde 1998','false',NULL);


INSERT INTO saisons (no_saison,date_debut,date_fin)
    VALUES
    (1,'2020-08-01','2021-05-31'),
    (2,'2019-08-01','2020-05-31'),
    (3,'2018-08-01','2019-05-31'),
    (4,'2017-08-01','2018-05-31'),
    (5,'2016-08-01','2017-05-31');

INSERT INTO statistiques(no_joueur,no_saison,buts,passes_decisives,cartons_jaunes,cartons_rouges,nb_matchs)
    VALUES
    (18,1,2,0,1,1,12)
    ,(19,1,35,11,4,0,48)
    ,(20,1,3,1,1,0,13)
    ,(22,1,0,1,4,0,4)
    ,(23,1,20,3,4,1,27)
    ,(24,1,8,10,2,0,48)
    ,(25,1,34,0,0,1,57)
    ,(26,1,5,0,0,1,7)
    ,(41,1,9,8,4,1,32)
    ,(48,1,4,8,5,1,52)
    ,(49,1,33,12,0,0,36)
    ,(50,1,13,0,4,0,32)
    ,(72,1,5,2,0,0,6)
    ,(73,1,11,8,2,1,42)
    ,(74,1,20,5,4,0,44)
    ,(75,1,0,0,2,0,2)
    ,(76,1,3,11,3,0,41)
    ,(77,1,2,0,1,1,2)
    ,(78,1,5,7,4,0,25)
    ,(92,1,1,0,5,1,1)
    ,(93,1,30,9,5,0,39)
    ,(96,1,17,3,0,0,35)
    ,(98,1,48,5,4,1,51)
    ,(99,1,35,4,3,0,55)
    ,(113,1,0,1,1,0,11)
    ,(114,1,32,9,0,1,41)
    ,(118,1,16,2,0,1,21)
    ,(119,1,27,2,0,1,41)
    ,(120,1,8,12,0,1,48)
    ,(132,1,1,3,4,0,10)
    ,(138,1,8,1,3,0,28)
    ,(139,1,28,9,3,1,35)
    ,(140,1,47,4,2,1,52)
    ,(141,1,11,2,0,1,23)
    ,(142,1,32,18,2,1,55)
    ,(143,1,2,2,2,1,24)
    ,(144,1,22,8,0,0,26)
    ,(153,1,32,11,1,0,35)
    ,(160,1,30,2,5,1,42)
    ,(161,1,0,0,3,1,2)
    ,(162,1,3,5,0,0,16)
    ,(163,1,7,1,3,1,11)
    ,(176,1,20,2,0,1,52)
    ,(177,1,11,5,5,0,17)
    ,(180,1,45,8,3,0,45)
    ,(184,1,17,5,0,0,43)
    ,(185,1,6,4,0,1,14)
    ,(187,1,27,9,0,1,37)
    ,(202,1,9,2,5,1,9)
    ,(209,1,26,9,1,0,39)
    ,(210,1,0,0,1,1,0)
    ,(211,1,11,8,2,1,52)
    ,(212,1,15,0,4,1,15)
    ,(233,1,24,8,2,1,59)
    ,(234,1,24,9,3,1,31)
    ,(235,1,9,2,3,1,22)
    ,(237,1,29,5,2,0,43)
    ,(246,1,3,1,0,0,11)
    ,(247,1,40,8,0,0,55)
    ,(255,1,31,7,0,1,34)
    ,(257,1,19,15,5,0,49)
    ,(268,1,23,3,2,0,29)
    ,(280,1,26,16,5,0,51)
    ,(290,1,45,13,2,1,54)
    ,(291,1,8,5,4,1,23)
    ,(297,1,3,17,3,0,60)
    ,(300,1,3,0,4,0,6)
    ,(301,1,0,1,5,0,3)
    ,(302,1,32,14,5,1,42)
    ,(312,1,15,4,1,1,52)
    ,(313,1,33,12,2,1,51)
    ,(18,2,7,1,4,0,9)
    ,(19,2,0,1,1,0,9)
    ,(20,2,6,3,1,1,43)
    ,(22,2,53,0,0,1,60)
    ,(23,2,9,6,3,1,46)
    ,(24,2,11,1,4,1,11)
    ,(25,2,21,6,2,1,58)
    ,(26,2,3,0,1,1,3)
    ,(41,2,30,11,5,0,58)
    ,(48,2,29,11,2,0,43)
    ,(49,2,19,5,4,0,32)
    ,(50,2,26,1,3,0,34)
    ,(72,2,6,1,3,0,6)
    ,(73,2,4,4,2,0,56)
    ,(74,2,1,6,2,0,53)
    ,(75,2,0,0,4,0,0)
    ,(76,2,8,5,2,1,32)
    ,(77,2,10,8,4,1,33)
    ,(78,2,11,7,3,0,29)
    ,(92,2,18,13,0,1,40)
    ,(93,2,7,10,4,0,39)
    ,(96,2,2,11,2,0,58)
    ,(98,2,37,9,1,0,51)
    ,(99,2,5,1,2,1,8)
    ,(113,2,3,1,3,0,19)
    ,(114,2,9,8,2,1,24)
    ,(118,2,2,1,4,0,5)
    ,(119,2,10,3,2,0,38)
    ,(120,2,11,6,0,1,19)
    ,(132,2,13,7,2,0,43)
    ,(138,2,3,8,1,1,24)
    ,(139,2,37,12,1,1,43)
    ,(140,2,4,0,5,1,4)
    ,(141,2,1,1,2,1,5)
    ,(142,2,34,13,4,0,53)
    ,(143,2,27,6,5,0,47)
    ,(144,2,0,0,4,1,1)
    ,(153,2,31,15,2,1,47)
    ,(160,2,25,5,0,1,29)
    ,(161,2,16,6,2,1,22)
    ,(162,2,35,4,1,0,37)
    ,(163,2,22,4,4,0,25)
    ,(176,2,5,3,3,0,44)
    ,(177,2,2,0,0,1,2)
    ,(180,2,14,0,1,0,19)
    ,(184,2,4,3,5,1,36)
    ,(185,2,9,3,2,0,28)
    ,(187,2,0,1,1,1,5)
    ,(202,2,4,0,1,1,5)
    ,(209,2,39,9,1,0,54)
    ,(210,2,24,1,5,1,24)
    ,(211,2,40,12,2,1,42)
    ,(212,2,43,18,1,1,54)
    ,(233,2,17,2,4,0,18)
    ,(234,2,8,8,3,0,51)
    ,(235,2,0,0,3,1,16)
    ,(237,2,7,15,4,0,59)
    ,(246,2,43,7,3,0,44)
    ,(247,2,4,0,0,0,5)
    ,(255,2,0,0,4,1,3)
    ,(257,2,45,17,4,1,51)
    ,(268,2,2,1,0,0,10)
    ,(280,2,21,3,3,0,41)
    ,(290,2,59,9,1,1,60)
    ,(291,2,8,3,2,0,11)
    ,(297,2,6,8,0,1,24)
    ,(300,2,38,12,3,1,43)
    ,(301,2,35,12,3,1,45)
    ,(302,2,15,0,4,1,16)
    ,(312,2,3,1,2,0,9)
    ,(313,2,26,9,1,1,39)
    ,(18,3,25,9,5,0,58)
    ,(19,3,7,14,1,1,51)
    ,(20,3,16,6,5,0,35)
    ,(22,3,27,11,4,1,35)
    ,(23,3,9,1,3,1,20)
    ,(24,3,34,9,5,0,44)
    ,(25,3,2,1,4,1,18)
    ,(26,3,21,5,1,1,40)
    ,(41,3,11,3,3,1,15)
    ,(48,3,19,14,5,0,42)
    ,(49,3,1,1,0,1,4)
    ,(50,3,13,3,1,0,20)
    ,(72,3,41,4,5,1,56)
    ,(73,3,45,9,0,0,56)
    ,(74,3,38,12,0,1,47)
    ,(75,3,23,8,3,1,26)
    ,(76,3,5,1,1,1,37)
    ,(77,3,15,7,1,1,38)
    ,(78,3,1,0,1,1,3)
    ,(92,3,40,1,1,0,45)
    ,(93,3,26,4,5,1,38)
    ,(96,3,4,1,0,1,12)
    ,(98,3,10,5,3,1,40)
    ,(99,3,1,0,4,0,9)
    ,(113,3,2,0,1,0,3)
    ,(114,3,19,2,2,1,36)
    ,(118,3,0,0,0,0,0)
    ,(119,3,6,3,4,0,11)
    ,(120,3,17,4,2,0,18)
    ,(132,3,6,2,4,0,12)
    ,(138,3,7,2,4,0,15)
    ,(139,3,46,8,2,0,53)
    ,(140,3,5,5,1,1,15)
    ,(141,3,5,11,0,1,41)
    ,(142,3,30,5,3,1,45)
    ,(143,3,3,2,1,1,6)
    ,(144,3,42,0,2,1,52)
    ,(153,3,10,4,0,1,16)
    ,(160,3,4,3,3,1,13)
    ,(161,3,40,8,5,1,42)
    ,(162,3,26,7,2,0,32)
    ,(163,3,6,6,5,0,27)
    ,(176,3,10,3,4,0,32)
    ,(177,3,20,9,2,1,52)
    ,(180,3,14,5,1,0,30)
    ,(184,3,38,4,4,1,43)
    ,(185,3,6,2,4,1,20)
    ,(187,3,7,3,3,1,26)
    ,(202,3,0,0,2,0,1)
    ,(209,3,34,0,4,0,48)
    ,(210,3,27,9,1,1,48)
    ,(211,3,4,2,2,1,26)
    ,(212,3,0,2,2,1,18)
    ,(233,3,6,1,5,0,7)
    ,(234,3,10,4,4,0,13)
    ,(235,3,46,17,0,0,57)
    ,(237,3,56,16,1,1,57)
    ,(246,3,11,1,4,1,20)
    ,(247,3,48,10,5,0,57)
    ,(255,3,2,0,5,1,2)
    ,(257,3,19,5,4,1,36)
    ,(268,3,7,1,1,1,57)
    ,(280,3,9,7,2,1,46)
    ,(290,3,7,0,1,1,16)
    ,(291,3,4,4,3,0,16)
    ,(297,3,23,17,0,0,58)
    ,(300,3,2,0,0,1,3)
    ,(301,3,1,0,2,1,2)
    ,(302,3,20,0,0,1,35)
    ,(312,3,38,10,2,1,60)
    ,(313,3,2,0,4,1,4)
    ,(18,4,18,12,0,0,45)
    ,(19,4,26,7,2,1,37)
    ,(20,4,0,1,5,0,22)
    ,(22,4,8,9,1,1,27)
    ,(23,4,16,1,4,1,23)
    ,(24,4,10,9,4,1,56)
    ,(25,4,58,14,5,1,60)
    ,(26,4,16,4,0,0,26)
    ,(41,4,18,5,5,0,38)
    ,(48,4,12,13,4,0,58)
    ,(49,4,37,14,2,1,48)
    ,(50,4,5,1,5,0,11)
    ,(72,4,0,1,3,1,5)
    ,(73,4,20,8,4,0,38)
    ,(74,4,2,1,4,0,4)
    ,(75,4,7,5,2,0,24)
    ,(76,4,2,1,0,0,5)
    ,(77,4,12,1,4,0,21)
    ,(78,4,0,3,5,0,9)
    ,(92,4,21,4,1,0,28)
    ,(93,4,20,13,2,0,50)
    ,(96,4,0,4,3,0,29)
    ,(98,4,12,4,0,0,23)
    ,(99,4,16,10,4,1,32)
    ,(113,4,15,10,5,0,37)
    ,(114,4,12,6,1,0,24)
    ,(118,4,27,7,5,0,29)
    ,(119,4,23,7,4,1,24)
    ,(120,4,2,1,5,0,22)
    ,(132,4,1,1,3,1,4)
    ,(138,4,3,1,5,1,4)
    ,(139,4,5,2,5,0,15)
    ,(140,4,1,0,5,0,9)
    ,(141,4,1,2,1,1,6)
    ,(142,4,25,9,0,0,28)
    ,(143,4,15,1,1,1,32)
    ,(144,4,20,1,4,0,35)
    ,(153,4,4,5,2,0,19)
    ,(160,4,44,10,4,1,59)
    ,(161,4,25,15,4,1,45)
    ,(162,4,47,7,4,0,52)
    ,(163,4,43,0,2,1,56)
    ,(176,4,14,15,2,0,56)
    ,(177,4,0,0,3,0,4)
    ,(180,4,27,6,5,1,29)
    ,(184,4,6,2,2,0,9)
    ,(185,4,6,0,2,0,7)
    ,(187,4,3,9,0,1,60)
    ,(202,4,8,3,1,0,9)
    ,(209,4,3,1,0,1,3)
    ,(210,4,34,12,2,0,48)
    ,(211,4,14,1,1,0,22)
    ,(212,4,0,0,1,1,2)
    ,(233,4,20,3,0,1,52)
    ,(234,4,18,3,1,1,31)
    ,(235,4,6,2,4,1,14)
    ,(237,4,4,4,0,1,31)
    ,(246,4,7,2,1,1,7)
    ,(247,4,3,1,2,1,23)
    ,(255,4,2,0,1,1,7)
    ,(257,4,21,0,0,0,28)
    ,(268,4,16,2,1,0,41)
    ,(280,4,3,0,3,0,7)
    ,(290,4,3,0,3,1,3)
    ,(291,4,0,0,5,1,0)
    ,(297,4,36,5,3,0,39)
    ,(300,4,9,6,3,1,35)
    ,(301,4,19,6,1,0,32)
    ,(302,4,17,0,2,1,21)
    ,(312,4,25,7,1,0,41)
    ,(313,4,13,5,3,1,41)
    ,(18,5,0,3,1,1,28)
    ,(19,5,4,3,4,1,9)
    ,(20,5,24,5,2,1,35)
    ,(22,5,12,13,0,0,44)
    ,(23,5,51,9,0,0,55)
    ,(24,5,36,8,4,0,41)
    ,(25,5,26,1,2,0,45)
    ,(26,5,2,7,1,0,29)
    ,(41,5,39,10,3,1,45)
    ,(48,5,0,0,3,0,0)
    ,(49,5,12,0,2,1,16)
    ,(50,5,17,2,1,0,23)
    ,(72,5,23,5,5,1,30)
    ,(73,5,5,4,1,0,18)
    ,(74,5,11,3,3,1,17)
    ,(75,5,29,0,1,0,50)
    ,(76,5,56,13,3,0,57)
    ,(77,5,10,3,2,1,16)
    ,(78,5,1,0,0,1,10)
    ,(92,5,1,3,3,0,19)
    ,(93,5,4,1,1,0,15)
    ,(96,5,7,4,4,1,43)
    ,(98,5,26,8,5,1,58)
    ,(99,5,1,8,5,0,44)
    ,(113,5,39,5,2,1,47)
    ,(114,5,6,6,4,1,34)
    ,(118,5,2,3,0,0,29)
    ,(119,5,18,1,4,0,21)
    ,(120,5,1,6,4,1,26)
    ,(132,5,25,0,3,0,33)
    ,(138,5,24,6,3,1,35)
    ,(139,5,29,0,3,0,42)
    ,(140,5,27,0,5,0,33)
    ,(141,5,1,0,0,1,5)
    ,(142,5,3,5,5,1,49)
    ,(143,5,13,2,1,0,35)
    ,(144,5,3,0,0,0,3)
    ,(153,5,12,11,0,0,52)
    ,(160,5,6,1,2,1,17)
    ,(161,5,17,14,5,1,46)
    ,(162,5,30,10,0,1,31)
    ,(163,5,6,0,5,1,50)
    ,(176,5,31,2,4,1,37)
    ,(177,5,24,5,2,1,36)
    ,(180,5,26,18,3,0,54)
    ,(184,5,3,3,5,0,15)
    ,(185,5,37,10,2,1,46)
    ,(187,5,19,5,0,1,20)
    ,(202,5,9,7,3,0,41)
    ,(209,5,4,1,3,0,22)
    ,(210,5,23,18,3,1,60)
    ,(211,5,15,9,0,1,38)
    ,(212,5,30,14,0,0,58)
    ,(233,5,2,2,3,0,12)
    ,(234,5,28,7,3,0,38)
    ,(235,5,4,9,3,0,43)
    ,(237,5,5,0,5,1,7)
    ,(246,5,33,11,5,0,38)
    ,(247,5,4,2,5,0,27)
    ,(255,5,42,2,3,0,59)
    ,(257,5,9,2,1,1,24)
    ,(268,5,6,8,3,0,33)
    ,(280,5,3,3,1,1,9)
    ,(290,5,2,1,3,1,7)
    ,(291,5,20,1,4,1,24)
    ,(297,5,12,6,2,0,22)
    ,(300,5,32,7,4,1,32)
    ,(301,5,21,10,4,1,32)
    ,(302,5,8,0,4,1,18)
    ,(312,5,39,14,5,1,59)
    ,(313,5,11,2,1,0,21);

INSERT INTO blessures(no_blessure,date_debut_blessure,nom_blessure,date_fin_blessure,no_joueur)
    VALUES
    (1,'2021-07-22','Blessure à la cheville','2021-11-19',11),
    (2,'2021-10-25','Foulure','2021-11-19',21),
    (3,'2021-10-31','Blessure à l''ischio','2021-11-19',25),
    (4,'2021-10-31','Opération du nez','2021-11-19',26),
    (5,'2021-11-15','Blessure au mollet',NULL,23),
    (6,'2021-10-25','Blessure à la hanche','2021-11-30',39),
    (7,'2021-11-10','Blessure musculaire',NULL,52),
    (8,'2021-11-05','Blessure à l''ischio',NULL,72),
    (9,'2021-09-13','Fracture de la cheville avec dislocation',NULL,71),
    (10,'2021-11-06','Problèmes aux adducteurs',NULL,103),
    (11,'2021-08-30','Blessure au genou','2021-12-30',141),
    (12,'2021-09-30','Blessure musculaire','2021-12-22',133),
    (13,'2021-10-31','Problème de cœur','2022-02-01',144),
    (14,'2021-11-07','Blessure à l''ischio','2021-12-07',140),
    (15,'2021-11-02','Lumbago','2021-11-22',137),
    (16,'2021-11-04','Blessure à l''ischio',NULL,138),
    (17,'2021-09-23','Fissure du péroné',NULL,160),
    (18,'2021-11-10','Blessure à l''ischio','2021-12-31',174),
    (19,'2021-11-02','Blessure à l''ischio','2021-11-30',169),
    (20,'2021-10-31','Irritation du tendon',NULL,187),
    (21,'2021-09-04','Blessure musculaire',NULL,199),
    (22,'2021-10-22','Probèmes aux fléchisseurs de la hanche',NULL,209),
    (23,'2021-10-22','Fibre musculaire',NULL,193),
    (24,'2021-11-04','Blessure à l''ischio',NULL,208),
    (25,'2021-11-11','Inflammation',NULL,210),
    (26,'2021-06-13','Problème de cœur',NULL,229),
    (27,'2021-11-13','Elongation de la cuisse droite',NULL,215),
    (28,'2021-11-17','Problèmes musculaires',NULL,233);

INSERT INTO competitions(no_compet,nom_compet,pays_compet,organisateur,type_compet)
    VALUES
    (1,'Euro',NULL,'UEFA','Equipe nationale'),
    (2,'Coupe du monde',NULL,'FIFA','Equipe nationale'),
    (3,'Liga','Espagne','Liga de Fútbol Profesional','Club'),
    (4,'Premier League','Angleterre','The F.A. Premier League','Club'),
    (5,'Serie A','Italie','FIGC - Lega Serie A','Club'),
    (6,'Bundesliga','Allemagne','Deutsche Fußball-Liga','Club'),
    (7,'Ligue 1','France','LFP','Club'),
    (8,'Ligue des Champions',NULL,'UEFA','Club'),
    (9,'Ligue Europa',NULL,'UEFA','Club'),
    (10,'CAN',NULL,'CAF','Equipe nationale'),
    (11,'Copa America',NULL,'CONMEBOL','Equipe nationale');

INSERT INTO trophees(no_tr,nom_tr,description,type_tr,no_compet,no_saison,no_club,no_equipe,no_joueur)
    VALUES
    (1,'Coupe Henri Delaunay','Meilleure nation européenne','Equipe nationale',1,1,NULL,17,NULL),
    (2,'Coupe Jules Rimet','Meilleure nation mondiale','Equipe nationale',2,4,NULL,3,NULL),
    (3,'Liga','Meilleur club espagnol','Club',3,1,14,NULL,NULL),
    (4,'Liga','Meilleur club espagnol','Club',3,2,1,NULL,NULL),
    (5,'Liga','Meilleur club espagnol','Club',3,3,6,NULL,NULL),
    (6,'Liga','Meilleur club espagnol','Club',3,4,6,NULL,NULL),
    (7,'Liga','Meilleur club espagnol','Club',3,5,1,NULL,NULL),
    (8,'Premier League','Meilleur club anglais','Club',4,1,13,NULL,NULL),
    (9,'Premier League','Meilleur club anglais','Club',4,2,3,NULL,NULL),
    (10,'Premier League','Meilleur club anglais','Club',4,3,13,NULL,NULL),
    (11,'Premier League','Meilleur club anglais','Club',4,4,13,NULL,NULL),
    (12,'Premier League','Meilleur club anglais','Club',4,5,11,NULL,NULL),
    (13,'Le Scudetto','Meilleur club italien','Club',5,1,10,NULL,NULL),
    (14,'Le Scudetto','Meilleur club italien','Club',5,2,5,NULL,NULL),
    (15,'Le Scudetto','Meilleur club italien','Club',5,3,5,NULL,NULL),
    (16,'Le Scudetto','Meilleur club italien','Club',5,4,5,NULL,NULL),
    (17,'Le Scudetto','Meilleur club italien','Club',5,5,5,NULL,NULL),
    (18,'Le Bouclier','Meilleur club allemand','Club',6,1,4,NULL,NULL),
    (19,'Le Bouclier','Meilleur club allemand','Club',6,2,4,NULL,NULL),
    (20,'Le Bouclier','Meilleur club allemand','Club',6,3,4,NULL,NULL),
    (21,'Le Bouclier','Meilleur club allemand','Club',6,4,4,NULL,NULL),
    (22,'Le Bouclier','Meilleur club allemand','Club',6,5,4,NULL,NULL),
    (23,'L''Hexagoal','Meilleur club français','Club',7,1,15,NULL,NULL),
    (24,'L''Hexagoal','Meilleur club français','Club',7,2,2,NULL,NULL),
    (25,'L''Hexagoal','Meilleur club français','Club',7,3,2,NULL,NULL),
    (26,'L''Hexagoal','Meilleur club français','Club',7,4,2,NULL,NULL),
    (27,'L''Hexagoal','Meilleur club français','Club',7,5,16,NULL,NULL),
    (28,'La Coupe aux grandes oreilles','Meilleur club européen','Club',8,1,11,NULL,NULL),
    (29,'La Coupe aux grandes oreilles','Meilleur club européen','Club',8,2,4,NULL,NULL),
    (30,'La Coupe aux grandes oreilles','Meilleur club européen','Club',8,3,3,NULL,NULL),
    (31,'La Coupe aux grandes oreilles','Meilleur club européen','Club',8,4,1,NULL,NULL),
    (32,'La Coupe aux grandes oreilles','Meilleur club européen','Club',8,5,1,NULL,NULL),
    (33,'CAN','Meilleure nation africaine','Equipe nationale',10,3,NULL,22,NULL),
    (34,'CAN','Meilleure nation africaine','Equipe nationale',10,5,NULL,25,NULL),
    (35,'Copa America','Meilleure équipe sud-américaine','Equipe nationale',11,1,NULL,14,NULL),
    (36,'Copa America','Meilleure équipe sud-américaine','Equipe nationale',11,3,NULL,2,NULL),
    (37,'Ballon d''or','Meilleur joueur de l''année','Individuel',NULL,1,NULL,NULL,48),
    (38,'Ballon d''or','Meilleur joueur de l''année','Individuel',NULL,3,NULL,NULL,48),
    (39,'Ballon d''or','Meilleur joueur de l''année','Individuel',NULL,4,NULL,NULL,13),
    (40,'Ballon d''or','Meilleur joueur de l''année','Individuel',NULL,5,NULL,NULL,184),
    (41,'Soulier d''or','Meilleur buteur d''Europe','Individuel',NULL,1,NULL,NULL,98),
    (42,'Soulier d''or','Meilleur buteur d''Europe','Individuel',NULL,2,NULL,NULL,237),
    (43,'Soulier d''or','Meilleur buteur d''Europe','Individuel',NULL,3,NULL,NULL,48),
    (44,'Soulier d''or','Meilleur buteur d''Europe','Individuel',NULL,4,NULL,NULL,48),
    (45,'Soulier d''or','Meilleur buteur d''Europe','Individuel',NULL,5,NULL,NULL,48);

INSERT INTO transferts(no_transfert,montant,date_transfert,no_joueur,no_club_depart,no_club_arrivee)
    VALUES
    (1,NULL,'2021-07-01',5,4,1),
    (2,40000000,'2021-08-14',169,1,8),
    (3,NULL,'2021-07-08',29,1,2),
    (4,NULL,'2021-08-10',48,6,2),
    (5,60000000,'2021-07-06',30,10,2),
    (6,NULL,'2021-07-01',44,3,2),
    (7,6000000,'2021-08-23',158,3,7),
    (8,20000000,'2021-08-31',184,5,8),
    (9,NULL,'2021-09-01',152,4,7),
    (10,NULL,'2021-07-01',139,6,7),
    (11,85000000,'2021-07-23',180,9,8),
    (12,115000000,'2021-08-12',257,10,11);







/*DROP TABLE trophees;
DROP TABLE competitions;
DROP TABLE blessures;
DROP TABLE transferts;
DROP TABLE statistiques;
DROP TABLE saisons;
DROP TABLE icones;
DROP TABLE joueurs;
DROP TABLE equipes_nationales;
DROP TABLE clubs;
DROP TABLE utilisateurs;*/