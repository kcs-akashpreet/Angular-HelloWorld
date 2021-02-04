resource "azurerm_resource_group" "appservice-rg" {
  name     = "kcs-${var.region}-${var.environment}-${var.app_name}-app-service-rg"
  location = var.location

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

# Create the App Service Plan
resource "azurerm_app_service_plan" "service-plan" {
  name                = "kcs-${var.region}-${var.environment}-${var.app_name}-service-plan"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  kind                = "Windows"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}

# Create the App Service
resource "azurerm_app_service" "app-service" {
  name                = "kcs-${var.region}-${var.environment}-${var.app_name}-app-service"
  location            = azurerm_resource_group.appservice-rg.location
  resource_group_name = azurerm_resource_group.appservice-rg.name
  app_service_plan_id = azurerm_app_service_plan.service-plan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }

  tags = {
    description = var.description
    environment = var.environment
    owner       = var.owner  
  }
}
