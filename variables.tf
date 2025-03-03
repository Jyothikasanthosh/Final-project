variable "client_id" {
  description = "The Client ID of the Service Principal"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret of the Service Principal"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Tenant ID of the Azure AD"
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}
