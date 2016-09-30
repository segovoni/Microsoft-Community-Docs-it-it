
# Typescript: organizzare il codice con interfacce, classi e moduli

#### di [Andrea Boschin](http://mvp.microsoft.com/profiles/Andrea.Boschin) – Microsoft MVP

![](./img/MVPLogo.png)


*Aprile, 2013*

Pur se lo [static type
checking](Typescript2.md) è un
elemento importante nell'utilizzo di Typescript, tanto da essere già una
ragione più che valida per la sua adozione, è chiaro che si può fare di
più nella semplificazione del codice Javascript e nella sua
organizzazione. Nel corso degli anni si sono consolidate alcune pratiche
comuni nella stesura di Javascript, per venire incontro alla carenza dei
concetti di base dell'object orientation che sono particolarmente labili
e limitati. Tra essi si possono annoverare alcune naming convention - ad
esempio prependere un underscore ad una variabile, la identifica come
privata - e dei veri e propri pattern quali le *closure*. Tutto ciò in
effetti è più che altro una notazione stilistica che una vera e propria
caratteristica del linguaggio e spesso e volentieri tali pratiche
tendono a renderlo di difficile comprensione e manutenzione. Typescript
ha tra i suoi costrutti alcuni che hanno proprio lo scopo di
semplificare nettamente il codice mascherando la vera e propria
complessità che origina dalla sua compilazione.

Interfacce e classi
-------------------

