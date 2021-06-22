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
remotes::install_git("https://git.thinkr.fr/ThinkR/formation", upgrade = FALSE)

# Snapshot before push
renv::snapshot()

# Restore after pull
renv::restore()

# Set Actions
usethis::use_github_action("render-rmarkdown")
