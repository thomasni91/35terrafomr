variable "prefix" {
  description = "Prefix for all the ecs resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "3"
}

variable "availability_zones" {
  description = "the region configured in the provider"
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "uat"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3001
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "public.ecr.aws/u6c9w9i8/express:latest" // 35middle
  # default     = "public.ecr.aws/u6c9w9i8/learner:latest" // quick learner
  # default     = "public.ecr.aws/nginx/nginx:1-alpine-perl" // nginx
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "myEcsTaskExecutionRole"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/"
}

variable "ecr_image_name" {
  description = "Unique name of the ECR image name"
  type        = string

}