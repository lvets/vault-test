resource "vault_policy" "operator-policy" {
  name = "${var.org}"

  policy = <<EOF
# Full ownership of everything in the org
path "secret/infra/cf/${var.org}"{
  capabilities = ["list"]
}
path "secret/infra/cf/${var.org}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow the policy to read its own policy
path "sys/policy/${var.org}" {
  capabilities = ["read"]
}

# Allow to create child tokens
path "auth/token/create" {
  capabilities = ["update"]
}

path "auth/approle/role/${var.org}-*" {
  capabilities = ["read"]
}

# generate tokens via approles
${join("\n",data.template_file.operator-approle-policy.*.rendered)}
EOF
}

data "template_file" "operator-approle-policy" {
  count = "${length(var.spaces) * length(keys(var.services))}"

  template = <<EOF
path "auth/approle/role/$${org}-$${space}-$${service}/secret-id" {
  capabilities = ["create", "update"]
}
path "auth/approle/role/$${org}-$${space}-$${service}/secret-id-accessor/lookup" {
  capabilities = ["create", "update"]
}
EOF

  vars {
    service = "${element(keys(var.services), count.index)}"
    space   = "${element(var.spaces, count.index / length(keys(var.services)))}"
    org     = "${var.org}"
  }
}
