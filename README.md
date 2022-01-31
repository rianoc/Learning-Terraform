# Learning-Terraform

Code for <https://www.linkedin.com/learning/learning-terraform-2>

* [Learning-Terraform](#learning-terraform)
  * [Notes](#notes)
    * [Error: NoCredentialProviders](#error-nocredentialproviders)
    * [Error: Too many command line arguments](#error-too-many-command-line-arguments)
    * [Error: "availability_zones": conflicts with vpc_zone_identifier](#error-availability_zones-conflicts-with-vpc_zone_identifier)
    * [Unable to view website in later sections](#unable-to-view-website-in-later-sections)
    * [Search fails on https://registry.terraform.io/](#search-fails-on-httpsregistryterraformio)

## Notes

### Error: NoCredentialProviders

```bash
Error: error configuring Terraform AWS Provider: no valid credential sources for Terraform AWS Provider found.
│ Please see https://registry.terraform.io/providers/hashicorp/aws
│ for more information about providing credentials.
```

Resolved by correcting typo in `credentias` file. <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html>

### Error: Too many command line arguments

```bash
terraform plan -destroy -out=example.plan
```

Resolved by removing `.` in file name

```bash
terraform plan -destroy -out=example
```

### Error: "availability_zones": conflicts with vpc_zone_identifier

Needed to delete `availability_zones` line

```tf
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
```

### Unable to view website in later sections

Issue looks to be lack of `vpc_security_group_ids` in the `aws_launch_template` meant they did not open up any ports.

Needed:

```tf
  vpc_security_group_ids = var.security_groups
```

### Search fails on https://registry.terraform.io/

The website search is very poor - use google instead.
