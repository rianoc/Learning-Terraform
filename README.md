# Learning-Terraform

Code for <https://www.linkedin.com/learning/learning-terraform-2>

## Notes

### NoCredentialProviders

```bash
Error: error configuring Terraform AWS Provider: no valid credential sources for Terraform AWS Provider found.
│ Please see https://registry.terraform.io/providers/hashicorp/aws
│ for more information about providing credentials.
```

Resolved by correcting typo in `credentias` file. <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html>

### Too many command line arguments

```bash
terraform plan -destroy -out=example.plan
```

Resolved by removing `.` in file name

```bash
terraform plan -destroy -out=example
```
