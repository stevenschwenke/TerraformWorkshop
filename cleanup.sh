#!/usr/bin/env zsh

# Description: Removes every resource created in every sub-project and deletes every Terraform-file.
# Usage:       ./cleanup.sh
# Dependencies: none
#
# Examples:
#   ./cleanup.sh

clean() {

  local directory=$1

  printf "Cleaning %s ...\n" "$directory"
  cd "$directory" || exit 1


# Check if the directory contains a Terraform directory
  if [ ! -d .terraform ]; then
    printf "No Terraform file found, skipping.\n\n"
    cd ..
    return 0
  fi

  printf "Destroying Terraform resources ...\n"
  terraform destroy -auto-approve

  printf "Removing Terraform files ...\n"
  rm -rf .terraform* 2>/dev/null
  rm terraform*

  printf "Done cleaning %s.\n\n" "$directory"
  cd ..
}

clear

printf "This will clean up all Terraform files and resources.\n\n"

clean 01-create-ec2
clean 02-referencing-resources
clean 03-output-variables
clean 04-modules
clean 05-practice-project