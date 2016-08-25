#### di [Andrea Boschin](http://mvp.microsoft.com/en-us/mvp/Andrea%20Boschin-4000289) – Microsoft MVP

1.  ![](./img//media/image1.png){width="0.5938331146106737in"
    height="0.9376312335958005in"}

*Aprile, 2014*

Rilasciati all'interno di Blend 3.0, nel 2009, come un mero strumento a
supporto dei designer che li poteva usare per inserire sulla superficie
di Blend non solo componenti di interfaccia, ma anche dei "frammenti di
logica", i behavior hanno immediatamente assunto un ruolo primario nello
sviluppo di applicazioni, grazie alla loro capacità di favorire la netta
separazione tra logica di business e interfaccia utente. Questa capacità
è rappresentata dal fatto che essi sono in grado di racchiudere e
isolare porzioni di codice - con accesso diretto ai componenti di
interfaccia ma pilotati dalla logica di business - inseribili facilmente
direttamente nello XAML senza che sia necessaria alcuna logica
accessoria.

Nati in particolare all'interno di Silverlight, essi sono immediatamente
diventati parte del kit di sopravvivenza dello sviluppatore,
specialmente di quello che intendeva implementare il pattern MVVM con
facilità ed in seguito hanno visto il porting verso Windows Phone e
finalmente anche in WinRT, con il rilascio dell'ultima versione 8.1.
Conoscerli e usarli opportunamente può davvero far risparmiare un sacco
di tempo. Vediamo come.

Usare i behavior esistenti
--------------------------

Il primo passo nell'utilizzo dei behavior è quello di inserirli nel
progetto di Visual Studio e cominciare ad usare quelli esistenti. In
effetti la libreria - denominata "Behaviors SDK (XAML)" porta con se una
serie di classi base da cui è possibile fare ereditare i propri behavior
ma anche un set abbastanza nutrito di componenti già realizzati e pronti
all'uso. Essi hanno la caratteristica di essere parametrizzabili e
generici così da essere fortemente riutilizzabili e quindi sono anche
una buona scuola per quando dovremo realizzarne di nostri.

Per inserirli nel progetto con Visual Studio 2013 è sufficiente
selezionarli dalla libreria delle estensioni (vedi sotto) operando come
se si dovesse aggiungere una referenza al progetto.

1.  ![](./img//media/image2.png){width="5.822916666666667in"
    height="2.4479166666666665in"}

I Behavior sono una libreria di componenti nativi e managed, e come tali
possono essere usati sia in progetti C\#/VB.NET sia in C++. Non
richiedono particolari cautele come avviene per altri tipi di componenti
perciò, una volta inserita la referenza all'SDK sarà immediatamente
possibile iniziare ad usarli. Non c'è dubbio che il modo migliore è
quello di usare Blend, al cui interno vengono visualizzati nella scheda
degli Assets, come dei piccoli componenti che possono essere trascinati
sulla superficie del designer e agganciati ai vari elementi. Una volta
collegati è possibile modificarne le proprietà usando la consueta
finestra di blend.

Dal punto di vista dello sviluppatore un bahavior appare ne più ne meno
che come una attached property che può essere valorizzata su qualunque
elemento del DOM. La proprietà è dichiarata nel namespace
"Microsoft.Xaml.Interactivity" e una volta inserito nel codice xaml essa
appare come una collection:

1.  XAML

<!-- -->

1.  1: &lt;Page

    2: x:Class="App1.MainPage" mc:Ignorable="d"

    3: xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"

    4: xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"

    5: xmlns:d="http://schemas.microsoft.com/expression/blend/2008"

    6:
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"

    7: xmlns:i="using:Microsoft.Xaml.Interactivity"&gt;

    8: &lt;Grid Background="{ThemeResource
    ApplicationPageBackgroundThemeBrush}"&gt;

    9: &lt;Rectangle x:Name="rect" Fill="Yellow" Width="100"
    Height="100"&gt;

    10: &lt;i:Interaction.Behaviors&gt;

    11: &lt;!-- aggiungere qui in behaviors --&gt;

    12: &lt;/i:Interaction.Behaviors&gt;

    13: &lt;/Rectangle&gt;

    14: &lt;/Grid&gt;

    15: &lt;/Page&gt;

A questo punto va referenziato un ulteriore namespace, chiamiamolo per
brevità "core", il quale contiene i behavior predefiniti di cui parlavo
poco fa. In particolare essi sono "EventTriggerBehavior" e
"DataTriggerBehavior". I loro nomi dovrebbero essere autoesplicativi ma
per completezza diciamo che il primo lo si può agganciare ad un singolo
evento di un elemento mentre il secondo fa riferimento al un valore di
una proprietà.

Poniamo ad esempio di voler fare in modo che il rettangolo giallo
dell'esempio precedente debba diventare rosso quando cliccato. Potremmo
semplicemente aggiungere il seguente snippet all'interno della
collezione dei behaviors:

1.  XAML

<!-- -->

