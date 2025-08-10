install.packages("bibliometrix")
library(bibliometrix)
library(igraph)
csrbib=convert2df("csr.bib", dbsource = "wos", format = "bibtex")
D=metaTagExtraction(csrbib, Field = "CR_AU", sep = ";")
results <- biblioAnalysis(csrbib, sep = ";")
summary(results)

plot(x = results, k = 10, pause = FALSE)
NetMatrix <- biblioNetwork(csrbib, analysis = "co-occurrences", network = "keywords", sep = ";")

networkPlot(NetMatrix, normalize = "association", weighted = TRUE, n = 50, Title = "Keyword Co-occurrence")
M <- biblioNetwork(D, analysis = "co-citation", network = "authors", sep = ";")

networkPlot(
  M,
  n = 50,                     # top 50 most cited authors
  type = "fruchterman",       # layout
  size = TRUE,                # node size ~ frequency
  remove.isolates = TRUE,
  labelsize = 0.8,
  cluster = "louvain",        # clustering algorithm
  label.n = 50,               # number of labels to display
  Title = "Author Co-citation Network with Theme Clusters"
)
