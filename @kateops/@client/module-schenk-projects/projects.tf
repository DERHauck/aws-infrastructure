module "movie-database" {
  source = "./../../../module/gitlab/project"
  name = "Movie Database"
  visibility = "internal"
  group_id = var.group_id
}