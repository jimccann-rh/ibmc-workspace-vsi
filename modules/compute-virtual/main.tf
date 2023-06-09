locals {
  instance_flavor = var.local_disk == true ? "BL2_4X8X100" : "B1_2X4X25"
}



resource "ibm_compute_vm_instance" "instance" {
  hostname                 = var.name
  domain                   = var.domain_name
  os_reference_code        = var.os_reference_code
  datacenter               = var.datacenter
  network_speed            = var.network_speed
  hourly_billing           = true
  local_disk               = var.local_disk
  private_network_only     = true
  flavor_key_name          = local.instance_flavor
  user_metadata            = file("${path.module}/user-data.yml")
  private_vlan_id          = var.private_vlan
#  public_vlan_id           = var.public_vlan
  tags                     = var.tags
  dedicated_acct_host_only = false
#  ipv6_enabled             = true
  ssh_key_ids              = var.ssh_key_ids
  disks                    = [100]
  public_security_group_ids = var.psgids
#  post_install_script_uri = "${var.vm-post-install-script-uri}"
}
