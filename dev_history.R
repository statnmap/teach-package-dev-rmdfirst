usethis::use_git_ignore("*.html")
usethis::use_git_ignore("*.md")
usethis::use_git_ignore("!README.md")
usethis::use_git_ignore("*_files/")
usethis::use_git_ignore("token.txt")

usethis::pr_fetch(1)
usethis::pr_push()
