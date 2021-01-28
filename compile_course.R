library(tidyverse)
library(formation)

# Compiler en parallèle
future::plan(future::multiprocess) # Parallèle
# plan(sequential) # Non parallèle. Default.

# Client - Nom de dossier
client_dir <- "user2020"

# Combien de sessions
all_sessions <- c("1") # Nom des sessions
all_dates <- paste(21, "July 2020") # Dates des sessions

# Dossier de données externes - Pour la carto
# dataWD <- "" # Hors Carto
# dataWD <- "/mnt/Data/ThinkR/Seafile/Dossier_ThinkR/ressources Formations/support/data"

# First and last slides
# first_last_slides
# formation::support() %>% cat(file = "first_last.Rmd")

# Create logo useR bottom
cat('.remark-slide-number-left {
    background: url("', knitr::image_uri("img/userlogo-small.png"),'") no-repeat left top;
    background-size: 20px;
}
.prez_github {
  background: #ffffffd4;
}
', sep = "",
file = "prez.css")


# Partial - Create course - Nom du (de la) formateur.trice ====
create_session <- purrr::partial(
  formation::create_session,
  title = "First steps in spatial data handling and visualization",
  formateur = "Sébastien Rochette, Dorris Scott, Jakub Nowosad",
  email = "@statnmap, @dorrisscott, @jnowosad",
  telephone = "",
  dossier = here::here(),
  # /!\ Render en pdf manuellement /!\
  render_pdf = c("none", "pagedown")[2],
  # Compiler le support formateur s'il y a des exercices dans le cours 
  # où les chunks sont cachés en mode stagiaire.
  # Comme ça le formateur a les réponses.
  types = c("stagiaire", "formateur")[1],
  # dataWD = dataWD,
  footer = "S. Rochette, D. Scott, J. Nowosad",
  url = "useR! 2020 - tutorial",
  # css = c(formation::formation_resource("thinkr.css"), here::here("prez.css")),
  css = here::here("prez.css"),
  logo_home = here::here("img/userlogo.png"),
  first_last_slides = here::here("courses/00-first-last-slides.Rmd"),
  first_last_slides_seal = FALSE,
  ... =
)

# css: prez.css
# footer: "S. Rochette, D. Scott, J. Nowosad"
# url: "use'R 2020 - tutorial"
# seal: false
# add_footer_chapitre: false

# Listes des supports de cours ====

# 3a - Jour 3, demi-journée 1 ----
# Liste des Rmd de supports de cours avec chemins complets
tous_les_cours <- list(
  cours_1 = c(
    # "courses/00-first-slide.Rmd",
    "courses/00-introduction.Rmd",
    "courses/00-cruz.Rmd",
    "courses/00-zoom.Rmd",
    # "courses/cartographie_visualisation_tmap.en.Rmd",
    "courses/01-cartography-visualisation-tmap.Rmd",
    # "courses/cartographie_basis.en.Rmd",
    "courses/02-cartography-basis.Rmd",
    # "courses/cartographie_objets_vectoriels_lecture-projections.en.Rmd",
    "courses/03-cartography-vectors-read-project.Rmd",
    # "courses/cartographie_objets_vectoriels_tidyverse.en.Rmd"#,
    "courses/04-cartography-vectors-tidyverse.Rmd",
    # "courses/cartographie_objets_vectoriels_geomatique.en.Rmd" 
    "courses/05-cartography-vectors-spatial-manipulation.Rmd"
  )
)

# Projets avec data, exos et td ----
# il faut définir des projet et leur contenus
# les element qui s'appellent 
# - "empty" vont etre preparé comme exos, en vidant les chunk d'exo,
# - "render" comme "empty", mais en plus l'exercice est compilé en HTML dans le dossier
# - "formateur" : les fichiers à déplacer dans le dossier formateur uniquement
# - les autres (avec ou sans nom) sont déposés tel quel dans le dossier

home <- list(
  projet1 = list(
    root =  c(
      render = "exercises/explore_saint_louis.Rmd"
    ),
    data = c(
      "data/departements",
      "data/cafes_bars",
      "data/cafes_bars",
      "data/cafes_bars.csv",
      "data/europe",
      "data/stl_neighborhoods",
      "data/stl_poi",
      "data/stl_restaurants",
      "data/data-out-solution",
      "data/data-out",
      "data/README.md"
    )
  )
)

# RUN --- Session ----
if (FALSE) {
  # Run session 1 par 1 pour tests
  for (i in 1:length(all_sessions)) {
    which_cours <- c(1:length(all_sessions))[i] # Chiffre de 1 à n
    which_session <- all_sessions[which_cours] 
    which_date <- all_dates[which_cours] 
    
    # Create session
    create_session(tous_les_cours, client_dir, which_cours, which_session, which_date)
  }
}

# All sessions - Normally used
if (TRUE) {
  create_session(
    tous_les_cours, client_dir, 
    which_cours = 1:length(all_sessions),
    which_session = all_sessions, 
    which_date = paste(all_dates[c(1, length(all_dates))], collapse = " - ")
  )
}


# Fonction - peuple_home() ----
formation::peuple_home(home = home, dossier = paste0(client_dir, "_home"))

# Fonction - export_pour_sc() ----
# formation::export_pour_sc(pattern = client_dir)

# === Infos SantaCruz ====
cat("
21 JULY 2020 - 14H UTC
USE'R 2020 - TUTORIAL
First steps in spatial data handling and visualization
> Balise: diapo 1 : stagiaire_user2020_session1.html#1
")


## Data à récupérer depuis shared ----
# En cas d'oubli ou de choses à passer plus tard
# Créer un fichier à la racine de "shared" avec ce genre d'instructions
if (FALSE) {
  ## Data à récupérer
  # 
  # Dans ce script:
  # Faire Ctrl + A 
  # puis Ctrl + Entrée
  # Et c'est tout
  # Prévenez s'il y a des messages d'erreurs, mais s'il y a juste des Warnings, c'est normal
  #
  # Cartographie
  # Projet 3
  # _data - un dossier complet
  # file.copy("~/shared/departements", "~/projet3/data", recursive = TRUE, overwrite = TRUE)
  # _exos - un fichier unique
  # file.copy("~/shared/exo_cartographie_exercices_initiation_vecteurs.Rmd", "~/projet3", overwrite = TRUE)
  # _exos rendered en html pour montrer aux apprenants leurs objectifs

}
