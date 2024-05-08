import mysql2 from "mysql2/promise"
import { databaseCredentials } from "@/config/databaseCredentials"

export async function getQ1_Part1(year: string) {
  try {
    const databasePool = mysql2.createPool(databaseCredentials)

    const databaseConnection = await databasePool.getConnection()

    console.log("Connected to DB successfully!")

    const sql =
      "select MONTH(measurementDate) as month, avg(GSE_WSE) as averageGWL from groundWaterMeasurements where YEAR(measurementDate) = ? group by MONTH(measurementDate) order by month asc"
    const values = [year]

    // @ts-ignore
    const [rows, fields] = await databaseConnection.execute({
      sql,
      values,
      rowsAsArray: true,
    })

    databaseConnection.release()

    //console.log(rows)

    return [rows, fields]
  } catch (err) {
    //console.error("Connection to DB failed: ", err)
  }
}

export async function getQ1_Part2() {
  try {
    const databasePool = mysql2.createPool(databaseCredentials)

    const databaseConnection = await databasePool.getConnection()

    console.log("Connected to DB successfully!")

    const [rows, fields] = await databaseConnection.query({
      sql:
        'select MONTH(STR_TO_DATE(alarmDate, "%m/%d/%Y")) as month, count(*) from wildfires\n' +
        "\tinner join wildfireCauses as wfc using (causeId)\n" +
        '\twhere (year = 2000 and MONTH(STR_TO_DATE(alarmDate, "%m/%d/%Y")) is not null)  and (causeId = 1 or causeId = 5 or causeId = 9 or causeId = 14 or causeId = 17)\n' +
        "  group by month\n" +
        "  order by month asc",
      rowsAsArray: true,
    })

    databaseConnection.release()

    //console.log(rows)

    return [rows, fields]
  } catch (err) {
    //console.error("Connection to DB failed: ", err)
  }
}
