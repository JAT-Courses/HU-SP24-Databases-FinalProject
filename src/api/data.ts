import mysql2 from "mysql2/promise"
import { databaseCredentials } from "@/config/databaseCredentials"

export async function getQ1() {
  try {
    const databasePool = mysql2.createPool(databaseCredentials)

    const databaseConnection = await databasePool.getConnection()

    console.log("Connected to DB successfully!")

    const [rows, fields] = await databaseConnection.query({
      sql: "select MONTH(measurementDate) as month, avg(GSE_WSE) as averageGWL from groundWaterMeasurements where YEAR(measurementDate) = 2000 group by MONTH(measurementDate) order by month asc",
      rowsAsArray: true,
    })

    databaseConnection.release()

    return rows
  } catch (err) {
    //console.error("Connection to DB failed: ", err)
  }
}
