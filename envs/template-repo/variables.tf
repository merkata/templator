variable "template_files" {
  description = "A set of files to manage in terraform."
  type        = set(string)
}

variable "repo_name" {
  description = "Repo name to use as a template repository."
  type        = string
}
