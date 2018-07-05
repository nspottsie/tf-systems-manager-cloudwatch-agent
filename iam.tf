resource "aws_iam_instance_profile" "systems_manager_profile" {
  name = "systems_manager_profile"
  role = "${aws_iam_role.systems_manager_role.name}"
}

resource "aws_iam_role" "systems_manager_role" {
  name = "systems_manager_role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "systems_manager_role_policy" {
  role = "${aws_iam_role.systems_manager_role.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy" "allow_ssm_parameter_store_cloudwatch_config_read_access" {
  name = "allow_ssm_parameter_store_cloudwatch_config_read_access"
  role = "${aws_iam_role.systems_manager_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "${aws_ssm_parameter.cloudwatch_agent_config_windows.arn}"
        }
    ]
}
EOF
}
