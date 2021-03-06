# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "topic" {
  description = "(Required) The topic to apply the IAM role to."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "role" {
  description = "(Optional) The role that should be applied. Note that custom roles must be of the format '[projects|organizations]/{parent-name}/roles/{role-name}'."
  type        = string
  default     = null
}

variable "project" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "members" {
  type        = set(string)
  description = "(Optional) Identities that will be granted the privilege in role. Each entry can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'user:{emailid}', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}', 'projectOwner:projectid', 'projectEditor:projectid', 'projectViewer:projectid', 'computed:*'."
  default     = []

  validation {
    condition     = alltrue([for member in var.members : can(regex("^(?:allUsers|allAuthenticatedUsers|(?:user|serviceAccount|group|domain|projectOwner|projectEditor|projectViewer|computed):.*)$", member))])
    error_message = "Each member in 'var.members' can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'user:{emailid}', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}', 'projectOwner:projectid', 'projectEditor:projectid', 'projectViewer:projectid', 'computed:*'."
  }
}

variable "computed_members_map" {
  type        = map(string)
  description = "(Optional) A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values."
  default     = {}

  validation {
    condition     = alltrue([for key, value in var.computed_members_map : can(regex("^(?:allUsers|allAuthenticatedUsers|(?:user|serviceAccount|group|domain|projectOwner|projectEditor|projectViewer):.*)$", value))])
    error_message = "Each member can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'user:{emailid}', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}', 'projectOwner:projectid', 'projectEditor:projectid', 'projectViewer:projectid'."
  }
}

variable "policy_bindings" {
  description = "(Optional) A list of IAM policy bindings."
  type        = any
  default     = null
}

variable "authoritative" {
  description = "(Optional) Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role."
  type        = bool
  default     = true
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on."
  default     = []
}
