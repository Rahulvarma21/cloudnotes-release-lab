# Local backend only — no remote state, no credentials, ₹0 cost.
# The actual state file path is supplied per-environment via
# `-backend-config=envs/<env>/backend.hcl` at init time, keeping each
# environment's state isolated. See terraform/envs/*/backend.hcl.
terraform {
  backend "local" {}
}
