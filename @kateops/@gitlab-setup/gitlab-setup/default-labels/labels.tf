resource "gitlab_group_label" "in_progress" {
  color = "#ed9121"
  group = var.group_id
  name  = "In Progress"
  description = "When the ticket is currently being worked on"
}

resource "gitlab_group_label" "quality_assurance" {
  color = "#330066"
  group = var.group_id
  name  = "QA"
  description = "When the ticket is being reviewed"
}

resource "gitlab_group_label" "ready" {
  color = "#00b140"
  group = var.group_id
  name  = "Ready"
  description = "When ready for development"
}

resource "gitlab_group_label" "ready_for_deployment" {
  color = "#ff0000"
  group = var.group_id
  name  = "Ready for Deployment"
  description = "When a ticket needs a deployment which takes longer or has to wait"
}

resource "gitlab_group_label" "wait_for_qa" {
  color = "#9400d3"
  group = var.group_id
  name  = "Wait for QA"
  description = "After the ticket is done being worked on and ready for review"
}


resource "gitlab_group_label" "version_patch" {
  color = "#36454f"
  group = var.group_id
  name  = "version::patch"
  description = "patch version increase"
}
resource "gitlab_group_label" "version_minor" {
  color = "#8080af"
  group = var.group_id
  name  = "version::minor"
  description = "minor version increase"
}
resource "gitlab_group_label" "version_major" {
  color = "#808090"
  group = var.group_id
  name  = "version::major"
  description = "major version increase"
}