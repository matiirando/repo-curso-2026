# ==============================================================================
# Tarea 05 - Text Mining (ECON 520 - FCE-UBA)[cite: 1]
# Workflow de Análisis de Texto con Tidytext[cite: 1]
# ==============================================================================

library(tidyverse)
library(tidytext)
library(topicmodels)
library(igraph)
library(ggraph)

# 1. Cargar el dataset (reemplazar la ruta por el archivo local bajado del link)[cite: 1]

datos <- read_csv("DATA-T9-mckinsey-mind-the-gap-articles-20251020.csv")

datos <- read_csv("Data/DATA-T9-mckinsey-mind-the-gap-articles-20251020.csv")

# 1. Tokenización: Separar los textos palabra por palabra
# (Usamos un ID único por artículo basado en la fila o título)
datos_tokens <- datos %>%
  mutate(doc_id = row_number()) %>%
  unnest_tokens(word, article_text) %>%
  anti_join(stop_words) # Quitamos palabras vacías en inglés (the, and, of, etc.)

# 2. Ver las 15 palabras más frecuentes del corpus global
palabras_frecuentes <- datos_tokens %>%
  count(word, sort = TRUE)

head(palabras_frecuentes, 15)

# 3. Calcular TF-IDF por documento para evaluar comparabilidad
# TF-IDF mide qué tan relevante es una palabra en un artículo comparado con el total
doc_tfidf <- datos_tokens %>%
  count(doc_id, word) %>%
  bind_tf_idf(word, doc_id, n) %>%
  arrange(desc(tf_idf))

head(doc_tfidf, 10)

# Visualizar los términos con mayor TF-IDF en algunos documentos
doc_tfidf %>%
  group_by(doc_id) %>%
  slice_max(tf_idf, n = 3) %>%
  head(15)

# A. Diccionario Binario (Bing)
sentimiento_bing <- datos_tokens %>%
  inner_join(get_sentiments("bing")) %>%
  count(doc_id, sentiment) %>%
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) %>%
  mutate(sentimiento_neto = positive - negative)

# Ver las notas con sentimiento neto más positivo y negativo
head(sentimiento_bing)

# B. Diccionario Graduado (AFINN)
sentimiento_afinn <- datos_tokens %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(doc_id) %>%
  summarise(puntaje_afinn = sum(value))

# Ver el puntaje graduado
head(sentimiento_afinn)

install.packages("textdata")

library(textdata)

sentimiento_afinn <- datos_tokens %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(doc_id) %>%
  summarise(puntaje_afinn = sum(value))

head(sentimiento_afinn)

sentimiento_afinn <- datos_tokens %>%
  inner_join(get_sentiments("afinn")) %>%
  group_by(doc_id) %>%
  summarise(puntaje_afinn = sum(value))

head(sentimiento_afinn)

install.packages("topicmodels")

library(topicmodels)

# 1. Convertir nuestros datos a una Matriz Termino-Documento (DTM)
dtm <- datos_tokens %>%
  count(doc_id, word) %>%
  cast_dtm(doc_id, word, n)

# 2. Modelo LDA para k = 10 tópicos
lda_k10 <- LDA(dtm, k = 10, control = list(seed = 1234))

# Ver las principales palabras de cada tópico (beta) para k=10
top_terms_k10 <- tidy(lda_k10, matrix = "beta") %>%
  group_by(topic) %>%
  slice_max(beta, n = 5) %>%
  ungroup() %>%
  arrange(topic, -beta)

head(top_terms_k10, 15)

# 3. Modelo LDA para k = 15 tópicos
lda_k15 <- LDA(dtm, k = 15, control = list(seed = 1234))

# Ver las principales palabras de cada tópico (beta) para k=15
top_terms_k15 <- tidy(lda_k15, matrix = "beta") %>%
  group_by(topic) %>%
  slice_max(beta, n = 5) %>%
  ungroup() %>%
  arrange(topic, -beta)

head(top_terms_k15, 15)


library(topicmodels)

lda_k10 <- LDA(dtm, k = 10, control = list(seed = 1234))

library(topicmodels)

# 1. Modelo para k = 10 tópicos
lda_k10 <- LDA(dtm, k = 10, control = list(seed = 1234))

# Ver las principales palabras de cada tópico (beta) para k=10
top_terms_k10 <- tidy(lda_k10, matrix = "beta") %>%
  group_by(topic) %>%
  slice_max(beta, n = 5) %>%
  ungroup() %>%
  arrange(topic, -beta)

head(top_terms_k10, 15)

# 2. Modelo para k = 15 tópicos
lda_k15 <- LDA(dtm, k = 15, control = list(seed = 1234))

# Ver las principales palabras de cada tópico (beta) para k=15
top_terms_k15 <- tidy(lda_k15, matrix = "beta") %>%
  group_by(topic) %>%
  slice_max(beta, n = 5) %>%
  ungroup() %>%
  arrange(topic, -beta)

head(top_terms_k15, 15)

install.packages(c("igraph", "ggraph"))

library(igraph)
library(ggraph)

# 1. Generar los bigramas (pares de 2 palabras consecutivas)
bigramas <- datos %>%
  mutate(doc_id = row_number()) %>%
  unnest_tokens(bigram, article_text, token = "ngrams", n = 2) %>%
  separate(bigram, c("palabra1", "palabra2"), sep = " ")

# 2. Bigramas más frecuentes (filtrando stop words)
bigramas_conteo <- bigramas %>%
  filter(!palabra1 %in% stop_words$word, 
         !palabra2 %in% stop_words$word) %>%
  count(palabra1, palabra2, sort = TRUE)

# Visualizar la red de bigramas frecuentes (conexiones con n > 15)
red_bigramas <- bigramas_conteo %>%
  filter(n > 15) %>%
  graph_from_data_frame()

ggraph(red_bigramas, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n), show.legend = FALSE) +
  geom_node_point(color = "steelblue", size = 4) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
  theme_void() +
  labs(title = "Red de Bigramas Más Frecuentes")

# 3. Bigramas con Negaciones ("not", "no", "never", "without")
palabras_negacion <- c("not", "no", "never", "without")

bigramas_negacion <- bigramas %>%
  filter(palabra1 %in% palabras_negacion) %>%
  count(palabra1, palabra2, sort = TRUE)

head(bigramas_negacion, 15)