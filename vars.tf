variable "COMPONENT" {}
variable "APP_VERSION" {}
variable "ENV" {}
variable "PRIVATE_SUBNET_ID" {}
variable "AGS_DESIRED" {}
variable "AGS_MAX" {}
variable "AGS_MIN" {}
variable "PROMETHEUS_IP" {}
variable "WORKSTATION_IP" {}
variable "PRIVATE_SUBNET_CIDR" {}
variable "SSH_PORT" {}
variable "PORT" {}
variable "INSTANCE_TYPE" {}
variable "VPC_ID" {}
variable "PRIVATE_LISTENER_ARN" {}
variable "LB_ARN" {}
variable "LB_TYPE" {}
variable "PRIVATE_HOSTED_ZONE_ID" {}
variable "PRIVATE_LB_DNS_NAME" {}
variable "PROJECT" {}
variable "DOCDB_ENDPOINT" {
  default = "null"
}
variable "REDIS_ENDPOINT" {
  default = "null"
}
variable "RDS_ENDPOINT" {
  default = "null"
}