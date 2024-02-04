variable "region" {
  description = "aws region"
  default = "ap-northeast-2"  
}

variable "profile" {
  description = "aws config profile"
  default = "shd"
}

variable "environment" {
  description = ""
  default = "shd"  
}

variable "project" {
  description = "project name"
  default = "test"  
}

############ developer ################
variable "dev_user_names" {
  description = "Developer user names for IAM"
  type        = list(string)
  default     = [
    "sch6328@bithumbmeta.io",
    "jhahn@bithumbmeta.io" ]

}

variable "dev_group_user" {
  description = "Developer user for IAM"
  type        = list(string)
  default     = [
    "sch6328@bithumbmeta.io",
    "jhahn@bithumbmeta.io",
    "sh.bae@bithumbmeta.io",
    "ji.you@bithumbmeta.io",
    "kyk4334@bithumbmeta.io",
    "pjhnocegood@bithumbmeta.io" 
    ]

}



############ infra ################
variable "infra_user_names" {
  description = "infra user list for IAM"
  type        = list(string)
  default     = [""]
}

variable "infra_group_user" {
  description = "infra user for IAM"
  type        = list(string)
  default     = [
    "lhb0209@bithumbmeta.io",
    "jaemmani@bithumbmeta.io"
    ]

}

variable "infra_enabled"{
  description = "creat user for infra"
  type        = bool
  default     = false
 }   

############ Security ################

variable "secu_user_names" {
  description = "Security user names for IAM"
  type        = list(string)
  default     = [""]
}

variable "secu_group_user" {
  description = "security user for IAM"
  type        = list(string)
  default     = [
    "jongoh.park@bithumbmeta.io",
    "breezy@bithumbmeta.io"
    ]

}
variable "secu_enabled"{
  description = "creat user for security"
  type        = bool
  default     = false
 } 


############ qa ################

variable "qa_user_names" {
  description = "Security user names for IAM"
  type        = set(string)
  default     = [""]
}

variable "qa_group_user" {
  description = "qa user for IAM"
  type        = list(string)
  default     = [
      "woosang@bithumbmeta.io"
    ]

}
variable "qa_enabled"{
  description = "creat user for qa"
  type        = bool
  default     = false
 } 

############ architectures ################

variable "architect_user_names" {
  description = "architect user names for IAM"
  type        = set(string)
  default     = [""]
}

variable "architect_group_user" {
  description = "architect user for IAM"
  type        = list(string)
  default     = [
      "hsm3394@bithumbmeta.io",
      "point455@bithumbmeta.io",
      "smhan@bithumbmeta.io"
    ]

}
variable "architect_enabled"{
  description = "creat user for architect"
  type        = bool
  default     = false
 } 





