---
title: Pricing: capire i costi di Windows Azure
description: Pricing: capire i costi di Windows Azure
author: MSCommunityPubService
ms.date: 08/01/2016
ms.topic: how-to-article
ms.service: cloud
ms.custom: CommunityDocs
---
# Pricing: capire i costi di Windows Azure

#### Di [Roberto Freato](https://mvp.microsoft.com/it-it/PublicProfile/4028383) – Microsoft MVP

![](./img/MVPLogo.png)

*Settembre, 2012*

In questo articolo verranno discussi i seguenti argomenti:

- Servizi dell’ecosistema Azure
- Modelli di pricing
- Stima dei costi di una infrastruttura

Sommario
--------

- I modelli di fatturazione nel
    cloud
    -    Scaricare il costo sul cliente
    -    Assorbire il rischio sul variabile
- I servizi a pagamento di Azure
    - Web Sites
    - Macchine Virtuali IaaS
    - Ruoli degli Hosted Service (PaaS)
    - Storage
    - Transazioni
    - SQL Database
    - Banda
    - Service Bus Messages
    - Service Bus Relay
    - Active Directory
    - Content Delivery Network
- Conclusioni

In questo articolo analizzeremo l’articolazione dei servizi di Azure e
le dinamiche di fatturazione. Il presupposto di tutto l’articolo è di
avere ben compreso cosa si intenda per Cloud, come lo si riconosca e
come si posizioni Azure nello scenario dei player di Cloud mondiali.

## I modelli di fatturazione nel cloud

Diffidate da chi vi parla di canoni e di cloud nello stesso discorso;
diffidate anche da chi vi parla di costi di attivazione/dismissione
legati all’accensione di un rapporto; diate invece una possibilità a chi
vi spiegherà che la sua offerta cloud prevede un pagamento delle sole
risorse consumate, ponendovi una successiva importante domanda: “come si
stabilisce tale consumo?”.

I modelli di fatturazione del cloud, per essere tali, devono essere a
consumo, ovvero rispecchiare la logica della fruizione on-demand di una
risorsa. Per cui, bene se:

“Prendo un film a noleggio, pago il noleggio 4 euro”

Ma ancora meglio se:

“Prendo un film a noleggio per 2 ore, pago 2 ore di noleggio.” Oppure
“Lo riporto dopo 10 minuti perchè l’inizio non mi è piaciuto, pago 10
minuti di noleggio”

Sebbene l’esempio del film a noleggio per 10 minuti potrebbe essere
infelice per i noleggiatori (tipica pratica di chi copia e riporta),
l’esempio calza a pennello per le vere soluzioni on-demand. Cercate
quindi un modello analogo nei prodotti cloud poichè, se non lo trovate,
non è cloud.

Una conversazione che spesso conduco con molti dei miei interlocutori è
sintetizzata sotto:

- Ospite: “ma io come faccio a sapere quanto spenderò a fine mese?”
- Io: “dipende, quante risorse hai bisogno?”
- Ospite: “beh, non lo so, quante ne sono necessarie”

Dopo alcune delucidazioni sulle tecniche di stima che potremmo usare su
un qualsiasi sistema anche non cloud, l’ospite riesce a ridurre la spesa
di calcolo ad una moltiplicazione del numero di istanze necessarie per
il loro costo. Quello che ancora è oscuro sono tutti gli altri costi:

- Ospite: “ok, ma per le transazioni? Come faccia a sapere prima
    quante ne farò?”
- Io: “non lo puoi sapere e non lo puoi controllare, ma se ne farai
    tante o l’applicazione è scritta male oppure è se scritta bene
    probabilmente sarà un bene e si ripercuoterà sul business
    proporzionalmente”
- Ospite: “e come faccio a dire al mio capo che la bolletta potrebbe
    essere qualsiasi?”
- Io: “generalmente si prova il servizio con dei numeri noti, si
    verifica l’utilizzo a consuntivo e si proiettano i dati sui numeri
    reali, considerando un errore”

