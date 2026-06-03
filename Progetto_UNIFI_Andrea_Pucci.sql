DROP DATABASE IF EXISTS Catena_di_negozi_CIOCIAMON;
CREATE DATABASE Catena_di_negozi_CIOCIAMON;
USE Catena_di_negozi_CIOCIAMON;

-- -- -- -- -- -- -- -- --
--  CREAZIONE TABELLE   --
-- -- -- -- -- -- -- -- --



CREATE TABLE IF NOT EXISTS Categorie (
Tipo CHAR(6) PRIMARY KEY,
Sconto INT 
)ENGINE=INNODB;



CREATE TABLE IF NOT EXISTS  Tessere (
Id_Tessera INT PRIMARY KEY AUTO_INCREMENT,
Punti BIGINT,
Tipo_Tessera VARCHAR(6) REFERENCES Categorie(Tipo) ON UPDATE CASCADE
)ENGINE=INNODB;



CREATE TABLE IF NOT EXISTS  Clienti (
Cod_Fiscale VARCHAR(16) PRIMARY KEY,
Nome CHAR(20) NOT NULL,
Cognome CHAR(20) NOT NULL,
Via  VARCHAR(40) NOT NULL,
Città CHAR(20) NOT NULL,
CAP CHAR(20) NOT NULL,
Provincia CHAR(2) NOT NULL,
Num_Tessera INT REFERENCES Tessere(Id_Tessera)
)ENGINE=INNODB;



CREATE TABLE IF NOT EXISTS  Ordini (
Id_ordine INT AUTO_INCREMENT PRIMARY KEY,
Data_ordine DATE NOT NULL,
Importo INT NOT NULL,
Codice_Fiscale VARCHAR(16) REFERENCES Clienti(Cod_Fiscale),
Partita_IVA INT REFERENCES Negozi(P_IVA)
)ENGINE=INNODB;



