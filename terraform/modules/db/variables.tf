variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Database disk image"
  default     = "reddit-db-base"
}
