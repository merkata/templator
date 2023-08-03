# GitHub repo templator

A terraform set of environments and modules to set up an initial repository as a template repo and create repositories
that clone from said repo to benefit from the templates.

## Usage

Create a personal access token on GitHub

- export GITHUB_TOKEN # set to the token created
- export GITHUB_OWNER # set to your account name

```shell
cd environments/template-charm-repo
# adjust terraform.tfvars
terraform init && terraform plan && terraform apply
cd environments/templated-repos
# adjust terraform.tfvars
terraform init && terraform plan && terraform apply
```

### Adding an existing repo

Adding an existing repo means adding the configuration in the `terraform.tfvars` under the environments repo directory
that hosts your environmnents and then importing the resources in the state, so that they can be refreshed subsequently.

```text
repo_names = [
  "repo",
]

template_repo_enabled = {
  "repo" : false
}
```

```shell
terraform import 'module.templated-repos.github_repository.templated["repo"]' repo
terraform import 'module.templated-repos.github_branch_protection.templated-protect-main["repo"]' repo:main
terraform import 'module.templated-repos.github_branch_protection.templated-protect-catchall["repo"]' repo:**/**
terraform plan && terraform apply
```

### Creating a new repo

If you want to create a new repo, you need to populate `terraform.tfvars` only in the environmnents repo directory that
hosts your environments.

```text
repo_names = [
  "repo",
]

template_repo_enabled = {
  "repo" : false
}
```
