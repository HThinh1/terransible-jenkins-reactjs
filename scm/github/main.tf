provider "github" {
  # token provide by using GITHUB_TOKEN env var
  # organization provide by using GITHUB_ORGANIZATION env var
  # base_url provide by using GITHUB_BASE_URL env var
}
resource "github_repository" "project-repo" {
  name        = "${var.PROJECT_NAME}"
  description = "This repo is for ${var.PROJECT_NAME}"
}
resource "github_user_ssh_key" "dev-server-ssh-key" {
  title = "${var.PROJECT_NAME}-key"
  key   = "${file("../../scripts/react-instance-key.pub")}"
}
