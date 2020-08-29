# Create Google Cloud VMs | vm.tf

# Create web server #1
resource "google_compute_instance" "web_private_1" {
  name         = "vm60"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  tags         = ["dobriza", "ops23"]

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20200714"
    }
  }

  metadata_startup_script = "sudo apt-get update"

  metadata = {
    sshKeys = "dobriza:${file("ops23.pub")}"
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

# Create web server #2
resource "google_compute_instance" "web_private_2" {
  name         = "vm61"
  machine_type = "f1-micro"
  zone         = var.gcp_zone_1
  tags         = ["dobriza", "ops23"]

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20200714"
    }
  }

  metadata_startup_script = "sudo apt-get update"

  metadata = {
    sshKeys = "dobriza:${file("ops23.pub")}"
  }


  network_interface {
    network = "default"
    access_config {
    }
  }
}

