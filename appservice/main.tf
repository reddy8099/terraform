"$schema" = "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#"

"contentVersion" = "1.0.0.0"

"parameters" "webappplaneazure7am" {
  "type" = "string"

  "metadata" = {
    "description" = "description"
  }
}

"parameters" "webappolauberuse000" {
  "type" = "string"

  "metadata" = {
    "description" = "description"
  }
}

"functions" = []

"variables" = {}

"resources" = {
  "name" = "[parameters('webappplaneazure7am')]"

  "type" = "Microsoft.Web/serverfarms"

  "apiVersion" = "2020-12-01"

  "location" = "[resourceGroup().location]"

  "sku" = {
    "name" = "F1"

    "capacity" = 1
  }

  "properties" = {
    "name" = "[parameters('webappplaneazure7am')]"
  }
}

"resources" = {
  "name" = "[parameters('webappolauberuse000')]"

  "type" = "Microsoft.Web/sites"

  "apiVersion" = "2020-12-01"

  "location" = "[resourceGroup().location]"

  "dependsOn" = ["[resourceId('Microsoft.Web/serverfarms', parameters('webappplaneazure7am'))]"]

  "properties" = {
    "name" = "[parameters('webappolauberuse000')]"

    "serverFarmId" = "[resourceId('Microsoft.Web/serverfarms', parameters('webappplaneazure7am'))]"
  }
}

"outputs" = {}