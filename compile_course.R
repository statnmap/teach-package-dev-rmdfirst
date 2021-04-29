# Compile Courses for SC platform
library(tidyverse)
library(formation)

# Compiler en parallèle
future::plan(future::multisession) # Parallèle
# plan(sequential) # Non parallèle. Default.

# Client - Nom de dossier
client_dir <- "user2021"

# Combien de sessions
all_sessions <- c("1") # Nom des sessions
all_dates <- paste(21, "July 2021") # Dates des sessions

# First and last slides
# first_last_slides
# formation::support() %>% cat(file = "first_last.Rmd")

# Create logo useR bottom
# cat('.remark-slide-number-left {
#     background: url("', knitr::image_uri("img/userlogo-small.png"),'") no-repeat left top;
#     background-size: 20px;
# }
# .prez_github {
#   background: #ffffffd4;
# }
# ', sep = "",
# file = "prez.css")


# Partial - Create course - Nom du (de la) formateur.trice ====
create_session <- purrr::partial(
  formation::create_session,
  title = "How to build a package following 'Rmd First' method?",
  formateur = "Sébastien Rochette, Emily Riederer, Malcolm Barrett",
  email = "@statnmap, @EmilyRiederer, @malco_barrett",
  telephone = "",
  dossier = here::here(),
  render_pdf = c("none", "pagedown")[2],
  types = c("stagiaire", "formateur")[1],
  # dataWD = dataWD,
  footer = "S. Rochette, E. Riederer, M. Barrett",
  # add_footer_chapitre = FALSE,
  url = "useR! 2021 - tutorial",
  # css = here::here("prez.css"),
  logo_home = here::here("courses/images/marmot.png"),
  first_last_slides = here::here("courses/00-first-last-slides.Rmd"),
  first_last_slides_seal = FALSE,
  ... =
)

# Listes des supports de cours ====
tous_les_cours <- list(
  cours_1 = c(
    "courses/C00-package-objectives.en.Rmd",
    "courses/00-cruz.Rmd",
    # "courses/00-zoom.Rmd",
    "courses/C00-package_preambule.en.Rmd",
    "courses/C01-package_express.en.Rmd",
    "courses/C06-pkg_avance_test.Rmd",
    "courses/C04-package-fusen.en.Rmd"
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
      formateur = "courses/quizz.Rmd",
      render = "nyc_squirrels_rmd/nyc_squirrels_rmd_simple.Rmd"
    ),
    data = c(
      "nyc_squirrels_rmd"
    )
  )
)

# All sessions - Normally used
if (TRUE) {
  create_session(
    tous_les_cours, client_dir,
    which_cours = 1:seq_along(all_sessions),
    which_session = all_sessions,
    which_date = paste(all_dates[c(1, length(all_dates))], collapse = " - "),
    output_pattern = "complet",
    output_dir = "complet"
  )
}

# Fonction - peuple_home() ----
formation::peuple_home(home = home, dossier = paste0(client_dir, "_home"))

# Fonction - export_pour_sc() ----
# formation::export_pour_sc(pattern = client_dir)
