# Get packages, sort alphabetically for minor convenience later
pkgs  <- sort(rownames(installed.packages()))

# Assemble script
scrpt <- glue::glue(
  "if (!('{pkgs}' %in% installed.packages())) ",
  "install.packages('{pkgs}')"
)

# Write to file
writeLines(scrpt, con = glue::glue("Rreq.R"))

