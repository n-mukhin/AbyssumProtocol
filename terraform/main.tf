provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

resource "yandex_compute_instance" "web" {
  name               = "tonecheck"
  platform_id        = "standard-v1"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = var.yc_image_id
    }
  }
  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }
}

output "web_public_ip" {
  value = yandex_compute_instance.web.network_interface.0.nat_ip_address
}
