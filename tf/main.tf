terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
#Specifies Kubernetes version
provider "kubernetes" {
  config_path = "~/.kube/config"
}
#Specifies Kubernetes config location
resource "kubernetes_namespace" "vcitas" {
  metadata {
    name = "pythonapp"
  }
}
#Deploys kubernetes namespace
resource "kubernetes_deployment" "vcitas" {
  metadata {
    name      = "pythonapp"
    namespace = kubernetes_namespace.vcitas.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "App"
      }
    }
    template {
      metadata {
        labels = {
          app = "App"
        }
      }
      spec {
        container {
          image = "app"
          name  = "python_app_cont"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
#Deploys single app container that listens on port 80 and uses specified namespace
resource "kubernetes_service" "vcitas" {
  metadata {
    name      = "pythonapp"
    namespace = kubernetes_namespace.vcitas.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.vcitas.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 80
      port        = 80
      target_port = 80
    }
  }
}
#Creates Service that will listen on port 80 and move incoming messages to container. Uses namespace aswell
