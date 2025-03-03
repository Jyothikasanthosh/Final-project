# Data source to get details about the subscription
data "azurerm_subscription" "current" {

}

# Define the custom Azure Policy Definition

resource "azurerm_policy_definition" "only_deploy_in_west_europe" {
  name         = "only-deploy-in-west-europe"
  policy_type  = "Custom"
  display_name = "Only Deploy in West Europe"
  description  = "This policy ensures that resources can only be deployed in the West Europe region."
  mode         = "All"
  
  metadata = <<METADATA
    {
      "version": "1.0.0",
      "category": "Location"
    }
  METADATA

  policy_rule = <<POLICY_RULE
  {
    "if": {
      "not": {
        "field": "location",
        "equals": "westeurope"
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
  POLICY_RULE
}

# Define the Policy Assignment to assign the policy to a subscription

# Define the Policy Assignment to assign the policy to a subscription
resource "azurerm_subscription_policy_assignment" "assign_only_deploy_in_west_europe" {
  name                 = "only-deploy-in-west-europe-assignment"
  policy_definition_id = azurerm_policy_definition.only_deploy_in_west_europe.id
  subscription_id      = data.azurerm_subscription.current.id
}

