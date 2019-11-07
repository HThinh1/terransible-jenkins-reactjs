provider "gitlab" {
  # token provide by using GITLAB_TOKEN env var
  # base_url provide by using GITLAB_BASE_URL env var 
}
resource "gitlab_project" "project" {
  name = "${var.PROJECT_NAME}"
}
