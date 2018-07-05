resource "aws_ssm_document" "install_cloudwatch_agent" {
  name          = "install_cloudwatch_agent"
  document_type = "Command"

  content = <<DOC
{
  "schemaVersion": "2.2",
  "description": "Installs and configures CloudWatch Agent on a Windows Instance using existing AWS SSM documents.",
  "parameters": {
    "applications": {
      "type": "String",
      "default": "Enabled",
      "description": "(Optional) Collect data for installed applications.",
      "allowedValues": [
        "Enabled",
        "Disabled"
      ]
    },
    "cloudwatchconfigssmparametername": {
      "type": "String",
      "description": "Name of the ssm parameter to use for CloudWatch agent configuration"
    }
  },
  "mainSteps": [
    {
      "action": "aws:runDocument",
      "name": "configureCloudWatchAgent",
      "inputs": {
        "documentType": "SSMDocument",
        "documentPath": "AWS-ConfigureAWSPackage",
        "documentParameters": "{\"action\":\"Install\",\"name\": \"AmazonCloudWatchAgent\"}"
      }
    },
    {
      "action": "aws:runDocument",
      "name": "installPowerShellModule",
      "inputs": {
        "documentType": "SSMDocument",
        "documentPath": "AmazonCloudWatch-ManageAgent",
        "documentParameters": "{\"action\":\"configure\",\"optionalConfigurationSource\":\"ssm\",\"optionalConfigurationLocation\":\"{{ cloudwatchconfigssmparametername }}\",\"optionalRestart\":\"yes\"}"
      }
    },
    {
      "action": "aws:softwareInventory",
      "name": "collectSoftwareInventoryItems",
      "inputs": {
        "applications": "{{ applications }}"
      }
    }
  ]
}
DOC
}
