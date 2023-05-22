terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}

provider "github" {}

module "template-repo" {
  source         = "../../modules/template-repo"
  repo_name      = var.repo_name
  template_files = var.template_files
}
