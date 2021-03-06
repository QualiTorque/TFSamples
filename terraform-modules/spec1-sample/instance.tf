resource "aws_instance" "javaspringwebsite" {
ami = "ami-f90a4880"
instance_type = "t2.nano"
key_name = aws_key_pair.key.key_name
network_interface {
  network_interface_id = aws_network_interface.javaspringwebsiteNic.id
  device_index = 0
}

  tags = {"Key": "Name","Value": "java-spring-website"}
	user_data = tostring(file("java-spring-website.sh"))
}