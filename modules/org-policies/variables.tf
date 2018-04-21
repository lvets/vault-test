variable "org" {
  type = "string"
}

variable "spaces" {
  type        = "list"
  description = "The list of spaces to create service policies for."
}

variable "services" {
  type        = "map"
  description = "The list of services to create service policies for."

  # When adding specific policies, "base-service-policy.hcl" will still be
  # applied.
  default = {
    "router-service"        = "base-service-policy.hcl"
    "comments-service"      = "base-service-policy.hcl"
    "special"               = "service-special.hcl"
    "config-service"        = "base-service-policy.hcl"
    "lcs"                   = "service-lcs.hcl"
    "mds"                   = "base-service-policy.hcl"
    # "new-service"         = "base-service-policy.hcl"
  }
}

variable "approle-mount" {
  type        = "string"
  default     = "auth/approle"
  description = "The vault mount point of the approle auth method."
}
