locals {
  github_organization = csvdecode(file("data-files/organization.csv"))
  github_organization_members = csvdecode(file("data-files/organization-members.csv"))
  github_teams = csvdecode(file("data-files/teams.csv"))
  github_team_members = {
    for file in fileset("data-files/team-members", "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("data-files/team-members/${file}"))
  }
  github_team_repositories = {
    for file in fileset("data-files/team-repos", "*.csv") :
    trimsuffix(file, ".csv") => csvdecode(file("data-files/team-repos/${file}"))
  }
}

module "github" {
  source = "git::https://github.com/adajou/terraform-module.git"
  github_organization              = local.github_organization
  github_organization_members      = local.github_organization_members
  github_teams                     = local.github_teams
  github_team_members              = local.github_team_members 
  github_team_repositories    = local.github_team_repositories
}
