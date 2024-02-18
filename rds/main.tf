provider "aws" {
    region = "eu-west-2"
}

resource "aws_db_instance" "rds_test" {
    db_name = "test_db"
    identifier = "test-rds"
    instance_class = "db.t3.micro"
    engine = "mariadb"
    engine_version = "10.11.6"
    username = "test"
    password = "verysecureone"
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true
}