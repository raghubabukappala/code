provider "aws" {
  access_key = "AKIA27BRXH7YDJNQO3U5"
  secret_key = "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"
  region     = "us-east-1"
}
#Creating security group,allow ssh and http
resource "aws_security_group" "test-terra-ssh-http" {
  name        = "test-terra-ssh-http"
  description = "allowing ssh and http traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#security group ends here.
#Cfreating instance
resource "aws_instance" "hello-terra" {
  ami             = "ami-0ed9277fb7eb570c9"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.test-terra-ssh-http.name}"]
  key_name        = "Navya"
  user_data       = <<-EOF
           #! /bin/bash
           sudo yum install httpd -y
           sudo systemctl start httpd
          sudo systemctl enable httpd
          echo "<h1> Sape test webserver by RAghu using terraform</h1>" >> /var/www/html/index.html
          EOF

  tags = {
    name = "Raghu_terra_ec2_Webserver"
  }
}
