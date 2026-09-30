output "blue" {
  value = "htpp://${aws_elastic_beanstalk_environment.blue.cname}"
}

output "green" {
  value = "http://${aws_elastic_beanstalk_environment.green.cname}"
}