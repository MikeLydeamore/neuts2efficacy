install.packages(
    c(
    "ggplot2",
    "readr",
    "tidyr",
    "stringr",
    "dplyr",
    "gaussquad",
    "bayesplot",
    "testthat",
    "colorspace",
    "targets"
  )
)

options(
  repos = c(
    gretadev = 'https://greta-dev.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'
    )
  )

# Install greta
install.packages('greta')
library(greta)
install_greta_deps()