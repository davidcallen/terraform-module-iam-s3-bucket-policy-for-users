# terraform-module-iam-s3-bucket-policy-for-users

Terraform module for setting bucket access policy to restrict access to specific users (or  roles) only.

Note this is **NOT** a terraform module for generic bucket access policy. Such modules often tend to offer minimal advantage than just using standard terraform resources directly. 

The policy could support quite a large number of usages. Currently this is limited to :
    Deny access except for allowed Users/Roles (based on their "user_ids").
    
Use terraform data item "aws_iam_role" such as :
    
    data "aws_iam_role" "admin-role" {
      name = "admin-role"
    }
    data "aws_iam_role" "OrganizationAccountAccessRole" {
      name = "OrganizationAccountAccessRole"
    }     

or to get Users in a IAM group :

    data "aws_iam_group" "admin-group" {
      group_name = "Admins"
    }    
   
Note: a User or Role "user_id" can also be checked by using :

    $ aws-vault exec prpl-backbone -- aws iam get-user --user-name david.allen
    
    $ aws-vault exec prpl-dev -- aws iam get-role --role-name OrganizationAccountAccessRole
    

In the bucket policy we use Condition "StringNotLike" "aws:userId as detailed here : 
    https://aws.amazon.com/blogs/security/how-to-restrict-amazon-s3-bucket-access-to-a-specific-iam-role/
