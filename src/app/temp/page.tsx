import mysql from "mysql2"
import { databaseCredentials } from "@/config/databaseCredentials"

try {
  const databaseConnection = mysql.createConnection(databaseCredentials)

  console.log("Connected to DB successfully!")

  databaseConnection.end()
} catch (err) {
  //console.error("Connection to DB failed: ", err)
}
