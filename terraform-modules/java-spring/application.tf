module "application" {
    source = "../sandbox-application"
    application_name = "java-spring"
    ami = "ami-f90a4880"
    instance_type = "t2.nano"
    user_data = file("${path.module}/startup_script.sh")
    application_port = 8080
    expose = true
    
    subnets = var.subnets
    ec2_key = var.ec2_key
    default_sandbox_security_group = var.default_sandbox_security_group
    vpc = var.vpc
}