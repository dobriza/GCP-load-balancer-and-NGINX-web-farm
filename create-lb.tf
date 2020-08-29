resource "google_compute_instance_group" "webservers" {
  name        = "terraform-webservers-dobriza"
  description = "Dobriza`s Terraform test instance group"

  instances = [
    google_compute_instance.web_private_1.id,
    google_compute_instance.web_private_2.id,
  ]

  named_port {
    name = "http"
    port = "80"
  }

  zone = "europe-west1-b"
}

# determine whether instances are responsive and able to do work
resource "google_compute_health_check" "healthcheck" {
  name               = "webservers-dobriza-healthcheck"
  timeout_sec        = 1
  check_interval_sec = 1
  http_health_check {
    port = 80
  }
}

# defines a group of virtual machines that will serve traffic for load balancing
resource "google_compute_backend_service" "backend_service" {
  name          = "backend-webservers-dobriza"
  port_name     = "http"
  protocol      = "HTTP"
  health_checks = ["${google_compute_health_check.healthcheck.self_link}"]
  backend {
    group                 = google_compute_instance_group.webservers.self_link
    balancing_mode        = "RATE"
    max_rate_per_instance = 100
  }
}

# used to route requests to a backend service based on rules that you define for the host and path of an incoming URL
resource "google_compute_url_map" "url_map" {
  name            = "webservers-dobriza-load-balancer"
  default_service = google_compute_backend_service.backend_service.self_link
}



# used by one or more global forwarding rule to route incoming HTTP requests to a URL map
resource "google_compute_target_http_proxy" "target_http_proxy" {
  name    = "webservers-dobriza-proxy"
  url_map = google_compute_url_map.url_map.self_link
}



resource "google_compute_global_forwarding_rule" "global_forwarding_rule" {
  name       = "webservers-dobriza-global-forwarding-rule"
  target     = google_compute_target_http_proxy.target_http_proxy.self_link
  port_range = "80"
}


# show external ip address of load balancer
output "load-balancer-ip-address" {
  value = google_compute_global_forwarding_rule.global_forwarding_rule.ip_address
}












