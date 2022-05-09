##Declare variables##
variable "awsaccesskey" {
type = string
default = "AKIAQLM2FCFLNDABFY4N"
}
variable "awssecretkey" {
type = string
default = "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"
}
variable "ami" {
    type = string
    default = "ami-0661cd3308ec33aaa"
}
variable "key_pair" {
    type = string
    default = "bation"
}
variable "mysystem"{
    type = string
    default = "103.215.224.190/32"
}
