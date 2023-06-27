# BA_text_classification

```mermaid

graph TD

subgraph portal/lib/Portal
class2
class2a
class2b[anderes mapping]
class2c[anderes mapping]
end


averbis-->classa[Klasse <br> Medizin, Landwirtschaft, ...]
LDA-->class1[Klasse <br> 1,2,3,4,5]

class1-->|mapping 1|class2[Klasse <br> 1->Medizin <br> 2->Landwirtschaft <br>3-> ...]

classa-->error[Fehlerberechnung<br>acc<br>f1<br>TODO: guckn welchen Fehlerwert...]
class2-->error


class1-->|mapping 2|class2a[Klasse <br> 3->Medizin <br> 2->Landwirtschaft <br>1-> ...]

classa---> errora[Fehlerberechnung<br>acc<br>f1<br>TODO: guckn welchen Fehlerwert...]
class2a--->errora





```

- mapping 1
  -   medizin - 1
  -   umwelt - 2
  -   essen -3 
  -   bauer -4
  -   rest -5
-   mapping 2
   -   medizin - 2
   -   umwelt - 1
   -   essen -3 
   -   bauer -4
   -   rest -5
  
-   mapping 3
  -   medizin - 3
  -   umwelt - 2
  -   essen -1
  -   bauer -4
  -   rest -5

pertubations od comnbinations
keine doppelten
reiehnfolge ist egal
