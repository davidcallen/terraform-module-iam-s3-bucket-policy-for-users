# terraform-module-iam-s3-bucket-policy-for-users

Terraform module for setting bucket access policy to restrict access to specific users (or  roles) only.

Note this is **NOT** a terraform module for generic bucket access policy. Such modules often tend to offer minimal advantage than just using standard terraform resources directly. 

The policy could support quite a large number of usages. Currently this is limited to :
    Deny access except for allowed Users/Roles (based on their "user_ids").    

In the bucket policy we use Condition "StringNotLike" "aws:userId as detailed here : 
    https://aws.amazon.com/blogs/security/how-to-restrict-amazon-s3-bucket-access-to-a-specific-iam-role/
