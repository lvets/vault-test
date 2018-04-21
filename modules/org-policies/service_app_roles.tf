resource "vault_generic_secret" "service-approle" {
  count = "${length(var.spaces) * length(keys(var.services))}"
  path  = "${var.approle-mount}/role/${element(vault_policy.service-policy.*.name, count.index)}"

  # need this so that the vault provider isn't confused by the additional fields returned by the approle API
  # the downside of this is that if any manual changes are made to vault, terraform won't notice
  disable_read = true

  data_json = <<EOT
{
  "secret_id_ttl": 0,
  "secret_id_num_uses": 0,
  "period": "24h",
  "token_max_ttl": 0,
  "policies": [
    "default",
    "${vault_policy.service-policy.*.name[count.index]}"
  ]
}
EOT
}
