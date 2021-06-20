variable "name" {
  description = "IAM user name"
  type        = string
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "tags" {
  description = "A map of tags to add to IAM role resources"
  type        = map(string)
  default     = {}
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}
