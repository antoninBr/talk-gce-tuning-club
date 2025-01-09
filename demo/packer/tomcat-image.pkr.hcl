variable "project_id" {
  default = ""
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

source "googlecompute" "tomcat-builder" {
  project_id           = var.project_id
  source_image         = "debian-11-bullseye-v20230911" # Image de base
  source_image_family  = "debian-11"
  source_image_project = "debian-cloud"
  machine_type         = "e2-micro"
  region               = var.region
  zone                 = var.zone
}

build {
  name    = "tomcat-gce-image"
  sources = ["source.googlecompute.tomcat-builder"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk wget",
      "wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz",
      "sudo tar -xzf apache-tomcat-9.0.80.tar.gz -C /opt/",
      "sudo mv /opt/apache-tomcat-9.0.80 /opt/tomcat",
      "sudo chmod +x /opt/tomcat/bin/*.sh",
      "sudo bash -c 'cat > /etc/systemd/system/tomcat.service <<EOF\n[Unit]\nDescription=Apache Tomcat\nAfter=network.target\n\n[Service]\nType=forking\nEnvironment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64\nEnvironment=CATALINA_HOME=/opt/tomcat\nExecStart=/opt/tomcat/bin/startup.sh\nExecStop=/opt/tomcat/bin/shutdown.sh\nUser=root\nGroup=root\nRestart=always\n\n[Install]\nWantedBy=multi-user.target\nEOF'",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable tomcat",
      "sudo systemctl start tomcat",
    ]
  }
}