1.  1: &lt;core:EventTriggerBehavior EventName="PointerPressed"&gt;

    2: &lt;core:ChangePropertyAction PropertyName="Fill" Value="Red"
    /&gt;

    3: &lt;/core:EventTriggerBehavior&gt;

In buona sostanza, stiamo dicendo che al verificarsi di un evento
PointerPressed venga eseguita una "action" che cambia il valore di una
proprietà. Le action sono un secondo livello di componenti predefiniti
di cui dirò tra poco. Questa action in particolare si occupa di variare
la proprietà "Fill" impostandola a "Red". Mandando in esecuzione
l'esempio si vedrà che l'effetto ottenuto è proprio quello desiderato,
ma anche che, a differenza di quanto avviene per il VisualStateManager,
il sistema non tiene traccia dello stato originario e quindi per
riportarlo allo stato precedente dovremmo aggiungere l'operazione
inversa:

1.  XAML

<!-- -->

1.  1: &lt;Rectangle x:Name="rect" Fill="Yellow" Width="100"
    Height="100"&gt;

    2: &lt;i:Interaction.Behaviors&gt;

    3: &lt;core:EventTriggerBehavior EventName="PointerPressed"&gt;

    4: &lt;core:ChangePropertyAction PropertyName="Fill" Value="Red"
    /&gt;

    5: &lt;/core:EventTriggerBehavior&gt;

    6: &lt;core:EventTriggerBehavior EventName="PointerReleased"&gt;

    7: &lt;core:ChangePropertyAction PropertyName="Fill" Value="Yellow"
    /&gt;

    8: &lt;/core:EventTriggerBehavior&gt;

    9: &lt;/i:Interaction.Behaviors&gt;

    10: &lt;/Rectangle&gt;

Le action che si possono applicare sono molteplici e coprono un vasto
numero di necessità:

**CallMethodAction**: L'action richiama un metodo dell'oggetto cui si
riferisce. Assomiglia molto al collegamento di un EventHandler nel
codebehind.

**ControlStoryBoardAction**: Consente di collegare una o più storyboard
e avviarle, così come si fa con i trigger di WPF.

**GoToStateAction**: Consente di attivare uno stato del
VisualStateManager.

**InvokeCommandAction**: Uno delle action più utilizzate, in ambito MVVM
consente di attivare comandi in risposta a qualunque evento se usato in
concomitanza con EventTriggerBehavior.

**NavigateToPage**: Attiva la navigazione verso una pagina
dell'applicazione

**PlaySoundAction**: Esegue un suono

1.  

Una nota a parte la merita sicuramente l'InvokeCommandAction, la cui
esistenza è indispensabile in scenari MVVM. Esso infatti sopperisce alla
mancanza dei consueti "*Command*" e "*CommandParameter*" relativi la
maggioranza degli eventi dei controlli XAML. Come in Silverlight, anche
nelle Windows Store apps solamente ButtonBase implementa queste
proprietà. E qui viene in aiuto questa action che associata ad un
opportuno EventTriggerBehavior è in grado di riportare ad un Command del
ViewModel qualunque iterazione dell'utente, aprendo numerose strade.

L'uso del EventTriggerBehavior è sicuramente il più consueto ma non va
dimenticata la presenza del meno intuitivo DataTriggerBehavior. Esso ha
lo scopo di legare l'esecuzione di una o più action al cambiare del
valore di una proprietà. Pensiamo ad esempio ad avere una proprietà che
indica una soglia di pericolosità, aggiornata in tempo reale (magari via
SignalR). L'utilizzo di un DataTriggerBehavior è specifico per questi
casi e ci consente di attivare una action quando il valore va oltre una
determinata soglia:

1.  XAML

<!-- -->

1.  1: &lt;Rectangle Background="Green"&gt;

    2: &lt;Interactivity:Interaction.Behaviors&gt;

    3: &lt;Core:DataTriggerBehavior Binding="{Binding Severity}"
    ComparisonCondition="GreaterThanOrEqual" Value="3"&gt;

    4: &lt;Core:ChangePropertyAction PropertyName="Background"&gt;

    5: &lt;Core:ChangePropertyAction.Value&gt;

    6: &lt;SolidColorBrush&gt;Red&lt;/SolidColorBrush&gt;

    7: &lt;/Core:ChangePropertyAction.Value&gt;

    8: &lt;/Core:ChangePropertyAction&gt;

    9: &lt;/Core:DataTriggerBehavior&gt;

    10: &lt;/Interactivity:Interaction.Behaviors&gt;

    11: &lt;/Rectangle&gt;

Il codice qui sopra usa una condizione, indicata dalla proprietà
“Comparison Condition” per definire quale sia il valore soglia che
converte. il colore da Verde a Rosso.

I behavior come abbiamo visto sono uno strumento davvero insostituibile
in molti casi. Ancor di più se, come vedremo nel prossimo articolo ne
creiamo di nostri, con proprietà che ne parametrizzano l’azione.

#### di [Andrea Boschin](http://mvp.microsoft.com/en-us/mvp/Andrea%20Boschin-4000289) – Microsoft MVP
