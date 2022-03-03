resource "null_resource" "execute-file-script" {
  count = var.env == "prod" ? 3 : 1
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nag-tokyo.pem")
      #host = $(aws_instance.web-1.public_ip)
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }

  provisioner "remote-exec" { # once the file is copied to location then we need to excecute it for that we use this##
    inline = [
      "sudo chmod 777 /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
    connection { # To execute the script we need the user so for that this one##
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nag-tokyo.pem")
      #host = $(aws_instance.web-1.public_ip)
      host = element(aws_instance.public-servers.*.public_ip, count.index)
    }
  }
  provisioner "local-exec" {
    command = <<EOH
      del public_server_details_1.txt
      del public_server_details_2.txt
        echo "${element(aws_instance.public-servers.*.public_ip, count.index)}" >> public_server_details_1.txt && echo "${element(aws_instance.public-servers.*.private_ip, count.index)}" >> public_server_details_2.txt,
      EOH
  }
}  