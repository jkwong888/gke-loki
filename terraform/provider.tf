terraform {
  backend "gcs" {
    bucket  = "jkwng-altostrat-com-tf-state"
    prefix = "jkwng-gke-log-filter-dev"
  }

  required_providers {
    google = {
      version = "~> 4.24.0"
    }
    google-beta = {
      version = "~> 4.24.0"

    }
    null = {
      version = "~> 2.1"
    }
    random = {
      version = "~> 2.2"
    }
  }
}

provider "google" {
#  credentials = file(local.credentials_file_path)
}

provider "google-beta" {
#  credentials = file(local.credentials_file_path)
}

provider "null" {
}

provider "random" {
}
