first <- FALSE

if(first){
    system("docker network create r-db",wait = FALSE)
}

## Running DB
system("docker run --rm -e POSTGRES_PASSWORD=docker --name postgre --net r-db postgres:11.3", wait = FALSE)

### Set good working directory for docker volumes
my_project <- here::here()
projectname <- basename(my_project)


  system(
    paste0(
      "docker run -d --name ", projectname,
      " -v ", my_project, ":/home/rstudio/", projectname,
      " -p 8787:8787 -e DISABLE_AUTH=true --net r-db colinfay/r-db:3.6.1"
      ),
   wait = FALSE)

Sys.sleep(2)
browseURL(paste0("http://localhost:", port))

## Launch your DB :

