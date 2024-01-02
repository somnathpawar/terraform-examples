resource "aws_sns_topic" "eb_env" {
  name = "eb-env-${var.environment_name}-config-updates"
}

resource "aws_sns_topic_subscription" "user_updates_eb_env" {
  topic_arn = aws_sns_topic.eb_env.arn
  protocol  = "email"
  endpoint  = "${var.eb_sns_user_email}"
}