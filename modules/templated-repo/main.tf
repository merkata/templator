terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}

resource "github_repository" "templated" {
  for_each    = toset(var.repo_names)
  name        = each.value
  description = format("%s - charm repository.", each.value)

  visibility = "public"

  allow_merge_commit     = false
  allow_rebase_merge     = false
  delete_branch_on_merge = true

  has_issues    = true
  has_downloads = true
  has_projects  = true
  has_wiki      = true

  dynamic "template" {
    for_each = var.template_repo_enabled[each.value] == true ? toset([1]) : toset([])
    content {
      include_all_branches = true
      owner                = var.template_repo_owner
      repository           = var.template_repo_name
    }
  }
}

resource "github_branch_protection" "templated-protect-main" {
  for_each      = toset(var.repo_names)
  repository_id = each.value
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "main"

  enforce_admins = true

  require_signed_commits          = true
  require_conversation_resolution = true
  required_linear_history         = true

  required_status_checks {
    contexts = [
      "integration-tests / Required Integration Test Status Checks",
      "unit-tests / Required Test Status Checks",
    ]
    strict = true
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 2
    restrict_dismissals             = false
  }
}

resource "github_branch_protection" "templated-protect-catchall" {
  for_each      = toset(var.repo_names)
  repository_id = each.value
  # also accepts repository name
  # repository_id  = github_repository.example.name

  pattern = "**/**"

  allows_deletions = true

  require_signed_commits = true

  require_conversation_resolution = false

}
