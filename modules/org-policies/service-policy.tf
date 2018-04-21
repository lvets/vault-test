resource "vault_policy" "service-policy" {
  count = "${length(var.spaces) * length(keys(var.services))}"
  name  = "${var.org}-${element(var.spaces, count.index / length(keys(var.services)))}-${element(keys(var.services), count.index)}"

  policy = "${lookup(var.services,element(keys(var.services), count.index)) != "base-service-policy.hcl" ? element(data.template_file.base-service-policy.*.rendered, count.index) : ""}${element(data.template_file.service-policy.*.rendered, count.index)}"
}

data "template_file" "service-policy" {
  count    = "${length(var.spaces) * length(keys(var.services))}"
  template = "${file("${path.module}/${lookup(var.services,element(keys(var.services), count.index))}")}"

  vars {
    service = "${element(keys(var.services), count.index)}"
    space   = "${element(var.spaces, count.index / length(keys(var.services)))}"
    org     = "${var.org}"
  }
}

data "template_file" "base-service-policy" {
  count    = "${length(var.spaces) * length(keys(var.services))}"
  template = "${file("${path.module}/base-service-policy.hcl")}"

  vars {
    service = "${element(keys(var.services), count.index)}"
    space   = "${element(var.spaces, count.index / length(keys(var.services)))}"
    org     = "${var.org}"
  }
}
