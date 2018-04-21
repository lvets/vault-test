module "planets" {
  source = "modules/org-policies"

  org = "planets"

  spaces = [
    "earth",
    "jupiter",
    "mars",
  ]
}

module "stars" {
  source = "modules/org-policies"

  org = "stars"

  spaces = [
    "algol",
    "sirius",
    "sun",
  ]
}
