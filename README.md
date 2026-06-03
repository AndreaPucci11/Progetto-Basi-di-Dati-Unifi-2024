# Progetto Basi di Dati e Sistemi Informativi - Catena di Negozi "CIOCIAMON"

Questo repository contiene il codice SQL e la documentazione per la progettazione e l'implementazione del database avanzato destinato alla gestione della catena di negozi di carte collezionabili **"Ciociamon"**. Il sistema è stato interamente sviluppato da me per ottimizzare la gestione dei punti vendita, dei dipendenti, del catalogo prodotti, degli ordini e delle attività della community (tornei e tessere fedeltà).

## 👤 Autore (A.A. 2024/2025)
* **Andrea Pucci** - Matricola: 7119077

---

## 📝 Descrizione del Progetto
Il sistema gestisce l'intera infrastruttura commerciale della catena "Ciociamon":
* **Negozi e Staff:** Tracciamento dei punti vendita tramite Partita IVA e gestione del personale suddiviso nei ruoli di Responsabile (Capo) e Cassiere (Commesso).
* **Catalogo Prodotti:** Organizzazione di carte singole, bustine e display appartenenti a diversi brand (es. Pokémon, One Piece, Digimon).
* **Ordini e Spedizioni:** Monitoraggio delle transazioni dei clienti e dettaglio dei prodotti acquistati.
* **Community ed Eventi:** Organizzazione di tornei con quote di iscrizione e premi, accoppiati a un sistema di fidelizzazione a tessere (Bronze, Silver, Gold) che accumulano punti e applicano sconti automatici.

---

## 📐 Progettazione Logica (Schema Relazionale)
Il database è composto dalle seguenti tabelle:

* `Categorie` (**Tipo**, Sconto)
* `Tessere` (**Id_Tessera**, Punti, *Tipo_Tessera*)
* `Clienti` (**Cod_Fiscale**, Nome, Cognome, Via, Città, CAP, Provincia, *Num_Tessera*)
* `Ordini` (**Id_ordine**, Data_ordine, Importo, *Codice_Fiscale*, *Partita_IVA*)
* `Prodotti` (**Id_prodotto**, Nome_prodotto, Prezzo, Tipologia_prodotto, Brand, Materiale, Espansione, Rarità, Disponibilità_prodotto)
* `Spedizioni` (**\*Id_ordine**, **\*Id_prodotto**, Quantità)
* `Impiegati` (**N_dipendenti**, Ruolo, Nome, Cognome, Email, Stipendio, Data_inizio_contratto, *Sede_lavoro*)
* `Negozi` (**P_IVA**, Via, Città, CAP, Provincia, Telefono)
* `Tornei` (**Id_evento**, Nome, Data_torneo, Ora, Quota_iscrizione, Premio, *Luogo*)
* `Partecipazioni` (**\*Id_evento**, **\*Cod_fiscale**, Vittoria)

*(Nota: in **grassetto** le chiavi primarie, in \*grassetto\* le chiavi primarie composte, in *corsivo* le chiavi esterne).*

---

## 🚀 Funzionalità Avanzate Implementate

### 1. Stored Procedures
Il database include procedure per automatizzare le operazioni di business comuni:
* `CapoCommesso(commesso_id)`: Dato l'ID di un commesso, restituisce i dettagli del rispettivo capo negozio.
* `ClienteVittoriaPremio(cod_fiscale)`: Verifica le partecipazioni di un cliente ai tornei e ne restituisce le vittorie e i premi corrispondenti.
* `DettagliOrdine(ordine_id)`: Mostra l'elenco dei prodotti e le relative quantità associati a un determinato ordine.
* `AddNegozio(...)` / `AddImpiegato(...)`: Procedure standardizzate per l'inserimento sicuro di nuovi punti vendita e dipendenti.
* `ModificaScontoCategoria(categoria, nuovo_sconto)`: Permette di aggiornare dinamicamente la percentuale di sconto di un livello di tessera.

### 2. Viste (Views)
Forniscono un livello di astrazione utile per le interrogazioni più frequenti:
* `VistaProdottiPokemon`: Filtra automaticamente il catalogo per mostrare solo i prodotti del brand Pokémon.
* `ImpiegatiTorino`: Mostra in modo isolato il personale della sede di Torino.
* `Ordini_Torino`: Consente il monitoraggio specifico delle vendite effettuate nel punto vendita di Torino.

### 3. Trigger automatici
Logica di business integrata direttamente nel DBMS per garantire la consistenza dei dati:
* `AggiornaPuntiDopoOrdine` (AFTER INSERT ON Ordini): Aggiunge automaticamente 100 punti alla tessera del cliente dopo ogni acquisto. Se il cliente raggiunge o supera i 1100 punti, la tessera effettua un upgrade di livello (Bronze → Silver → Gold) e i punti vengono azzerati.
* `VerificaDisponibilitàEUpdate` (BEFORE INSERT ON Spedizioni): Controlla la disponibilità a magazzino prima di elaborare un ordine. Se insufficiente, blocca la transazione sollevando un errore (`SIGNAL SQLSTATE '45000'`); altrimenti, scala la quantità dal database.
* `applica_sconto_ordine` (BEFORE INSERT ON Ordini): Intercetta l'ordine prima dell'inserimento, verifica il livello della tessera del cliente e applica automaticamente la percentuale di sconto all'importo totale.

---

## 🛠️ Come Eseguire il Progetto

### Prerequisiti
* MySQL Server (versione 8.0 o successiva consigliata)
* Un client SQL (es. MySQL Workbench, DBeaver, o la CLI di MySQL)

### Installazione e Configurazione
1. Clona questo repository sul tuo computer:
```bash
   git clone [https://github.com/tuo-username/nome-del-repo.git](https://github.com/tuo-username/nome-del-repo.git)
