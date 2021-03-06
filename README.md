# progettino_retefacebook

Questo progetto ha come obiettivo quello di fare l'analisi di una rete in
cui i nodi sono dei politici e i link sono dati dall'interazione tra di 
loro su Facebook, tramite il "LIKE" di uno all'altro.
Per semplicità si considera questo grafo un grafo indiretto.

Fonte dei dati presi in considerazione:
      title = {The Network Data Repository with Interactive Graph 
      Analytics and Visualization},
      author={Ryan A. Rossi and Nesreen K. Ahmed},
      booktitle = {AAAI},
      url={http://networkrepository.com},
      year={2015}

Analisi effettuate:

- Tracciato il grafo ed effetuata un analisi generale delle principali 
  caratteristiche
- Definita la distribuzione del grado - usando il tool di Matlab: 
  'dfittool'
- Considerando i 10 nodi più collegati abbiamo confrontato l'importanza di 
  questi ottenuta tramite due metodi:
	+ Considerando il grado
	+ Considerando la Pairwise Connectivity
    + Considerando la closeness
    + Considerando eigvector centrality
- Tracciato i grafi eliminando i nodi 'importanti' secondo i metodi scritti
  precedentemente 
- Calcolo del coefficiente di Clustering medio per conoscere il grado di
  interconnettività tra i nodi
- Calcolo del rapporto λ2/λn per valutare la connettività del grafo
- Effetuato il clustering kmeans

