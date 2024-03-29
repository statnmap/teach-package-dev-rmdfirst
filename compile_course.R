# Compile Courses for SC platform
library(tidyverse)
library(formation)

# Compiler en parallèle
future::plan(future::multisession(workers = 4)) # Parallèle
# plan(sequential) # Non parallèle. Default.

# Client - Nom de dossier
client_dir <- "afh2022"

# Combien de sessions
all_sessions <- c("1") # Nom des sessions
all_dates <- paste(28, "June 2022") # Dates des sessions

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
  title = "Build reproducible and shareable data analyses using R packages",
  formateur = "Sébastien Rochette, Florence Mounier",
  email = "sebastien@thinkr.fr, florence@thinkr.fr",
  telephone = "",
  dossier = here::here(),
  render_pdf = c("none", "pagedown")[2],
  types = c("stagiaire", "formateur")[1],
  # dataWD = dataWD,
  footer = "S. Rochette, F. Mounier",
  # add_footer_chapitre = FALSE,
  url = "AFH 2022 - tutorial",
  # css = here::here("prez.css"),
  # logo_home = here::here("courses/images/marmot.png"),
  first_last_slides = here::here("courses/00-first-last-slides.Rmd"),
  first_last_slides_seal = FALSE,
  ... =
)

# Listes des supports de cours ====
tous_les_cours <- list(
  cours_1 = c(
    "courses/C00-package-objectives.en.Rmd",
    # "courses/00-cruz.Rmd"#,
    "courses/C05-comment_utiliser_bakacode.en.Rmd",
    # "courses/C04-comment_interagir_zoom.en.Rmd",
    "courses/C00-package_preambule.en.Rmd",
    "courses/C01a-package_fusen_discover.en.Rmd",
    "courses/C01b-package_express_fusen.en.Rmd",
    # "courses/C06-pkg_avance_test.en.Rmd"#,
    "courses/C09-pkg_avance_data.en.Rmd",
    "courses/C13-git_fusen.en.Rmd",
    "courses/C14-data-analyses-packages.en.Rmd"
  )
)

# Projets avec data, exos et td ----
# il faut définir des projet et leur contenus
# les element qui s'appellent
# - "empty" vont etre preparé comme exos, en vidant les chunk d'exo,
# - "render" comme "empty", mais en plus l'exercice est compilé en HTML dans le dossier
# - "formateur" : les fichiers à déplacer dans le dossier formateur uniquement
# - les autres (avec ou sans nom) sont déposés tel quel dans le dossier

# Do not create home on Github Actions
if (Sys.getenv("FILL_HOME", unset = "TRUE") == "TRUE") {
  # Create empty fusen packages
  dirfusen <- tempfile(pattern = "fusen-")
  dir.create(dirfusen)
  mytools <- file.path(dirfusen, "mytools.solution")
  hello <- file.path(dirfusen, "hello.solution")
  wd <- getwd()

  usethis::with_project(path = dirfusen, {
    # mytools
    dir.create(mytools, recursive = TRUE)
    fusen::add_flat_template(pkg = mytools, flat_name = "teaching", open = FALSE)
    # hello
    dir.create(hello, recursive = TRUE)
    fusen::add_flat_template(pkg = hello, flat_name = "minimal", open = FALSE)
  }, force = TRUE)

  setwd(wd)

  home <- list(
    projet1 = list(
      root =  c(
        formateur = "courses/quizz.Rmd"# ,
        # render = "nyc_squirrels_rmd/nyc_squirrels_rmd_simple.Rmd"
      ),
      data = c(
        # "nyc_squirrels_rmd"
      )
    ),
    mytools.solution = list(
      root = c(file.path(mytools, "dev"))
    ),
    hello.solution = list(
      root = c(file.path(hello, "dev"))
    )
  )
}

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

# Do not create home on Github Actions
if (Sys.getenv("FILL_HOME", unset = "TRUE") == "TRUE") {
  # Fonction - peuple_home() ----
  formation::peuple_home(home = home, dossier = paste0(client_dir, "_home"))
  formation::copy_pdf()
  # Fonction - export_pour_sc() ----
  # formation::export_pour_sc(pattern = client_dir)
}
