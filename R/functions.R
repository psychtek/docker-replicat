# Function to build docker locally
docker_build <- function(dockerfile = "inst/Dockerfile", name = "psychtek/replicats:latest"){

  if(isFALSE(file.exists(dockerfile = "inst/Dockerfile"))){
    cli::cli_abort("No Dockerfile could be found: {.path {dockerfile}}")
  }

  if(is.null(name)) {
    cli::cli_alert_info("{.arg name} args not provided using package name. ")
    name <- basename(getwd())
  } else {
    name <- tolower(name)
  }

  build_command <- paste0("docker build --no-cache=true -t ", name ," -f ", dockerfile, " .")
  cli::cli_alert_info("Building {.path {dockerfile}} as {.emph {name}}")

  system(build_command)

  system("docker image list")

  cli::cli_alert_success("Success!")

}

