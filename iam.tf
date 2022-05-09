resource "aws_iam_role" "testRole" {
    name = "sample-role"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
}
EOF
}

resource "aws_iam_policy" "testPolicy" {
    name        = "sample-policy"
    description = "A test policy"

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": [
        "ec2:Describe*"
        ],
        "Effect": "Allow",
        "Resource": "*"
    }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
    role       = aws_iam_role.testRole.name
    policy_arn = aws_iam_policy.testPolicy.arn
}
    

resource "aws_iam_instance_profile" "test_profile" {
    name = "test_profile"
    role = "${aws_iam_role.testRole.name}"
}