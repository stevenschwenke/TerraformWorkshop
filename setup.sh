#!/usr/bin/env zsh

# Function: setup Terraform environment variables
# Description: Extracts the AWS access key and secret key for the specified profile from the ~/.aws/credentials file.
# Parameters:  none

is_sourced() {
  if [ -n "$ZSH_VERSION" ]; then
    case $ZSH_EVAL_CONTEXT in *:file:*) return 0 ;; esac
  else  # Add additional POSIX-compatible shell names here, if needed.
    case ${0##*/} in dash | -dash | bash | -bash | ksh | -ksh | sh | -sh) return 0 ;; esac
  fi
  return 1  # NOT sourced.
}

display_help() {
  printf "This will help you set the environment variables needed to run Terraform.\n\n"
  printf "-h   display help\n"
}

extract_aws_credentials() {

  shift $((OPTIND - 1))

  if is_sourced; then
    printf "\nSetting environment variables of AWS profile with name %s ...\n\n" "$1"

    local profile=$1
    local aws_access_key_id
    local aws_secret_access_key

    aws_access_key_id=$(sed -n -e "/^\[${profile}\]/,/^\[/ p" ~/.aws/credentials | grep 'aws_access_key_id' | awk -F' = ' '{print $2}' | tr -d '[:space:]')
    aws_secret_access_key=$(sed -n -e "/^\[${profile}\]/,/^\[/ p" ~/.aws/credentials | grep 'aws_secret_access_key' | awk -F' = ' '{print $2}' | tr -d '[:space:]')

    if [[ -z $aws_access_key_id ]] || [[ -z $aws_secret_access_key ]]; then
      echo "Error: Profile not found or credentials incomplete."
      return 1
    fi

    export TF_VAR_access_key=$aws_access_key_id
    export TF_VAR_secret_key=$aws_secret_access_key
    echo "The following environment variables for the profile '${profile}' have been set:"
    printenv | grep '^TF_VAR_'

  else
    printf "Please call this script source'd like this to make your changes permanent:\n"
    printf "source ./setup.sh\n"
    printf "Or like this:\n"
    printf ". ./setup.sh\n"
    printf "The environment was not changed.\n"
    exit 0
  fi

}

printf "This helps you set the credentials of a specific AWS profile as environment variables.\n"
printf "Your AWS profiles:\n\n"

# Store profile names in an array and display them with their indices
profile_names=($(awk '/\[/ { if (NR > 1) {gsub(/\[|\]/, ""); print}}' ~/.aws/credentials))
index=1
for profile in "${profile_names[@]}"; do
  printf "%d) %s\n" $index $profile
  index=$((index + 1))
done
printf "\n"

# Let the user enter the index of the profile they want to use
read "profile_index?Which of these profiles should be set as environment variables? (Enter the number) "

# Check if the entered index is valid
if [ "$profile_index" -gt 0 ] && [ "$profile_index" -le "${#profile_names[@]}" ]; then
  # Use the index to access the profile name from the array
  selected_profile="${profile_names[$profile_index]}"
  extract_aws_credentials "$selected_profile"
else
  printf "Invalid profile number. Exiting.\n"
  exit 1
fi