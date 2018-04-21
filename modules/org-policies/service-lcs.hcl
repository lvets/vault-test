
path "secret/orca/v1/lcs/*" {
    capabilities = ["read", "create", "update", "delete"]
}
path "pki/lcs/issue/lcs" {
    capabilities = ["create", "update"]
}
