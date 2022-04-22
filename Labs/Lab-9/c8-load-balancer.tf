#public ip for azure load balancer

resource "azurerm_public_ip" "web-lb-publicip" {
  name = "lbpublicip"
  resource_group_name = azurerm_resource_group.myrg.name
  location = azurerm_resource_group.myrg.location
  allocation_method = "Static"
  sku = "Standard"
  tags = {
    "environment" = "Dev"
  }
}

#azure load balancer

resource "azurerm_lb" "weblb" {
    name = "web-lb"
    location = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
    sku = "Standard"

    frontend_ip_configuration {
      name="web-lb-publicip-config"
      public_ip_address_id = azurerm_public_ip.web-lb-publicip.id
    }
  
}


#Create LB beckend Pool
resource "azurerm_lb_backend_address_pool" "web-lb-backed-address-pool" {
    name = "web-beckend-lb"
  loadbalancer_id = azurerm_lb.weblb.id
}


#create LB Rule
resource "azurerm_lb_rule" "web-lb-rule" {
  name = "web-lb-rule"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.weblb.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web-lb-backed-address-pool.id]
  loadbalancer_id = azurerm_lb.weblb.id
  probe_id = azurerm_lb_probe.web-lb-probe.id
}

#create LB probe
resource "azurerm_lb_probe" "web-lb-probe" {
  name = "tcp-probe"
  protocol = "Tcp"
  port = 80
  loadbalancer_id = azurerm_lb.weblb.id
}