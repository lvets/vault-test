
path "secret/infra/cf/${org}/${space}/${service}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
