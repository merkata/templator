terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}

resource "github_repository" "template" {
  name        = var.repo_name
  description = format("%s - a terraform managed template repo", var.repo_name)

  visibility = "public"

  auto_init = true

  is_template = true
  has_issues  = true
}

resource "github_branch_protection" "template-protect" {
  repository_id = github_repository.template.node_id
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "main"

  require_signed_commits = true

  require_conversation_resolution = true

  required_status_checks {
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 2
  }
}

resource "github_repository_file" "template-files" {
  for_each            = toset(var.template_files)
  repository          = github_repository.template.name
  branch              = "main"
  file                = each.value
  content             = file("${path.module}/files/${each.value}")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}
