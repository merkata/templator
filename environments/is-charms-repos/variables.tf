variable "repo_names" {
  description = "Repo names to use with the selected template."
  type        = set(string)
}

variable "template_repo_enabled" {
  description = "Whether to use a template repository when creating a repo."
  type        = map(any)
}

variable "template_repo_name" {
  description = "Repo name of the template repository."
  type        = string
}

variable "template_repo_owner" {
  description = "Repo owner of the template repository."
  type        = string
}
