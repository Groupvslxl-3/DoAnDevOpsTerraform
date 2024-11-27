<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_Nat_Gateway"></a> [Nat\_Gateway](#module\_Nat\_Gateway) | ./modules/Nat_Gateway | n/a |
| <a name="module_Route_Tables"></a> [Route\_Tables](#module\_Route\_Tables) | ./modules/Route_Tables | n/a |
| <a name="module_Security_Groups"></a> [Security\_Groups](#module\_Security\_Groups) | ./modules/Security_Group | n/a |
| <a name="module_VPC"></a> [VPC](#module\_VPC) | ./modules/VPC | n/a |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ./modules/ec2 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.nhom15](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID for EC2 instances | `string` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones | `list(string)` | n/a | yes |
| <a name="input_id_ed25519_pub"></a> [id\_ed25519\_pub](#input\_id\_ed25519\_pub) | Public key for SSH access | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for EC2 instances | `string` | n/a | yes |
| <a name="input_my_ip"></a> [my\_ip](#input\_my\_ip) | Your IP address | `string` | n/a | yes |
| <a name="input_private_instance_count"></a> [private\_instance\_count](#input\_private\_instance\_count) | Number of private EC2 instances | `number` | n/a | yes |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | CIDR blocks for private subnets | `list(string)` | n/a | yes |
| <a name="input_public_instance_count"></a> [public\_instance\_count](#input\_public\_instance\_count) | Number of public EC2 instances | `number` | n/a | yes |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | CIDR blocks for public subnets | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | n/a |
| <a name="output_private_instance_ips"></a> [private\_instance\_ips](#output\_private\_instance\_ips) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | n/a |
| <a name="output_public_instance_ips"></a> [public\_instance\_ips](#output\_public\_instance\_ips) | n/a |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |

## Usage
1. **Cài đặt Terraform**: Cài đặt Terraform từ trang chủ Terraform.
2. **Cấu hình AWS Credentials**: Cài đặt AWS CLI và sử dụng lệnh ```aws configure``` để thêm accesskey và secretkey giúp terraform có thể thực hiện các dịch vụ
3. **Clone Github Project và chạy code Terraform**:
  ```
  git clone https://github.com/pokilee10/NT548.P11.MMCL/tree/main
  cd NT548.P11.MMCL/Lab1/terraform/
  ```
4. **Chạy code Terraform**:
   1. Thực hiện chỉnh sửa các biến nếu cần thiết trong file ``terraform.tfvars``
   2. Khởi tạo Terraform Project
      ```
      terraform init
      ```
   3. Kiểm tra các tài nguyên mà Terraform sẽ tạo trước khi triển khai
      ```
      terraform plan
      ```
   4. Triển khai lên AWS
      ```
      terraform apply -auto-approve
      ```
   5. Dọn dẹp tài nguyên
      ```
      terraform destroy -auto-approve
      ```
<!-- END_TF_DOCS -->