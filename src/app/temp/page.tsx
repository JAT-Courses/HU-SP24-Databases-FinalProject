import mysql2 from "mysql2"
import { databaseCredentials } from "@/config/databaseCredentials"
// `app/dashboard/page.tsx` is the UI for the `/dashboard` URL
export default function Page() {
  try {
    const databaseConnection = mysql2.createPool(databaseCredentials)

    console.log("Connected to DB successfully!")

    databaseConnection.end()
  } catch (err) {
    //console.error("Connection to DB failed: ", err)
  }

  return <h1>Hello, Dashboard Page!</h1>
}