CREATE TABLE IF NOT EXISTS Prodotti (
Id_prodotto VARCHAR(25) PRIMARY KEY,
Nome_prodotto CHAR(20) NOT NULL,
Prezzo INT NOT NULL,
Tipologia_prodotto CHAR(50) NOT NULL,
Brand CHAR(10) NOT NULL,
Materiale CHAR(50),
Espansione CHAR(50),
Rarità CHAR(50),
Disponibilità_prodotto INT NOT NULL
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Spedizioni (
Id_ordine INT NOT NULL,
Id_prodotto VARCHAR(25) NOT NULL,
Quantità INT,
PRIMARY KEY (Id_ordine,Id_prodotto),
FOREIGN KEY (Id_ordine) REFERENCES Ordini (Id_ordine),
FOREIGN KEY (Id_prodotto) REFERENCES Prodotti(Id_prodotto)
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Impiegati (
N_dipendenti INT PRIMARY KEY,
Ruolo CHAR(15) NOT NULL,
Nome CHAR(20) NOT NULL,
Cognome CHAR(20) NOT NULL,
Email VARCHAR(50) NOT NULL UNIQUE,
Stipendio INT NOT NULL,
Data_inizio_contratto DATE NOT NULL DEFAULT '2000-01-01',
Sede_lavoro INT REFERENCES Negozi(P_IVA)

)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS Negozi (
P_IVA INT PRIMARY KEY,
Via  CHAR(20) NOT NULL,
Città CHAR(20) NOT NULL,
CAP CHAR(20) NOT NULL,
Provincia CHAR(2) NOT NULL,
Telefono VARCHAR(13) NOT NULL UNIQUE
)ENGINE=INNODB;



CREATE TABLE IF NOT EXISTS Tornei(
Id_evento VARCHAR(20) PRIMARY KEY,
Nome CHAR(20) NOT NULL,
Data_torneo DATE NOT NULL,
Ora TIME NOT NULL,
Quota_iscrizione INT NOT NULL,
Premio VARCHAR(20) NOT NULL,
Luogo INT REFERENCES Negozi(P_IVA) ON UPDATE CASCADE
)ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS Partecipazioni(
Id_evento VARCHAR(20) NOT NULL,
Cod_fiscale VARCHAR(16) NOT NULL,
Vittoria BOOLEAN,
PRIMARY KEY (Id_evento,Cod_fiscale),
FOREIGN KEY (Id_evento) REFERENCES Tornei (Id_evento),
FOREIGN KEY (Cod_fiscale) REFERENCES Clienti(Cod_fiscale)
)ENGINE=INNODB;


-- -- -- -- -- -- -- -- --
--  POPOLAMENTO TABELLE --
-- -- -- -- -- -- -- -- --

INSERT INTO Categorie(Tipo, Sconto) VALUES
("Bronze" , 5),
("Silver" , 10),
("Gold" , 15);


INSERT INTO Tessere (Punti,Tipo_tessera) VALUES
(1000,"Bronze"),
(100,"Bronze"),
(10,"Silver"),
(1020,"Silver"),
(14,"Gold"),
(500,"Gold");

INSERT INTO Clienti(Cod_Fiscale, Nome, Cognome, Via, Città,CAP,Provincia,Num_Tessera) VALUES
("RSSMRA85M01H501Z", "Corrado" , "Ciocia", "Via malpighi 2", "Pistoia" ,51100, "PT",1),
("BNCGPP90D15F205Q", "Marco" , "Caso", "Via della croce 69", "Impruneta" ,50023, "FI",2),
("VRDLGU75R13H223J", "Antonio", "Mascani" , "Via degl'orti 12", "Pieve a nievole",51018, "PT",3),
("FBRLRA83C20L219T", "Leon" ,"Giunchi" ,"Via mascagni 56" , "Ravenna" , 48121 , "RV",4),
("MNTPLD68A01H703K", "Giacomo", "Ferrazza", "Via fucilata sul sinistro 34", "Firenze", 50066 , "FI",5),
("DGLSRN92T11H501P", "Diego" , "Lo Cioffi", "Via i know everything 1", "Livorno", 34002, "LI",6);

INSERT INTO Ordini(Data_ordine, Importo, Codice_Fiscale,Partita_IVA) VALUES 
('2019-01-21', 300, "RSSMRA85M01H501Z",123456789),
('2023-05-11', 1500, "RSSMRA85M01H501Z",987654321),
('2022-01-22', 48, "RSSMRA85M01H501Z",987654321),
('2022-01-22', 1596, "BNCGPP90D15F205Q",123456789),
('2015-08-13', 600, "VRDLGU75R13H223J",555555555),
('2005-03-21', 360, "FBRLRA83C20L219T",123456789),
('2019-01-21', 135, "MNTPLD68A01H703K",123456789),
('2021-04-14', 275, "DGLSRN92T11H501P",987654321),
('2022-05-20', 1395, "DGLSRN92T11H501P",987654321),
('2009-01-21', 12, "FBRLRA83C20L219T",555555555);

INSERT INTO Prodotti (Id_prodotto, Nome_prodotto, Prezzo, Tipologia_prodotto, Brand, Materiale, Espansione, Rarità, Disponibilità_prodotto) VALUES
('OPD-123A', 'Display OP1', 150, 'display', 'one piece', 'latta', NULL, NULL, 45),
('PKD-X456B', 'Display PK1', 120, 'display', 'pokemon', 'carta', NULL, NULL, 72),
('OPB-789C', 'Bustina OP Booster1', 5, 'bustina', 'one piece', NULL, 'Marine Wars', NULL, 19),
('PKB-234D', 'Bustina PK Booster1', 6, 'bustina', 'pokemon', NULL, 'Sky Legends', NULL, 88),
('OPC-567E', 'Carta OP Luffy', 20, 'carta singola', 'one piece', NULL, NULL, 'rara', 34),
('PKC-891F', 'Carta PK Pikachu', 15, 'carta singola', 'pokemon', NULL, NULL, 'super rara', 67),
('DGD-345G', 'Display DG1', 100, 'display', 'digimon', 'carta', NULL, NULL, 23),
('DGB-678H', 'Bustina DG Booster1', 4, 'bustina', 'digimon', NULL, 'Cyber Battle', NULL, 96),
('DGC-901I', 'Carta DG Agumon', 12, 'carta singola', 'digimon', NULL, NULL, 'comune', 11),
('PKC-123J', 'Carta PK Charizard', 50, 'carta singola', 'pokemon', NULL, NULL, 'super rara', 59);

INSERT INTO Spedizioni(Quantità,Id_Ordine, Id_prodotto) VALUES
(2, 1, 'OPD-123A'),
(10, 2, 'OPD-123A'),
(8,  2,'PKB-234D'),
(133, 4, 'DGC-901I'),
(12, 5, 'PKC-123J'),
(90,  1,'DGB-678H'),
(5,  7,'OPB-789C'),
(25, 1,'OPB-789C'),
(93, 3, 'PKC-891F'),
(1,  10,'DGC-901I'),
(56, 8, 'PKB-234D'),
(2,  9,'DGC-901I'),
(3, 6, 'PKC-891F');


INSERT INTO Impiegati(N_dipendenti, Ruolo,Nome ,Cognome, Email, Stipendio, Sede_lavoro, Data_inizio_contratto) VALUES
(1001, 'Capo', 'Marco', 'Rossi', 'marco.rossi@example.com', 29000, 123456789,'2024-01-01'),
(2002, 'Commesso', 'Luca', 'Bianchi', 'luca.bianchi@example.com', 17000, 555555555,'2023-11-21'),
(3003, 'Capo', 'Sara', 'Verdi', 'sara.verdi@example.com', 28000, 987654321,'2020-12-01'),
(4004, 'Commesso', 'Elisa', 'Neri', 'elisa.neri@example.com', 16000, 555555555,'2022-07-01'),
(5005, 'Capo', 'Gianni', 'Ferrari', 'gianni.ferrari@example.com', 27000, 555555555,'2023-11-01'),
(6006, 'Commesso', 'Anna', 'Russo', 'anna.russo@example.com', 15500, 555555555,'2024-01-21'),
(7007, 'Commesso', 'Paolo', 'Gialli', 'paolo.gialli@example.com', 16500, 555555555,'2023-05-1'),
(8008, 'Commesso', 'Carla', 'Bruni', 'carla.bruni@example.com', 17000, 987654321,'2019-01-22'),
(9009, 'Commesso', 'Davide', 'Verdi', 'davide.verdi@example.com', 17500, 987654321,'2024-04-09'),
(1010, 'Commesso', 'Sofia', 'Marrone', 'sofia.marrone@example.com', 16000, 987654321,'2022-06-08'),
(1111, 'Commesso', 'Mario', 'Gallo', 'mario.gallo@example.com', 15000, 123456789,'2020-12-17'),
(1212, 'Commesso', 'Laura', 'Blu', 'laura.blu@example.com', 16500, 123456789,'2022-10-16');

INSERT INTO Negozi (P_IVA, Via, Città, CAP, Provincia, Telefono) VALUES
(123456789, 'Via Roma', 'Milano', '20121', 'MI', '0123456789'),
(987654321, 'Corso Italia', 'Torino', '10121', 'TO', '0987654321'),
(555555555, 'Piazza Duomo', 'Firenze', '50122', 'FI', '0555555555');

INSERT INTO Tornei (Id_evento, Nome, Data_torneo, Ora, Quota_iscrizione, Premio,Luogo) VALUES
('EVT001', 'Torneo Primavera', '2024-05-15', '14:00:00', 50, 'Bustina',123456789),
('EVT002', 'Summer Challenge', '2024-07-10', '16:00:00', 75, 'Carta Singola',555555555),
('EVT003', 'Autumn Cup', '2024-09-21', '10:00:00', 60, 'Display',123456789),
('EVT004', 'Winter League', '2024-12-05', '18:30:00', 100, 'Bustina',123456789),
('EVT005', 'New Year Bash', '2025-01-03', '12:00:00', 80, 'Carta Singola',987654321);

INSERT INTO Partecipazioni (Id_evento, Cod_fiscale, Vittoria) VALUES
('EVT001', 'RSSMRA85M01H501Z', TRUE),   
('EVT001', 'BNCGPP90D15F205Q', FALSE), 
('EVT002', 'VRDLGU75R13H223J', TRUE),  
('EVT002', 'FBRLRA83C20L219T', FALSE), 
('EVT003', 'MNTPLD68A01H703K', TRUE),  
('EVT003', 'DGLSRN92T11H501P', FALSE), 
('EVT004', 'RSSMRA85M01H501Z', TRUE), 
('EVT005', 'FBRLRA83C20L219T', TRUE);  

-- -- -- -- -- -- -- -- --
--    INTERROGAZIONI    --
-- -- -- -- -- -- -- -- --

#### Trovare i commessi con stipendio maggiore di 17000 ######

SELECT * 
FROM Impiegati
WHERE Ruolo = 'Commesso' AND Stipendio >= 17000;

#### Trovare gli ordini eseguiti dal 2019-01-01 compreso (in ordine crescente) ####

SELECT *
FROM Ordini
WHERE Data_ordine > '2018-12-31'
ORDER BY Data_ordine ASC;

#### Trovare quali tornei sono stati svolti a milano  #####

SELECT T.Id_evento
FROM Tornei T JOIN Negozi N ON T.Luogo=N.P_IVA
WHERE N.città = 'Milano';

#### Trovare il numero di partecipazioni ai tornei dei clienti ####

SELECT 
    C.Nome, 
    C.Cognome, 
    C.Cod_Fiscale, 
    COUNT(*) AS Numero_Partecipazioni
FROM 
    Clienti C
JOIN 
    Partecipazioni P 
ON 
    C.Cod_Fiscale = P.Cod_fiscale
GROUP BY 
    C.Cod_Fiscale, C.Nome, C.Cognome
ORDER BY 
    Numero_Partecipazioni DESC;

#### Trovare nome,cognome e stipendio di tutti i commessi che lavorano a Firenze ####

SELECT I.Nome, I.Cognome, I.Stipendio
FROM Impiegati I JOIN Negozi N ON I.Sede_lavoro=N.P_IVA
WHERE I.Ruolo = 'Commesso' AND N.Città= 'Firenze';

#### Trovare nome e cognome dei clienti che hanno la tessera gold ####

SELECT C.Nome, C.Cognome
FROM Clienti C
JOIN Tessere T ON C.Num_Tessera = T.Id_Tessera
WHERE T.Tipo_tessera = 'Gold';

#### Trovare le tessere con 500 o più punti ####

SELECT * 
FROM Tessere 
WHERE Punti >= 500;

#### Trovare la spedizione con più prodotti diversi ####

SELECT Id_ordine, COUNT(DISTINCT Id_prodotto) AS Numero_prodotti_diversi
FROM Spedizioni
GROUP BY Id_ordine
ORDER BY Numero_prodotti_diversi DESC
LIMIT 1;

-- -- -- -- -- -- -- -- --
-- PROCEDURE E FUNZIONI --
-- -- -- -- -- -- -- -- --

#### Ricerca del capo di un negozio in cui lavora un dato dipendente ####
DELIMITER $$

CREATE PROCEDURE CapoCommesso(IN commesso_id INT)
BEGIN
    
    DECLARE negozio INT;

    
    SELECT Sede_lavoro INTO negozio
    FROM Impiegati
    WHERE N_dipendenti = commesso_id AND Ruolo = 'Commesso';

    
    SELECT Nome, Cognome, Email, Stipendio
    FROM Impiegati
    WHERE Ruolo = 'Capo' AND Sede_lavoro = negozio;
END $$

DELIMITER ;


CALL CapoCommesso(2002);

#### Procedura ClienteVittoriaPremio che,dato un cliente, ricerca le partecipazioni ai tornei ####
#### e nel caso abbia vinto, cosa e in che torneo. ####

DELIMITER $$

CREATE PROCEDURE ClienteVittoriaPremio(IN cliente_cod_fiscale VARCHAR(16))
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM Partecipazioni P
        WHERE P.Cod_fiscale = cliente_cod_fiscale AND P.Vittoria = TRUE
    ) THEN
      
        SELECT 
            T.Nome AS Torneo, 
            T.Premio AS Premio
        FROM 
            Partecipazioni P
        JOIN 
            Tornei T 
        ON 
            P.Id_evento = T.Id_evento
        WHERE 
            P.Cod_fiscale = cliente_cod_fiscale
            AND P.Vittoria = TRUE;
    ELSE
      
        SELECT 'Il cliente non ha vinto alcun torneo.' AS Messaggio;
    END IF;
END $$

DELIMITER ;

CALL ClienteVittoriaPremio('RSSMRA85M01H501Z');

#### Procedura che fornito un ordine restituisce il contenuto e la quantità del prodotto

DELIMITER $$

CREATE PROCEDURE DettagliOrdine(IN ordineID INT)
BEGIN
    SELECT 
        P.Nome_prodotto AS Prodotto,
        S.Quantità AS Quantità
    FROM 
        Spedizioni S
    INNER JOIN 
        Prodotti P ON S.Id_prodotto = P.Id_prodotto
    WHERE 
        S.Id_ordine = ordineID;
END $$

DELIMITER ;

CALL DettagliOrdine(1);


#### Procedura che aggiunge un nuovo negozio ####

DELIMITER $$

CREATE PROCEDURE AddNegozio (
    IN p_iva INT,
    IN via VARCHAR(20),
    IN città VARCHAR(20),
    IN cap VARCHAR(20),
    IN provincia CHAR(2),
    IN telefono VARCHAR(13)
)
BEGIN
  
        INSERT INTO Negozi (P_IVA, Via, Città, CAP, Provincia, Telefono)
        VALUES (p_iva, via, città, cap, provincia, telefono);
        
END $$
DELIMITER ;

CALL AddNegozio(889754568,'Via Milano','Roma','00100','RM','0623456789');

SELECT *
FROM Negozi;

#### Procedura che aggiunge un nuovo commesso alla lista degl'impiegati ####

DELIMITER $$

CREATE PROCEDURE AddImpiegato (
    IN p_n_dipendenti INT,    
    IN p_ruolo CHAR(15),        
    IN p_nome CHAR(20),         
    IN p_cognome CHAR(20),      
    IN p_email VARCHAR(50),     
    IN p_stipendio INT,        
    IN p_sede_lavoro INT,     
    IN p_data_inizio DATE       
)
BEGIN
   
    INSERT INTO Impiegati (N_dipendenti, Ruolo, Nome, Cognome, Email, Stipendio, Sede_lavoro, Data_inizio_contratto)
    VALUES (p_n_dipendenti, p_ruolo, p_nome, p_cognome, p_email, p_stipendio,  p_sede_lavoro, p_data_inizio);
END $$

DELIMITER ;
 CALL AddImpiegato(1301, 'Commesso', 'Luigi', 'Verdi', 'luigi.verdi@example.com', 18000, 123456789, '2024-03-01');

SELECT *
FROM Impiegati;

DELIMITER $$

#### Procedura che va a modificare lo sconto di una data categoria di tessera ####

CREATE PROCEDURE ModificaScontoCategoria(
    IN tipoCategoria CHAR(6),
    IN nuovoSconto INT
)
BEGIN
    
    UPDATE Categorie
    SET Sconto = nuovoSconto
    WHERE Tipo = tipoCategoria;
    
END $$

DELIMITER ;

CALL ModificaScontoCategoria("Gold" , 20);

SELECT *
FROM Categorie;

-- -- -- -- -- -- -- -- --
--        VISTE         --
-- -- -- -- -- -- -- -- --

#### Vista che consente come visualizzare i prodotti pokemon ####

CREATE VIEW VistaProdottiPokemon AS
SELECT *
FROM Prodotti
WHERE Brand = 'pokemon';

SELECT * FROM VistaProdottiPokemon;

#### Trovare i prodotti Pokémon con un prezzo maggiore di 10, ordinati per prezzo decrescente (utilizzando la vista) ####

SELECT *
FROM VistaProdottiPokemon
WHERE Prezzo > 10
ORDER BY Prezzo DESC;

#### Vista che consente di visualizzare i commessi solo della sede di Torino ####

CREATE VIEW ImpiegatiTorino AS
SELECT N_dipendenti, Nome , Cognome
FROM Impiegati I 
WHERE I.Ruolo='Commesso' AND I.Sede_lavoro= 0987654321
WITH LOCAL CHECK OPTION;

SELECT * 
FROM ImpiegatiTorino;

#### Vista che consente di visualizzare la data degli ordini della sede di Torino (usando la vista precedentemente creata) ####

CREATE VIEW Ordini_Torino AS
SELECT O.Data_ordine
FROM Ordini O
JOIN Negozi N ON O.Partita_IVA = N.P_IVA
WHERE N.Città = 'Torino';
    
SELECT * 
FROM Ordini_Torino;
 
-- -- -- -- -- -- -- -- -- 
--       TRIGGER        --
-- -- -- -- -- -- -- -- --

#### Trigger che dopo aver inserito un ordine va ad aggiungere 100 punti alla tessera ####
#### del cliente e la aggiorna al grado superiore nel caso questa abbia raggiunto ####
#### 1100 o più punti. Dopodiche se quets'ultima è stata aggiornata reimposta i punti a 0 ####

DELIMITER $$

CREATE TRIGGER AggiornaPuntiDopoOrdine
AFTER INSERT ON Ordini
FOR EACH ROW
BEGIN
    
    UPDATE Tessere
    SET Punti = Punti + 100
    WHERE Id_Tessera = (SELECT Num_Tessera FROM Clienti WHERE Cod_Fiscale = NEW.Codice_Fiscale);

   
    IF (SELECT Punti FROM Tessere WHERE Id_Tessera = (SELECT Num_Tessera FROM Clienti WHERE Cod_Fiscale = NEW.Codice_Fiscale)) >= 1100 THEN
        UPDATE Tessere
        SET Tipo_Tessera = CASE
            WHEN Tipo_Tessera = 'Bronze' THEN 'Silver'
            WHEN Tipo_Tessera = 'Silver' THEN 'Gold'
            ELSE Tipo_Tessera
        END,
        Punti = 0
        WHERE Id_Tessera = (SELECT Num_Tessera FROM Clienti WHERE Cod_Fiscale = NEW.Codice_Fiscale);
    END IF;
END$$

INSERT INTO Ordini (Data_ordine, Importo, Codice_Fiscale)
VALUES ('2024-11-20', 500, 'RSSMRA85M01H501Z');

SELECT T.Id_Tessera, T.Punti, T.Tipo_Tessera
FROM Tessere T
JOIN Clienti C ON T.Id_Tessera = C.Num_Tessera
WHERE C.Cod_Fiscale = 'RSSMRA85M01H501Z';

DELIMITER $$

#### Trigger che dato un nuovo ordine verifica la dispoibilità del prodotto. Nel caso #### 
#### sia disponibile detrae la quantità acquistata dalla disponibilità altrimenti ####
#### restituisce un messaggio di avviso 'Disponibilità del prodotto insufficiente' ####

CREATE TRIGGER VerificaDisponibilitàEUpdate
BEFORE INSERT ON Spedizioni
FOR EACH ROW
BEGIN
    
    DECLARE disponibilita INT;

    
    SELECT Disponibilità_prodotto INTO disponibilita
    FROM Prodotti
    WHERE Id_prodotto = NEW.Id_prodotto;

    
    IF disponibilita < NEW.Quantità THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Disponibilità del prodotto insufficiente';
    ELSE
        
        UPDATE Prodotti
        SET Disponibilità_prodotto = Disponibilità_prodotto - NEW.Quantità
        WHERE Id_prodotto = NEW.Id_prodotto;
    END IF;
END $$

DELIMITER ;

INSERT INTO Ordini (Data_ordine, Importo, Codice_Fiscale,Partita_IVA)
VALUES ('2024-11-26', 100, 'RSSMRA85M01H501Z',987654321); 

INSERT INTO Spedizioni (Quantità,Id_Ordine, Id_prodotto)
VALUES (10, 11, 'OPD-123A'); 

SELECT Id_prodotto, Nome_prodotto, Disponibilità_prodotto
FROM Prodotti
WHERE Id_prodotto = 'OPD-123A';



DELIMITER $$

CREATE TRIGGER applica_sconto_ordine
BEFORE INSERT ON Ordini
FOR EACH ROW
BEGIN
    DECLARE tipo_tessera CHAR(6);
    DECLARE sconto INT;
    DECLARE nuovo_importo INT;

    -- Ottieni il tipo di tessera del cliente
    SELECT T.Tipo_Tessera
    INTO tipo_tessera
    FROM Tessere T
    JOIN Clienti C ON T.Id_Tessera = C.Num_Tessera
    WHERE C.Cod_Fiscale = NEW.Codice_Fiscale;

    -- Se il cliente ha una tessera, ottieni lo sconto dalla tabella Categorie
    IF tipo_tessera IS NOT NULL THEN
        SELECT C.Sconto
        INTO sconto
        FROM Categorie C
        WHERE C.Tipo = tipo_tessera;

        -- Calcola e applica direttamente il nuovo importo
        SET NEW.Importo = NEW.Importo - (NEW.Importo * sconto / 100);
    END IF;
END $$

DELIMITER ;

INSERT INTO Ordini (Data_ordine, Importo, Codice_Fiscale,Partita_IVA) 
VALUES ('2024-12-05', 2000, "VRDLGU75R13H223J", 123456789);

SELECT *
FROM Ordini 
WHERE Id_ordine = LAST_INSERT_ID();