A questo punto, se ancora ci fosse scetticismo, ricondurrei il problema
all’esempio della bolletta elettrica (che, per intenderci, aderisce al
modello delle *public utilities* esattamente come vorrebbe aderire il
cloud computing). L’esempio è il seguente:

“Se devo aprire una nuova sede, che potenzialmente avrà necessità di
tanta energia elettrica, come faccio a stimare? Potrò sentire un esperto
che mi dirà, secondo la sua esperienza, quale potrebbe essere il
consumo; oppure potrò, se possibile, verificare io stesso su una
porzione ridotta della mia nuova sede quanto sia l’impatto di un’ora di
lavoro e poi fare una stima su base mensile. E se ancora non bastasse
amplierei il campione a più osservazioni per avere un numero stimato il
più realistico possibile. Per quanto bravo possa essere tuttavia,
l’errore rimarrà sempre e, a ben pensarci, nessuno sa con precisione
quanto spenderà di corrente elettrica a fine mese, al limite lo potrà
supporre dall’esperienza pregressa.”

Non ci scandalizziamo quindi se persone dell’ambiente non sappiano dare
una risposta a questa domanda, anzi preoccupiamoci se ne dessero una:
probabilmente non sarebbe cloud. Il problema rimane quindi adottare una
strategia ottimale per la stima dei costi, considerati i vari vincoli
ambientali.

## Scaricare il costo sul cliente

Il cloud si paga a consumo, ma una azienda, nel mercato libero, può
rivenderlo come servizio a canone fisso: partiamo da un esempio.

L’azienda Contoso installa sul PaaS di Azure una applicazione dedicata
ad un cliente, garantendogli che sarà sempre disponibile e che
supporterà picchi fino a 1000 utenti contemporanei con una media
comunque non superiore ai 200 per l’80% del tempo. Tecnicamente
parlando, Contoso dovrà predisporre una architettura tale che, per
esempio, sia dimensionata per i 200 utenti e che possa fare autoscaling
per supportarne 1000.

Supponendo che per supportare 200 utenti servano 2 istanze Small da
1000€/anno l’una e che nei momenti di picco queste istanze debbano
diventare 5, Contoso potrebbe spendere fino a 2600€/anno (2000 per le
due istanze sempre accese e 600 per le successive 3 accese massimo per
il 20% del tempo totale di un anno).

A conti fatti, Contoso potrebbe chiedere un canone fisso di 3000€/anno,
scaricando il rischio sul cliente ed effettuando margine, oppure
potrebbe chiederne anche solo 2000€/anno, tenendo in esecuzione istanze
meno costose supponendo che la media reale degli utenti connessi non
superi, per esempio, il centinaio.

## Assorbire il rischio sul variabile

In questa seconda ipotesi, il rischio è scaricato su Contoso che, però,
in caso i consumi siano limitati, avrà una offerta concorrenziale e allo
stesso tempo offrirà al cliente quello che gli serve per supportare il
proprio carico.

Un altro modello è quello di mascherare solo in parte il modello di
billing all’origine, imponendo al cliente un pagamento di un canone
fisso basso, in aggiunta ad un consumo variabile entro certi limiti.
Esistono altri modelli con cui Contoso potrebbe offrire i proprio
servizi ai clienti sfruttando il cloud all’origine, ma in tutti il
preventivo di spesa non può che essere di natura incerta: starà a
Contoso essere brava nella stima e volgere a suo favore il conto.

## I servizi a pagamento di Azure

Ora passiamo in rassegna tutti e i soli servizi a pagamento di Azure:
tutto ciò che è gratuito, in beta gratuita o non ancora con prezzo
definitivo, non viene preso in considerazione.

## Web Sites ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#web-sites))

Windows Azure Web Sites offre l’hosting scalabile di siti e applicazioni
web. Fino a 10 siti è tutto gratuito ed è in configurazione condivisa,
ovvero le applicazioni risiedono fisicamente su un server con altri N
WebSites (con N anche molto grande).

Se vogliamo scalare in alto per avere più performance o avere più di 10
siti, passeremo alla modalità riservata, in cui allocheremo una quantità
arbitraria di macchine virtuali ai nostri sites. Il prezzo quindi dei
Web Sites può essere ricondotto al prezzo delle macchine virtuali IaaS.

