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

### "availability_zones": conflicts with vpc_zone_identifier

Needed to delete `availability_zones` line

```tf
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
```
