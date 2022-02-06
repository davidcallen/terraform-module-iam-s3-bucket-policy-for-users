variable "bucket_name" {
  type = string
  default = ""
}
variable "sub_policies" {
  type = list(object({
    description                 = string
    actions                     = list(string)
    bucket_paths                = list(string)
    allowed_user_ids            = list(string)
  }))
  default = [
    {
      description               = ""
      actions                   = []
      bucket_paths              = []
      allowed_user_ids          = []
    }]
}
variable "root_account_id" {
  type = string
  default = ""
}
variable "global_default_tags" {
  description = "Global default tags"
  default = {}
  type = map(string)
}