Nel [precedente
articolo](http://msdn.microsoft.com/it-it/library/dn194074.aspx) abbiamo
visto che grazie allo structured typing, Typescript è in grado di
riconoscere i tipi semplicemente analizzando la corrispondenza delle
proprietà. L'esempio seguente riassume in breve la questione:

```typescript
function getArea(s: { width: number; height: number; }): number
{
    return s.width * s.height / 2;
}
var area = getArea({ width: 20, height: 30 });
console.log(area.toString());
```

E' del tutto chiaro che questo tipo di notazione, pur se tutelata dal
compilatore, è eccessivamente prolissa e a lungo andare può essere
oggetto di errori e incomprensioni. Per questa ragione Typescript
ammette innanzitutto la creazione di interfacce, che altro non sono che
la definizione del contratto di un tipo cui il valore deve conformarsi.
Un concetto più che normale per chi conosce la programmazione ad
oggetti. Vediamo un esempio:

```typescript
interface Shape
{
    width: number;
    height: number;
}

function getArea(s: Shape): number
{
    return s.width * s.height / 2;
}

var area = getArea({ width: 20, height: 30 });
console.log(area.toString());
```

Nelle prime righe dello snippet è visibile la dichiarazione di una
interfaccia "Shape". Essa riporta le proprietà "width" e "height" e
viene usata come parametro della funzione getArea, al posto della
precedente notazione estesa. L'argomento passato alla getArea è rimasto
invariato, ma se provate a modificarne i nomi vi renderete contro che lo
structured typing continua a funzionare come prima validando il
parametro contro la definizione dell'intefaccia. Le interfacce ammettono
oltre alle proprietà anche metodi e proprietà opzionali (usando il ?).
Ecco un esempio:

```typescript
interface Shape
{
    width: number;
    height: number;
    color?: string;
    getArea(): number;
}

function getArea(s: Shape): number
{
    return s.getArea();
}

var area = getArea(
{
    width: 20,
    height: 30,
    getArea: function() { return this.width * this.height / 2; }
});

console.log(area.toString());
```

L'esempio in questione estremizza la definizione dell'interfaccia Shape
richiedendo una proprietà opzionale "color" (che poi non viene passata
più sotto) e un metodo che effettua il calcolo dell'area. In tal modo la
funzione getArea non deve fare altro che chiamare l'omonimo metodo
dell'interfaccia per ottenere il valore calcolato. Si tratta di un primo
passo verso una conversione object oriented dell'esempio. A questo punto
potremmo voler implementare l'interfaccia Shape in diverse figure e
fornire una diversa implementazione del calcolo. Lo possiamo fare grazie
alla presenza delle classi. Vediamo come:

```typescript
interface Shape
{
width: number;
height: number;
getArea(): number;
}

class Triangle implements Shape
{
constructor(
    public width: number,
    public height: number) { }

getArea(): number {
    return this.width * this.height / 2;
    }
}

class Square implements Shape
{
constructor(
    public width: number,
    public height: number) { }

getArea(): number {
    return this.width * this.height;
    }
}

function getArea(s: Shape): void
{
    var area = s.getArea();
    console.log(area.toString());
}

getArea(new Square(20, 30));
getArea(new Triangle(20, 30));
```

Grazie alla keyword "class" è possibile creare delle vere e proprie
classi che, a differenza di quello che succede per le interfacce che
spariscono nel codice Javascript, generano una struttura che chi è
avvezzo alle strutture tipiche di Javascript riconoscerà sicuramente.

```typescript
var Triangle = (function () {
    function Triangle(width, height) {
        this.width = width;
        this.height = height;
    }

    Triangle.prototype.getArea = function () {
        return this.width * this.height / 2;
    };
    
    return Triangle;
})();
```

Nel precedente snippet abbiamo anche la dimostrazione che una classe può
implementare una specifica interfaccia, per mezzo della keyword
"implements" e così facendo il compilatore verificherà a tempo di
compilazione che la classe supporti i metodi e le proprietà da essa
richieste. Siamo a questo punto arrivati ad una programmazione ad
oggetti del tutto raffinata che poco ha a che vedere con la complessità
cui si è abituati con Javascript, totalmente mascherata dal compilatore
Typescript.

Oltre all'implementazione di interfacce è del tutto possibile estendere
classi esistenti. Per fare questo dovremo utilizzare la keywork
"extends" al posto di "implements". Vediamo come usare l'ereditarietà
per create una classe "Cube" derivando da "Square":

```typescript
class Cube
    extends Square
    {
        constructor(
            width: number,
            height: number,
            public depth: number)
            {
                super(width, height);
            }
        
        getArea(): number
        {
            return (super.getArea() * 2) +
                (this.depth * this.width * 2) +
                (this.depth * this.height * 2);
        }
    }
```

In questo esempio vediamo che al costruttore della classe viene aggiunto
un ulteriore parametro "depth" che identifica l'altezza del
parallelepipedo. Avendo modificato la firma (signature), il compilatore
richiede che la prima chiamata nel body del costruttore sia la funzione
"super" che ha lo scopo di chiamare il costruttore della classe base.
Questa deve essere specificata come faremmo usando "base" in C\#. La
medesima keyword può essere usata anche per chiamare i metodi della
classe base. Ad esempio il metodo getArea richiama l'omonimo della
classe base per poi sfruttare il risultato integrando la rimanente parte
dell'area.

Usare i moduli
--------------

Una volta che abbiamo classi e interfacce i benefici che ne derivano
sono numerosi, soprattutto in termini di organizzazione logica del
codice e di manutenzione. Il passo successivo è di organizzare il codice
in moduli - i programmatori C\# li conosceranno meglio come "namespace"
(o Spazi dei Nomi) - per riuscire a creare vere e proprie librerie i cui
i nomi siano univoci. Anche in questo Typescript ci aiuta; grazie alla
keyword "module" infatti sarà possibile creare dei veri e propri
namespace:

```typescript
module Shapes
{
    export class Square implements Shape
    {
        constructor(
            public width: number,
            public height: number) { }
            
            getArea(): number
            {
                return this.width * this.height;
            }
    }
}
```

Interessante notare che la classe definita nel modulo "Shapes" è stata
decorata con "export". Infatti, una volta che abbiamo messo una classe
(o qualunque altro costrutto) in un modulo possiamo renderlo visibile o
invisibile all'esterno beneficiando di un incapsulamento che in termini
di librerie riutilizzabili è prezioso. 

Come si è abituati a fare con i namespace in C\#, anche in Typescript i
moduli possono essere annidati in modo del tutto analogo, creandoli
effettivamente l'uno nell'altro:

```typescript
module Shapes
{
    export class Square implements Shape
    {
        constructor(
            public width: number,
            public height: number) { }
        
        getArea(): number
        {
            return this.width \* this.height;
        }
    }

    export module ThreeD
    {
        export class Cube extends Square
        {
            // ... omissis
        }
    }
}
```

Oppure usando una notazione puntata

```typescript
module Shapes.ThreeD
{
    export class Cube extends Square
    {
        // ... omissis
    }
}
```

Ciascuna delle due notazioni può essere tranquillamente utilizzata
assieme all'altra creando vere e proprie composizioni in cui i moduli si
combinano. Una volta che i moduli sono stati creati sarà possibile
raggiungere i tipi definiti nei moduli specificando l'intero namespace:

```typescript
var square: Shapes.Square;
var cube: Shapes.ThreeD.Cube;
```

Data la notevole lunghezza e ridondanza che i nomi completi di namespace
possono raggiungere è del tutto possibile creare degli shortcut che
siano in grado di semplificare la scrittura del codice:

```typescript
import sh = Shapes;
import sh3d = Shapes.ThreeD;

var square: sh.Square;
var cube: sh3d.Cube;
```

Come a casa propria
-------------------

Sono convinto che i programmatori C\#, ma in generale qualunque
sviluppatore sia avvezzo all'uso di un linguaggio evoluto basato sui
paradigmi della programmazione ad oggetti, leggendo il codice Typescript
si senta come a casa propria. In effetti se si dà uno sguardo veloce al
codice generato dal compilatore si comprende come Typescript sia in
grado di fornire strumenti che la programmazione Javascript può dare
solo a caro prezzo. Per intenderci vediamo un esempio di cosa sia
possibile fare:

```typescript
module Shapes
{
    export interface Shape
    {
        width: number;
        height: number;
        getArea(): number;
    }
    
    export enum ShapeType
    {
        Square,
        Triangle
    }

    export class ShapeFactory
    {
        static create(type: ShapeType, width: number, height: number): Shape
        {
            switch (type)
            {
                case ShapeType.Square:
                    return new Square(width, height);
                case ShapeType.Triangle:
                    return new Triangle(width, height);
            }
            
            return null;
        }
    }

    class Triangle implements Shape
    {
        constructor(
            public width: number,
            public height: number) { }

            getArea(): number
            {
                return this.width * this.height / 2;
            }
    }

    class Square implements Shape
    {
        constructor(
            public width: number,
            public height: number) { }
        
        getArea(): number
            {
                return this.width * this.height;
            }
    }
}

import sh = Shapes;

var sq = sh.ShapeFactory.create(sh.ShapeType.Square, 20, 30);
console.log(sq.getArea());
```

Credo che la combinazione di moduli, classi, interfacce ed enumeratori
di questo esempio, assieme con l'applicazione di metodi statici e
dell'incapsulamento nei moduli, sia molto significativa di come si possa
scrivere con proprietà un codice molto efficace.

#### di [Andrea Boschin](http://mvp.microsoft.com/profiles/Andrea.Boschin) - Microsoft MVP 

*twitter*: @aboschin

*blog italiano*: <http://blog.boschin.it>

*blog inglese*: <http://xamlplayground.org>

*facebook***:** <http://www.facebook.com/thelittlegrove>

*profilo***:** <http://slpg.org/AndreaBoschin>

Articolo pubblicato anche [sul Blog
italiano](http://blog.boschin.it/post/2013/04/03/Typescript-organizzare-il-codice-con-interfacce-classi-e-moduli.aspx)
