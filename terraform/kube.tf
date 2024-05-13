# Provider configuration for Kubernetes
provider "kubernetes" {
   config_context_cluster = "minikube"
   config_path    = "~/.kube/config"
}

# Define Persistent Volume Claims
resource "kubernetes_persistent_volume_claim" "mysql_data" {
  metadata {
    name = "mysql-data"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# Define MySQL Deployment and Service
resource "kubernetes_deployment" "mysql" {
  metadata {
    name = "mysql-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }
      spec {
        container {
          name  = "mysql"
          image = "mansi22/backend"
          port {
            container_port = 3306
          }
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "password"
          }
          env {
            name  = "MYSQL_USER"
            value = "wpuser"
          }
          env {
            name  = "MYSQL_DATABASE"
            value = "wordpress"
          }
          env {
            name  = "MYSQL_PASSWORD"
            value = "wordpress"
          }
          
        }
      }
    }
  }
}

resource "kubernetes_service" "mysql" {
  metadata {
    name = "mysql-service"
  }
  spec {
    selector = {
      app = "mysql"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}


resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wordpress-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }
      spec {
        container {
          name  = "wordpress"
          image = "mansi22/frontend"
          port {
            container_port = 80
			host_port = 8080
          }
          env {
            name  = "WORDPRESS_DB_HOST"
            value = "mysql-service"
          }
          env {
            name  = "WORDPRESS_DB_NAME"
            value = "wordpress"
          }
          env {
            name  = "WORDPRESS_DB_USER"
            value = "wpuser"
          }
          env {
            name  = "WORDPRESS_DB_PASSWORD"
            value = "wordpress"
          }
          env {
            name  = "SITE_URL"
            value = "http://192.168.99.100:8080"
          }
          
        }
      }
    }
  }
}


resource "kubernetes_service" "wordpress" {
  metadata {
    name = "wordpress-service"
  }
  spec {
    selector = {
      app = "wordpress"
    }
    port {
      port        = 80
      target_port = 9080
    }
  }
}