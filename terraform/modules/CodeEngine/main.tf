resource "ibm_code_engine_project" "code_engine_project_instance" {
  name              = var.project_name
  resource_group_id = var.resource_group_id
}

resource "ibm_code_engine_app" "code_engine_app_instance" {
  project_id          = ibm_code_engine_project.code_engine_project_instance.project_id
  name                = var.application_name
  image_reference     = "${var.registry_region}/${var.registry_namespace}/${var.registry_image}"
  image_secret        = var.registry_secret_name
  image_port          = 3000
  scale_cpu_limit     = "0.25"
  scale_memory_limit  = "1G"
  scale_min_instances = 0
  scale_max_instances = 1
  depends_on = [
    ibm_code_engine_project.code_engine_project_instance,
    ibm_code_engine_secret.code_engine_secret_instance
  ]
}

resource "ibm_code_engine_secret" "code_engine_secret_instance" {
  project_id = ibm_code_engine_project.code_engine_project_instance.project_id
  name       = var.registry_secret_name
  format     = "registry"

  data = {
    username = "iamapikey"
    password = var.ibmcloud_api_key
    server   = var.registry_region
  }
}
