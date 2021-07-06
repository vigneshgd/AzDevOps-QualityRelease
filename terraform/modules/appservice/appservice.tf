resource "azurerm_app_service_plan" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  sku {
    tier = "${var.sku_tier}"
    size = "${var.sku_size}"
  }
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }  
}

resource "azurerm_app_service" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  app_service_plan_id = azurerm_app_service_plan.test.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = 0
  }
  tags = {
    tier        = "${var.tier}"
    deployment  = "${var.deployment}"
  }
}