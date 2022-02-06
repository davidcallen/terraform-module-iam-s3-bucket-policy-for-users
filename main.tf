# ---------------------------------------------------------------------------------------------------------------------
# IAM set bucket policy to restrict access to bucket to a list of allowed Users or Roles.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = var.bucket_name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for sub_policy in var.sub_policies :
      {
        Sid       = sub_policy.description
        Effect    = "Deny"
        Principal = "*"
        Action = [
          for action in sub_policy.actions : action
        ]
        Resource = [
          for bucket_path in sub_policy.bucket_paths : "arn:aws:s3:::${var.bucket_name}${bucket_path}"
        ]
        Condition = {
          StringNotLike = {
            "aws:userId" = concat(sub_policy.allowed_user_ids[*], [var.root_account_id])
          }
        }
      }
    ]
  })
}
