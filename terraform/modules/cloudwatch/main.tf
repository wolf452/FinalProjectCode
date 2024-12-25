resource "aws_ssm_parameter" "cloudwatch_config" {
  name  = var.cloudwatch_config_ssm_key
  type  = "String"
  value = jsonencode({
    agent = {
      metrics_collection_interval = 60
    },
    logs = {
      logs_collected = {
        files = {
          collect_list = [
            {
              file_path      = "/var/log/messages"
              log_group_name = var.log_group_name
              log_stream_name = var.log_stream_name
            }
          ]
        }
      }
    }
  })
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = var.log_group_name
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
