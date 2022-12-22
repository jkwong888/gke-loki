resource "google_logging_project_exclusion" "exclude_node_serial_port" {
  name = "exclude_node_serial_port"
  project = module.service_project.project_id

  description = "Exclude GKE serial port logs"

  # Exclude all DEBUG or lower severity messages relating to instances
  filter = format("logName =~ \"projects/%s/logs/serialconsole.googleapis.com%%2Fserial_port_*\"", module.service_project.project_id)
}
