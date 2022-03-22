variable "tags" {
    type = map
}

variable "az1" {
    type = string
    default = "us-east-1a"
}

variable "az2" {
    type = string
    default = "us-east-1b"
}

variable "vpcBlockIP" {
    type = string
    default = "172.23.0.0/16"
}

variable "subnetPriv1BlockIP" {
    type = string
    default = "172.23.0.0/18"
}

variable "subnetPriv2BlockIP" {
    type = string
    default = "172.23.64.0/18"
}

variable "subnetPub1BlockIP" {
    type = string
    default = "172.23.128.0/18"
}

variable "subnetPub2BlockIP" {
    type = string
    default = "172.23.192.0/18"
}

variable "instanceType" {
    type = string
    default = "t3a.small"
}

variable "ebsSize" {
    type = string
    default = "30"
}
