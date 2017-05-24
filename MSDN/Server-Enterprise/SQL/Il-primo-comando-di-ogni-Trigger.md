---
title: Il primo comando di ogni Trigger
description: Il primo comando di ogni Trigger
author: segovoni
ms.author: aldod
ms.manager: csiism
ms.date: 08/01/2016
ms.topic: article
ms.service: SQLServer
ms.custom: CommunityDocs
---

# Il primo comando di ogni Trigger

#### Di [Sergio Govoni](https://mvp.microsoft.com/en-us/PublicProfile/4029181?fullName=Sergio%20Govoni) – Microsoft Data Platform MVP

English Blog: <http://sqlblog.com/blogs/sergio_govoni/default.aspx>

UGISS Author: <https://www.ugiss.org/author/sgovoni>

Twitter: [@segovoni](https://twitter.com/segovoni)

![](./img/Il-primo-comando-di-ogni-Trigger/image1.png)


*Agosto, 2013*

Introduzione
============

Un Trigger, in SQL Server, è ottimizzato quando la sua durata è trascurabile rispetto alla durata dello statement che lo ha invocato. I Trigger lavorano sempre in transazione (implicita o esplicita che sia) e i Lock rimarranno al loro posto fino a quando la transazione non verrà confermata (con un COMMIT) o respinta (con un ROLLBACK). Si intuisce facilmente che più lunga sarà la durata di un Trigger, più alta sarà la probabilità che esso blocchi un altro processo.

Ottimizzare un Trigger esistente, che racchiude centinaia di righe di codice, può rivelarsi molto difficile; quindi l'arma migliore è la prevenzione!


Il comando che ogni Trigger dovrebbe avere
==========================================

Potreste considerarlo banale, ma lo troverete interessante, la prima cosa da fare affinché la durata di un Trigger sia breve è stabilire se il Trigger debba intervenire oppure no. Se non ci sono righe coinvolte nel comando che lo ha scatenato, significa **generalmente** che il Trigger in questione non dovrà fare nulla.

L'unica cosa, quindi, che si dovrebbe **sempre** fare all'interno di un Trigger è verificare il valore della variabile di sistema [@@ROWCOUNT](http://technet.microsoft.com/it-it/library/ms187316.aspx) (o il risultato della funzione [ROWCOUNT\_BIG](http://technet.microsoft.com/it-it/library/ms181406.aspx) se stimiamo che il numero di righe trattate sia superiore a 2 miliardi) per controllare se nel comando che ha invocato il Trigger sono state coinvolte righe. Se ciò non è accaduto (*@@ROWCOUNT = 0*) non c'è nulla che il Trigger possa fare se non **restituire il controllo al chiamate** con l'istruzione [RETURN (T-SQL)](http://msdn.microsoft.com/it-it/library/ms174998.aspx).

Il seguente frammento di codice T-SQL dovrebbe quindi comparire all'inizio di ogni Trigger:

```SQL
IF (@@ROWCOUNT = 0)
  RETURN;
```

Ecco un esempio di creazione di un Trigger, per il comando UPDATE, sulla tabella Person.Person del database [AdventureWorks2012](http://msftdbprodsamples.codeplex.com/releases/view/55330):

```SQL
CREATE TRIGGER TR_Person_Person_Upd ON Person.Person FOR UPDATE AS
BEGIN
  IF (@@ROWCOUNT = 0)
    RETURN;

  -- ...
  -- ...
  -- ...
END;
GO
```

La verifica di @@ROWCOUNT permette anche di stabilire se il numero di righe coinvolte è quello che ci si aspetta. In tutti i casi in cui ci si aspetta venga coinvolta solo una riga, dovrà essere eseguito il test:

```SQL
IF (@@ROWCOUNT = 1)
  <azione>
```

Dopo aver superato il test riguardante le righe coinvolte, si potrebbe verificare se le colonne di nostro interesse sono state aggiornate (ovviamente solo nel caso di Trigger per il comando UPDATE), utilizzando l'istruzione:

```SQL
IF UPDATE(<nome_colonna>)
  <azione>
```

Nel caso le colonne di nostro interesse non siano state aggiornate, avremmo un'altra occasione per **restituire il controllo al chiamante**, mantenendo breve la durata del Trigger.

La funzione [UPDATE()](http://technet.microsoft.com/it-it/library/ms187326.aspx) restituisce il valore Booleano True nel caso la colonna sia stata modificata o nel caso di INSERT, ma non permette di sapere, in caso di aggiornamento, se i valori della colonna sono cambiati ovvero se il vecchio valore è diverso dal nuovo. Qualora il Trigger debba eseguire un'azione solo se il vecchio valore, di una colonna, risulti essere diverso dal nuovo, si potranno interrogare le tabelle virtuali *INSERTED* e *DELETED*. Il seguente frammento di codice T-SQL implementa un esempio di Trigger, per il comando UPDATE, sulla tabella *Sales.SalesOrderDetail* del database *AdventureWorks* dove si desidera eseguire un'azione solo quando viene aggiornata la colonna *UnitPrice* e **il vecchio valore è diverso dal nuovo** per almeno una riga.

```SQL
CREATE TRIGGER Sales.TR_SalesOrderDetail_Upd ON Sales.SalesOrderDetail AFTER UPDATE AS
BEGIN
  IF (@@ROWCOUNT = 0)
    RETURN;

  SET NOCOUNT ON;
  IF UPDATE(UnitPrice)
     AND EXISTS (
                 SELECT
                   i.SalesOrderID
                   ,i.SalesOrderDetailID
                 FROM
                   inserted AS i
                 JOIN
                   deleted AS d ON (d.SalesOrderID=i.SalesOrderID) AND (d.SalesOrderDetailID=i.SalesOrderDetailID)
                 WHERE
                   (d.UnitPrice <> i.UnitPrice)
                )
  BEGIN
    -- <azione>
  END;
END;
GO
```

Si osservi l'istruzione *SET NOCOUNT ON* eseguita immediatamente dopo aver verificato il valore della variabile *@@ROWCOUNT*; permette di bloccare l'invio di messaggi al client per ogni istruzione all'interno del Trigger. Nel caso di Trigger contenenti diverse istruzioni e che non restituiscono un'elevata quantità di dati, l'impostazione di *SET NOCOUNT* ad *ON* può determinare un incremento delle prestazioni significativo grazie alla notevole riduzione del traffico di rete.


Trigger attivati dal comando MERGE (T-SQL)
==========================================

Il comando MERGE imposta il valore della variabile di sistema *@@ROWCOUNT* con il numero delle righe "Merged" che può essere diverso dal numero di righe da controllare nel Trigger. In definitiva, quindi, si consiglia di contare i record nella tabella *INSERTED* per i trigger su INSERT o UPDATE, e quelli nella tabella *DELETED* per i trigger UPDATE o DELETE in sostituzione di *@@ROWCOUNT* qualora venga utilizzato il comando MERGE.

```SQL
CREATE TRIGGER Sales.TR_SalesOrderDetail_Upd ON Sales.SalesOrderDetail AFTER UPDATE AS
BEGIN
  -- Contare i record nella tabella Inserted per i trigger su INSERT o UPDATE,
  -- e quelli nella tabella Deleted per i trigger UPDATE o DELETE in sostituzione di @@ROWCOUNT
  
  -- Il comando MERGE imposta @@ROWCOUNT con il numero di righe "merged" che può
  -- essere diverso dal numero di righe da controllare nel trigger

  -- Definizione e impostazione variabili
  DECLARE
    @inserted_rows_affected INT
    ,@deleted_rows_affected INT;

  SET @inserted_rows_affected = (SELECT COUNT(*) FROM inserted);
  --SET @deleted_rows_affected = (SELECT COUNT(*) FROM deleted);

  -- Se non ci sono righe coinvolte nel comando che ha scatenato il trigger
  -- non c'è nulla da fare se non restituire il controllo al chiamante!!
  IF (@inserted_rows_affected = 0)
    RETURN;
  --IF (@deleted_rows_affected = 0)
  --  RETURN;

  SET NOCOUNT ON;

  IF UPDATE(UnitPrice)
     AND EXISTS (
                 SELECT
                   i.SalesOrderID
                   ,i.SalesOrderDetailID
                 FROM
                   inserted AS i
                 JOIN
                   deleted AS d ON (d.SalesOrderID=i.SalesOrderID) AND (d.SalesOrderDetailID=i.SalesOrderDetailID)
                 WHERE
                   (d.UnitPrice <> i.UnitPrice)
                )
  BEGIN
    -- <azione>
  END;
END;
GO
```


Conclusioni
===========

I Trigger sembrano facili da scrivere, ma scrivere Trigger efficienti non è affatto semplice e quando la loro complessità aumenta, talvolta possono presentare effetti collaterali in grado di confondere persino l'autore! L'importante è ricordarsi che: Un Trigger è ottimizzato quando la sua durata è trascurabile rispetto alla durata dello statement che lo ha invocato.

#### Di [Sergio Govoni](https://mvp.microsoft.com/en-us/PublicProfile/4029181?fullName=Sergio%20Govoni) – Microsoft Data Platform MVP

English Blog: <http://sqlblog.com/blogs/sergio_govoni/default.aspx>

UGISS Author: <https://www.ugiss.org/author/sgovoni>

Twitter: [@segovoni](https://twitter.com/segovoni)
