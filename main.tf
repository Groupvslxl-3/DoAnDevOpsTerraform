provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate)
  token                  = module.eks.eks_cluster_auth
}

module "VPC" {
  source               = "./modules/VPC"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "Route_Tables" {
  source              = "./modules/Route_Tables"
  vpc_id              = module.VPC.vpc_id
  public_subnet_ids   = module.VPC.public_subnet_ids
  private_subnet_ids  = module.VPC.private_subnet_ids
  internet_gateway_id = module.VPC.internet_gateway_id
  nat_gateway_ids     = module.Nat_Gateway.nat_gateway_ids
}


module "Nat_Gateway" {
  source            = "./modules/Nat_Gateway"
  public_subnet_ids = module.VPC.public_subnet_ids
}

# module "ec2" {
#   source                 = "./modules/ec2"
#   ami_id                 = var.ami_id
#   instance_type          = var.instance_type
#   public_subnet_ids      = module.VPC.public_subnet_ids
#   private_subnet_ids     = module.VPC.private_subnet_ids
#   public_sg_id           = module.Security_Groups.public_sg_id
#   private_sg_id          = module.Security_Groups.private_sg_id
#   //key_name               = aws_key_pair.nhom15.key_name
#   public_instance_count  = var.public_instance_count
#   private_instance_count = var.private_instance_count
#   key_name               = var.key_name
# }

module "Security_Groups" {
  source = "./modules/Security_Group"
  vpc_id = module.VPC.vpc_id
  my_ip  = var.my_ip
}

# resource "aws_key_pair" "nhom15" {
#   key_name   = "Nhom15"
#   public_key = var.id_ed25519_pub
# }

module "keypair" {
  source             = "./modules/keypair"
  key_name           = var.key_name
  create_private_key = true
}

resource "local_file" "private_key" {
  content         = module.keypair.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0600"
}

module "iam" {
  source = "./modules/iam"
  eks_cluster_role_name = var.eks_cluster_role_name
  worker_node_role_name = var.worker_node_role_name
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_group_role_arn = module.iam.eks_worker_node_role_arn
  public_subnet_ids = module.VPC.public_subnet_ids
  private_subnet_ids = module.VPC.private_subnet_ids
  public_node_group_name = var.public_node_group_name
  private_node_group_name = var.private_node_group_name
  instance_types = var.instance_types
  key_name = var.key_name
  depends_on = [ module.iam, module.VPC ]
}

module "kubernetes" {
  source = "./modules/kubernetes"
  user_name = var.iam_user_name
  depends_on = [ module.eks ]
}