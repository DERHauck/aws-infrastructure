
# shellcheck disable=SC2046
export $(cat ".env") &> /dev/null
cd "${PWD}" || exit 1

# shellcheck disable=SC2046
export $(cat ".env") &> /dev/null
terraform init \
  -backend-config="region=eu-central-1" \
  -backend-config="access_key=${TF_VAR_aws_access_key}" \
  -backend-config="secret_key=${TF_VAR_aws_secret_key}" \
  -backend-config="bucket=382168771427-terraform-state" \
  -backend-config="key=aws/states/${TF_STATE_NAME}/terraform.tfstate"