## Macchine Virtuali IaaS ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#virtual-machines))

Si paga ad unità di allocazione (la base è l’ora) e per diverse taglie
(XS,S,M,L,XL). La S (Small) è l’unità standard, quelle più grandi sono
multipli esatti mentre la XS è in rapporto 6:1 con la Small (avere una
Small accesa un’ora equivale ad avere 6 Extra-Small per un’ora, una
Medium per mezz’ora o una Large per un quarto d’ora).

## Ruoli degli Hosted Service (PaaS) ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#cloud-services))

Il concetto di base è quello delle macchine virtuali allocate, dove però
il servizio aggiuntivo è quello della gestione del PaaS e della
governance. Il modello è uguale a quello delle macchine virtuali IaaS ma
il prezzo orario è superiore.

## Storage ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#data-management))

Per storage intendiamo Blobs, Tables, Queues e se consideriamo che i
dischi delle nostre VM risiedono sui Blob, allora anche loro concorrono
alle stesse soglie. Si paga al GB occupato per periodo (la base è il
mese) e si può decidere se avere uno storage non geograficamente
ridondante (in tal caso la base mensile è leggermente inferiore).

## Transazioni ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#data-management))

Lo storage comporta una occupazione di spazio ma anche un continuo
accesso ai dati salvati. Per ogni transazione avvenuta (ad eccezione di
quelle sui dischi degli IaaS) si paga una quota molto bassa. Per
semplificare l’unità di consumo, si prende come base di riferimento il
milione di transazioni.

## SQL Database ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#data-management))

Nel SQL Database le unità di consumo sono i multipli di 1GB, con un
prezzo descrescente all’aumento del consumo. Questo significa che il
primo GB avrà un costo unitario mentre i successivi costeranno sempre di
meno, al crescere dello spazio occupato. Per incentivarne l’utilizzo
anche in piccole soluzioni, un database fino a 100MB viene tariffato la
metà della sua normale occupazione unitaria di un GB.

## Banda ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#data-transfers))

Ogni servizio di Azure sopra menzionato finchè rimane isolato fattura
solo i consumi esposti. Se però viene acceduto dall’esterno, allora
verrà consumata anche della banda dal datacenter al nodo destinazione.
Tutta la banda “fuori” dal datacenter è tariffata al GB. La banda
all’interno dello stesso datacenter è gratuita.

## Service Bus Messages ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#messaging))

Il servizio di messagistica (code, topics) si basa sull’inoltro di
messaggi. Ogni messaggio ha un costo molto piccolo per cui, come nel
caso delle transazioni, si prende in considerazione la base di un
milione.

## Service Bus Relay ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#messaging))

Il servizio di relay di servizi WCF fa da ponte tra Azure e il sistema
on-premise. Siccome il ponte deve essere per natura del servizio, sempre
connesso, la tariffazione è su base oraria per ogni ora di relay
“attivo”.

## Active Directory ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#identity))

Prima noto come Access Control Service, il servizio autentica utenti e
li inoltra alle applicazioni. Ne consegue che il modello di fatturazione
è basato sul numero di queste autenticazioni e, in particolare, con base
un milione.

## Content Delivery Network ([link](http://www.windowsazure.com/en-us/pricing/details/?currency-locale=it-it#caching))

Trattandosi di delivery di contenuti si potrà parlare di banda consumata
e quindi di una tariffazione a consumo di GB (esattamente come per la
banda) ed inoltre una tariffazione sulle transazioni (richieste
effettuate) su base un milione. Per non confondere le idee, la
fatturazione della CDN è identica allo storage, cambia solo la tariffa
al GB per la banda consumata.

## Conclusioni

Una volta chiari questi concetti di base, combinare i vari servizi può
essere un lavoro arduo. Tuttavia, in un modello cloud, l’enfasi è
sull’on-demand, per cui non scandalizziamoci se ogni cosa che comporti
un “consumo” sia giustamente tariffata.

#### di Roberto Freato ([blog](http://dotnetlombardia.org/blogs/rob/default.aspx)) - Microsoft MVP



