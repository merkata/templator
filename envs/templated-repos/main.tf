terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}

module "templated-repos" {
  source              = "../../modules/templated-repo"
  repo_names          = var.repo_names
  template_repo_owner = var.template_repo_owner
  template_repo_name  = var.template_repo_name
}
