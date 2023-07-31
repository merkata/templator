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
