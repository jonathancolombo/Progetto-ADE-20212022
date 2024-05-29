#README
Progetto Assembly RISC-V per il Corso di Architetture degli Elaboratori
A.A. 2021/2022 – Messaggi in Codice
Descrizione del Progetto

Questo progetto riguarda la progettazione e la scrittura di un codice assembly RISC-V che simuli alcune funzioni di crittografia e decifratura di un messaggio di testo, interpretato come sequenza di caratteri ASCII. In particolare, il programma permette di cifrare e decifrare un messaggio di testo fornito dall’utente utilizzando vari algoritmi di crittografia.
Algoritmi Implementati

    Cifrario a Sostituzione:
        Un cifrario a sostituzione monoalfabetica che sostituisce ogni lettera del testo in chiaro con una lettera spostata di un certo numero di posizioni nell’alfabeto.
        Variabile di configurazione: sostK, che indica lo shift alfabetico.

    Cifrario a Blocchi:
        La parola viene partizionata in blocchi, e ogni blocco viene cifrato sommando la codifica ASCII di un carattere della chiave alla codifica ASCII del carattere del blocco.
        Variabile di configurazione: blocKey, la chiave utilizzata per la cifratura a blocchi.

    Cifratura Occorrenze:
        Ogni carattere del messaggio viene cifrato come una sequenza di stringhe che indicano le posizioni delle occorrenze del carattere nel messaggio.

    Dizionario:
        Ogni carattere ASCII viene mappato con un altro simbolo ASCII secondo una certa funzione:
            Lettere minuscole -> Maiuscole in ordine inverso.
            Lettere maiuscole -> Minuscole in ordine inverso.
            Numeri -> 9 - Numero.
            Altri caratteri rimangono invariati.

    Inversione:
        Il cyphertext è rappresentato dalla stringa invertita del plaintext.

Struttura del Progetto

Il progetto è composto da variabili di input e procedure modulari per ciascun algoritmo di cifratura e decifratura, rispettando le convenzioni tra procedura chiamante e chiamata. La modularità del codice e il rispetto delle convenzioni sono fondamentali per ottenere una buona valutazione del progetto.
File del Progetto

    main.s: Contiene il codice assembly principale.
    cifrario_sostituzione.s: Procedura per il Cifrario a Sostituzione.
    cifrario_blocchi.s: Procedura per il Cifrario a Blocchi.
    cifratura_occorrenze.s: Procedura per la Cifratura Occorrenze.
    dizionario.s: Procedura per il Dizionario.
    inversione.s: Procedura per l’Inversione.

Input e Output

    Input:
        myplaintext: Messaggio di testo da cifrare (dimensione massima 200 caratteri).
        mycypher: Stringa che specifica l’ordine delle cifrature da applicare al messaggio.

    Output:
        Il programma produce in output i vari cyphertext ottenuti dopo l’applicazione di ciascun singolo passaggio di cifratura, separati da un newline.
        Applicando le funzioni di decifratura in ordine inverso, si ottiene il plaintext di partenza.

Esempi di Input

    Messaggio di testo: myplaintext = "Ciao Mondo!"
    Ordine delle cifrature: mycypher = "AEC"

Note

    Seguire fedelmente tutte le specifiche dell’esercizio.
    Rendere il codice modulare utilizzando chiamate a procedure.
    Commentare in modo significativo il codice.

Modalità di Consegna

La consegna dovrà consistere di un unico archivio contenente:

    Un file .s contenente il codice assembly.
    Un breve video (max 5 minuti) che spieghi il funzionamento del codice.
    Una relazione in formato PDF con le seguenti sezioni:
        Informazioni sull'autore.
        Descrizione della soluzione adottata.
        Test di corretto funzionamento.

Caricare l'archivio sul sito Moodle del corso seguendo il link fornito.
Autore

    Nome: [Inserire Nome]
    Email: [Inserire Email]
    Matricola: [Inserire Matricola]
    Data di Consegna: [Inserire Data]
