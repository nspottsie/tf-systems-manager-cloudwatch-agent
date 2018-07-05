resource "aws_ssm_parameter" "cloudwatch_agent_config_windows" {
  name  = "CloudWatch_Agent_Config_Windows"
  type  = "String"
  value = <<EOF
{
  "metrics": {
    "metrics_collected": {
      "LogicalDisk": {
        "measurement": ["% Free Space"],
        "metrics_collection_interval": 60,
        "resources": ["*"]
      },
      "Memory": {
        "measurement": ["% Committed Bytes In Use"],
        "metrics_collection_interval": 60
      },
      "Paging File": {
        "measurement": ["% Usage"],
        "metrics_collection_interval": 60,
        "resources": ["*"]
      },
      "PhysicalDisk": {
        "measurement": ["% Disk Time"],
        "metrics_collection_interval": 60,
        "resources": ["*"]
      },
      "Processor": {
        "measurement": ["% User Time","% Idle Time","% Interrupt Time"],
        "metrics_collection_interval": 60,
        "resources": ["_Total"]
      }
    }
  }
}
EOF
}
