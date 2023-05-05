#!/usr/bin/env zsh

# Description: Removes every resource created in every sub-project and deletes every Terraform-file.
# Usage:       ./cleanup.sh
# Dependencies: none
#
# Examples:
#   ./cleanup.sh

clean() {

  local directory=$1

  printf "%s :\n\n" "$directory"
  cd "$directory" || exit 1

  printf "Destroying Terraform resources ..."
  terraform destroy -auto-approve

  printf "Removing Terraform files ...\n"
  rm -rf .terraform* 2>/dev/null
  rm terraform*

  printf "Done cleaning %s\n" "$directory"
  cd ..
}

clean 01-create-ec2
clean 02-referencing-resources
clean 03-output-variables
clean 04-modules
clean 05-practice-project