terraform {
  backend "local" {
    path = "/home/coder/.local/share/code-server/User/<terraform_state_file>.state"
  }
}
