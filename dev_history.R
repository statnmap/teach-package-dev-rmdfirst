usethis::use_git_ignore("*.html")
usethis::use_git_ignore("*.md")
usethis::use_git_ignore("!README.md")
usethis::use_git_ignore("*_files/")
usethis::use_git_ignore("token.txt")

# Manage PR
usethis::pr_fetch(1)
usethis::pr_push()

# Set {renv}
renv::init()
renv::install("git2r")
renv::install("remotes")
options(remotes.git_credentials = git2r::cred_user_pass("gitlab-ci-token", Sys.getenv("GITLAB_THINKR_TOKEN")))
options(renv.auth.formation = list(GIT_PAT = Sys.getenv("GITLAB_THINKR_TOKEN")))
renv::install("git::https://git.thinkr.fr/ThinkR/formation")
remotes::install_git("https://git.thinkr.fr/ThinkR/formation", upgrade = FALSE, git = "git2r")

tmpform <- tempfile(pattern = "form-")
git2r::clone("https://git.thinkr.fr/ThinkR/formation", local_path = tmpform,
             credentials = git2r::cred_user_pass("gitlab-ci-token", Sys.getenv("GITLAB_THINKR_TOKEN")))
remotes::install_local(path = tmpform, upgrade = FALSE)

# Description
# _Get all deps to run courses, except old ones -- SUGGESTS --
all_courses <- list.files(here::here("courses"), full.names = TRUE, pattern = "[.]Rmd", recursive = TRUE)
all_deps_courses <- attachment::att_from_rmds(all_courses)
# _Get all deps to run templates_sc -- IMPORTS --
all_compil_to_test <- "compile_course.R"
# Extract all deps
all_deps_compils <- attachment::att_from_rscripts(all_compil_to_test)

supplements_imports <- c("git2r", "attachment", "testthat", "here", "flextable",
                         "remotes")

all_imports <- unique(c(supplements_imports, all_deps_courses))
all_deps_compils <- all_deps_compils[!all_deps_compils == "formation"]
# Add to DESCRIPTION
# usethis::use_description()
attachment::att_to_desc_from_is(
  imports = all_imports,
  suggests = all_deps_compils
)

custom_packages <- c(
  attachment::att_from_description(),
  "renv"#,
  # "devtools", "roxygen2", "usethis", "pkgload",
  # "testthat", "covr", "attachment",
  # remotes::install_github("ThinkR-open/checkhelper")
  # "pkgdown", "styler", "checkhelper"
)
renv::snapshot(packages = custom_packages)



# Snapshot before push
options(repos = c("CRAN" = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))
renv::snapshot()

# Restore after pull
renv::restore()

# Set Actions
usethis::use_github_action("render-rmarkdown")
