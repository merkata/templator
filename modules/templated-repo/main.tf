terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}

resource "github_repository" "templated" {
  for_each = toset(var.repo_names)
  name        = each.value
  description = "A terraform repo from template test"

  visibility = "public"

    template {
    owner                = var.template_repo_owner
    repository           = var.template_repo_name
    include_all_branches = true
  }
}

resource "github_branch_protection" "templated-protect" {
  for_each = toset(var.repo_names)
  repository_id = each.value
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
