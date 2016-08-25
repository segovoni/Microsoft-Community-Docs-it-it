#### di [Roberto Freato](https://mvp.support.microsoft.com/profile=9F9B3C0A-2016-4034-ACD6-9CEDEE74FAF3) – Microsoft MVP

1.  ![](./img//media/image1.png){width="0.5938331146106737in"
    height="0.9376312335958005in"}

*Luglio, 2012*

In questo articolo verranno discussi i seguenti argomenti:

1.  Confronto tra PaaS e IaaS

    Benefici e svantaggi del PaaS di Azure

    Benefici e svantaggi dello IaaS di Azure

    1.  

Sommario
--------

1.  [Virtualizzazione e IaaS](#_Virtualizzazione_e_IaaS)

    [Il PaaS](#_Il_PaaS)

    [PaaS vs. IaaS](#_PaaS_vs._IaaS)

    [Vantaggi dello Iaas sul PaaS](#_Vantaggi_dello_Iaas)

    [Svantaggi dello Iaas sul PaaS](#_Svantaggi_dello_Iaas)

    [Il caso Azure](#_Il_caso_Azure)

    1.  

In questo articolo parleremo delle differenze tra PaaS e IaaS, di come
distinguere le due offerte di servizio Cloud in generale, declinandone
una interpretazione attraverso gli strumenti messi a disposizione dal
Windows Azure Platform.

<span id="_Virtualizzazione_e_IaaS" class="anchor"><span id="_Toc329426758" class="anchor"></span></span>Virtualizzazione e IaaS
--------------------------------------------------------------------------------------------------------------------------------

Molti considerano il Cloud Computing e la virtualizzazione come due temi
inscindibili (e questa è una delle motivazioni che ci consentono di
distinguere il Cloud Computing dal Grid). È comunque alla
virtualizzazione che si deve la visione dinamica delle applicazioni
aziendali che ha portato poi ai concetti che trattiamo oggi.

Il concetto di virtualizzazione risale al 1967 con il mainframe e il
partizionamento della macchina per avere, all’interno di un unico
sistema, un numero ingente di applicazioni. Inoltre con la constatazione
che l’utilizzo effettivo dei server è tra il 15% e il 20% delle loro
capacità, si è deciso di consolidare in un unico server un gran numero
di server in modo da averne meno e sfruttarli al massimo. Paul Maritz,
già Senior Executive in Microsoft e attualmente CEO di VMWare, azienda
leader nel settore della virtualizzazione, affermava nel 2009 a tal
proposito:

«Il futuro della virtualizzazione è nel Cloud Computing. E, viceversa,
non ci potrà essere un vero decollo del Cloud Computing senza
virtualizzazione perché altrimenti le applicazioni già esistenti
andrebbero re ingegnerizzate, come accade oggi per molti fornitori di
Cloud. Il primo passo della nostra visione sarà la trasformazione del
data center aziendale in un servizio di Cloud Computing per realizzare
ciò che potremmo chiamare data center-as-a-service»[^1].

Lo IaaS, precedentemente chiamato Hardware as a Service, fornisce
potenza di elaborazione, storage e infrastruttura di rete (attraverso
firewall e load balancing). È rivolta a tutti quei clienti che hanno
bisogno di un ambiente per la propria applicazione fornendo servizi on
demand, scalabili e flessibili. I fornitori di IaaS fanno un forte uso
di tecnologie di virtualizzazione per la potenza di elaborazione. Benchè
anche Azure abbia ora la propria offerta di IaaS, per anni il principale
vendor del settore è sempre stato Amazon. Il costo del servizio è
calcolato in funzione alle ore di utilizzo, al trasferimento dei dati
in/out per GB, alle richieste di I/O, al trasferimento dei dati in/out
per GB di storage e altro ancora. Questo tipo di Cloud può apparire
analogo alle offerte “legacy” di server dedicati ma con una
caratteristica imprescindibile: le risorse sono utilizzate su richiesta
al momento in cui un cliente ne ha bisogno, non vengono assegnate a
prescindere dal loro utilizzo effettivo.

<span id="_Il_PaaS" class="anchor"><span id="_Toc329426759" class="anchor"></span></span>Il PaaS
------------------------------------------------------------------------------------------------

Il PaaS è un’offerta di servizio propria dell’era Cloud. Sebbene già
prima di parlare di Cloud ci fossero vendor che di fatto effettuavano
servizi alla pari del PaaS, dobbiamo la sua formalizzazione agli ultimi
anni di servizi offerti dai maggiori vendor del mercato Cloud Computing:
Microsoft, SalesForce, Google.

Infatti, nonostante negli ultimi anni più o meno tutti, con più o meno
consapevolezza, abbiano trattato l’argomento, è stata solamente la
spinta di prodotti come Azure che hanno favorito l’adozione nel
linguaggio comune del PaaS: da on confondersi con gli innumerevoli
‘X’-aaS che, a seguire, sono sorti come funghi nei salotti di
fantomatici esperti del settore[^2].

Il PaaS dà all’utente qualcosa di estremamente nuovo: la possibilità di
astrarre, oltre la parte hardware delle risorse offerte (così come lo
IaaS) anche la parte di sistema operativo, di software e di runtime
(leggesi: frameworks, librerie, web server) che in alternativa e in
qualsiasi altra circostanza, sarebbero ownership del cliente, ovvero del
suo staff IT. Il PaaS quindi permette il “deploy” delle applicazioni,
astraendo del tutto il luogo, la configurazione e la topologia fisica
delle risorse su cui lo si sta facendo.

<span id="_PaaS_vs._IaaS" class="anchor"><span id="_Toc329426760" class="anchor"></span></span>PaaS vs. IaaS
------------------------------------------------------------------------------------------------------------

Inizio con una massima personale che ben riassume il mio punto di vista
rispetto ai due paradigmi:

“a ‘cadere’ sullo IaaS, si fa sempre in tempo”

Lo IaaS oggi è per me e per molti, un ripiego dove si voglia cadere nel
caso non si riesca proprio ad adottare un PaaS sul mercato. A ben
pensarci, lo IaaS, tolto il suggestivo modello di billing (suggestivo e
talvolta complesso) è di fatto un’offerta di server, di macchine
(virtuali), di risorse fisiche che nulla “di nuovo” hanno rispetto
all’ancien regime. Rimane sempre tutta la competenza relativa alla
governance IT, inalienabile dal contesto organizzativo, con chiare
ripercussioni sui costi.

Nel PaaS la competenza IT necessaria viene ridotta al minimo, e il
software deve essere scritto “bene”, altrimenti sul PaaS, semplicemente,
non gira. La convinzione infatti che il PaaS sia limitato (o limitante)
è la versione bicchiere-mezzo-vuoto della considerazione che lo IaaS sia
troppo elastico e flessibile. E dove spesso la flessibilità viene
invocata solo al fine di arrivare più velocemente ad una deadline,
allentando qualche vincolo di sistema con la promessa (mai mantenuta)
che “a cose fatte”, tutto tornerà a posto, si capisce subito che è
solamente una visione pretestuosa e fuorviante. Per evidenziare meglio
questa mia non velata opinione, a seguire un confronto il più possibile
oggettivo.

<span id="_Vantaggi_dello_Iaas" class="anchor"><span id="_Toc329426761" class="anchor"></span></span>Vantaggi dello Iaas sul PaaS
---------------------------------------------------------------------------------------------------------------------------------

1.  Lo IaaS è configurabile

2.  Posso installare, configurare e rimuovere software e qualsivoglia
    applicazione

3.  Posso arrivarci in Remote Desktop con la certezza che quello che
    farò oggi, lo troverò domani (nota: nello IaaS, di solito lo stato
    delle modifiche al sistema operativo è persistente)

4.  

Finiti! I vantaggi dello IaaS sul PaaS si traducono nella possibilità di
avere il controllo sulla macchina.

<span id="_Svantaggi_dello_Iaas" class="anchor"><span id="_Toc329426762" class="anchor"></span></span>Svantaggi dello Iaas sul PaaS
-----------------------------------------------------------------------------------------------------------------------------------

1.  La IaaS è configurabile

2.  Posso permettermi di allentare i permessi su una folder perchè non
    riesco a configurare IIS su una applicazione.

3.  Posso permettermi di installare in remote desktop un tool non
    firmato per la più disparate motivazioni.

4.  Mi posso permettere, proporzionalmente alla mia ignoranza in
    materia, di “spaccare” il server o almeno di non configurarlo al
    meglio per il servizio da offrire (si parla al 90% di servizi web)

5.  Lo IaaS non scala da solo

6.  Se ho bisogno di una nuova macchina, la devo creare e riconfigurare
    da capo (o nei sistemi più evoluti, clonare da una esistente). Poi
    devo implementare uno stack di rete (bilanciatore, schede,
    firewall, etc) sempre supponendo che le applicazioni ivi contenute
    non debbano avere conoscenza della topologia di sistema (altrimenti,
    sarebbero necessarie anche modifiche alle applicazioni e opportuni
    strumenti per fare “parlare” le istanze multiple allocate
    sullo IaaS)

7.  

Parlando con un collega che lavora in Microsoft, è emerso che il cliente
medio ha “paura” del PaaS proprio per la perdita di controllo percepita
che ne deriva. Tuttavia, questo “controllo” è spesso non privo di errori
e le configurazioni stesse, non sono (quasi) mai ottimali per la
sicurezza e/o le performance.

Uno specchietto di semplici domande che potremmo farci, nel caso
avessimo reticenza a spostare le nostre applicazioni da un datacenter in
casa su un PaaS, sono relative alle macro-aree di attenzione di ogni
datancenter: ridondanza, sicurezza, performance.

### Ridondanza

1.  Nel nostro datancenter quante linee di corrente ci sono?

2.  Quanti condizionatori ci sono?

3.  C’è un sistema di monitoring della temperatura con allarme?

4.  C’è del personale *dedicato* pronto a scattare sulla sedia se
    l’allarme suona?

5.  Quante linee internet ci sono?

6.  L’hardware è ridondato (firewall, cavi, switch, schede di rete, hard
    disk, etc)?

7.  

### Sicurezza

1.  Il palazzo è controllato (telecamere, guardiani, controllo degli
    accessi all’edificio e ai datacenter)?

2.  C’è un sistema antiincendio?

3.  I dati e le informazioni che transitano all’interno del datacenter,
    sono crittografate?

4.  Quante persone hanno accesso fisico alle macchine?

5.  

### Performance

1.  Posso triplicare o decuplicare le risorse da un momento al
    successivo?

2.  La mie linee internet hanno banda dedicata?

3.  Il mio staff IT ha configurato i sistemi operativi, i framework e i
    tools al meglio?

4.  

<span id="_Il_caso_Azure" class="anchor"><span id="_Toc329426766" class="anchor"></span></span>Il caso Azure
------------------------------------------------------------------------------------------------------------

Non posso che approvare la scelta di Microsoft di lanciare una offerta
di IaaS a completamento dell’offerta principe con cui Azure è nato.
Tuttavia lo IaaS è una scelta di compromesso, quando non si può proprio,
in nessun caso e modo, far “entrare” nei vincoli del PaaS, la nostra
applicazione.

Vincoli che generano quasi sempre un circolo virtuoso di modifiche al
nostro software: Azure infatti, permette l’esecuzione di applicazioni
fortemente orientate alla generalizzazione e all’ottica di esecuzione in
web farm. Le nostre applicazioni siffatte, saranno sicuramente
compatibili con qualsiasi altra web farm e, per poter perseguire questa
compatibilità, dovranno essere scritte “meglio”, senza degradi
introdotti da worst-practice dovute ai più disparati motivi (tempi,
costi, deadlines, etc).

Concludendo, nel “caso azure” il PaaS è l’offerta cloud per eccellenza,
con un modello di esecuzione molto vantaggioso e con tecnologie
sicuramente configurate e mixate al meglio (ricordiamoci che Microsoft
crea le tecnologie che ha assemblato in Azure): in questo scenario, lo
IaaS è utile per colmare le necessità residue di chi ha soluzioni
inevitabilmente complesse.

#### di Roberto Freato ([blog](http://dotnetlombardia.org/blogs/rob/default.aspx)) - Microsoft MVP

1.  [*Altri articoli di Roberto Freato nella
    Libreria*](http://sxp.microsoft.com/feeds/3.0/msdntn/TA_MSDN_ITA?contenttype=Article&author=Roberto%20Freato)
    ![](./img//media/image2.png){width="0.1771084864391951in"
    height="0.1771084864391951in"}

[^1]: Barelli, L. (2009, Febbraio 27). Virtualizzazione e cloud, coppia
    perfetta. Retrieved from Lineaedp:
    http://www.lineaedp.it/01NET/HP/0,1254,1\_ART\_96633,00.html?lw=10001

[^2]: Riconosco infatti solo tre “tipi” di servizi cloud esistenti oggi:
    il PaaS, lo IaaS e il SaaS. Il resto, sono “voli pindarici” dal
    vacuo significato e dalle mancate fondamenta nella letteratura del
    settore.
