provider "bitbucket" {
  # username provide by using BITBUCKET_USERNAME env var
  # password provide by using BITBUCKET_PASSWORD env var
}

resource "bitbucket_repository" "illusions" {
  owner       = "${var.owner}"
  name        = "${var.PROJECT_NAME}"
  scm         = "${var.scm}"
  description = "This project is for ${var.PROJECT_NAME}. Auto created"
  is_private  = true
}
