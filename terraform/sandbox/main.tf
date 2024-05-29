module "ResourceGroup" {
  source              = "../modules/ResourceGroup/"
  resource_group_name = "hono-bun-sandbox"
}

module "CodeEngine" {
  source               = "../modules/CodeEngine/"
  resource_group_id    = module.ResourceGroup.resource_group_id
  ibmcloud_api_key     = var.ibmcloud_api_key
  project_name         = "hono-bun-sandbox-ce-project"
  application_name     = "hono-bun-sandbox-ce-app"
  registry_secret_name = "hono-bun-cr-secret"
  registry_region      = "private.icr.io"
  registry_namespace   = ""
  registry_image       = ""
  depends_on           = [module.ResourceGroup]
}
