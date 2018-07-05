resource "aws_ssm_association" "configure_cloudwatch_agent_and_software_inventory" {
  name = "${aws_ssm_document.install_cloudwatch_agent.name}"

  targets {
    key    = "tag:Name"
    values = ["${aws_instance.windows_instance.tags.Name}"]
  }

  parameters {
    "applications" = "Enabled"
    "cloudwatchconfigssmparametername" = "${aws_ssm_parameter.cloudwatch_agent_config_windows.name}"
  }
}
