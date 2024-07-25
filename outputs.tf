output "db_instance_endpoint" { 
value = aws_db_instance.labyrinth-db.endpoint 
} 

output "db_instance_port" { 
value = aws_db_instance.labyrinth-db.port 
} 

output "db_instance_name" { 
value = aws_db_instance.labyrinth-db.db_name 
} 

output "db_instance_username" { 
value = aws_db_instance.labyrinth-db.username 
}
