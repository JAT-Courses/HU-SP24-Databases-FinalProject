import Sidebar from "@/components/Sidebar"
import ChartArea from "@/components/ChartArea"

import { getQ1_Part2, getQ1_Part1 } from "@/api/data"
import mysql2 from "mysql2/promise"
import { redirect } from "next/navigation"
import { NextResponse } from "next/server"

export default async function Page() {
  function handleSubmit() {}
  let Q1 = <></>

  // @ts-ignore
  const [rows, fields]: [mysql2.QueryResult, mysql2.FieldPacket[]] =
    await getQ1_Part1("")

  let dataPart1: any[] = []

  if (rows.length == 0) {
    return (
      <>
        <div className="flex">
          <Sidebar />
          <main className="flex-grow ml-64 relative">
            <form
              name="yearEntry"
              className="w-full max-w-sm"
              onSubmit={handleSubmit()}
            >
              <div className="flex items-center border-b border-teal-500 py-2">
                <input
                  className="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
                  type="text"
                  placeholder="Year"
                  aria-label="Enter a year"
                  required
                  name="year"
                />
                <input type="submit" value="submit" />
              </div>
            </form>
          </main>
        </div>
      </>
    )
  }

  // @ts-ignore
  rows.forEach((row) => {
    let newRow = { month: row[0], avg: row[1] }
    dataPart1.push(newRow)
  })

  //console.log(dataPart1)

  // @ts-ignore
  const [rows_part2, fields_part2]: [mysql2.QueryResult, mysql2.FieldPacket[]] =
    await getQ1_Part2()

  let dataPart2: any[] = []

  // @ts-ignore
  rows_part2.forEach((row) => {
    let newRow = { month: row[0], count: row[1] }
    dataPart2.push(newRow)
  })

  //console.log(dataPart2)

  return (
    <>
      <div className="flex">
        <Sidebar />
        <main className="flex-grow ml-64 relative">
          <form className="w-full max-w-sm">
            <div className="flex items-center border-b border-teal-500 py-2">
              <input
                className="appearance-none bg-transparent border-none w-full text-gray-700 mr-3 py-1 px-2 leading-tight focus:outline-none"
                type="text"
                placeholder="Jane Doe"
                aria-label="Full name"
              />
              <button
                className="flex-shrink-0 bg-teal-500 hover:bg-teal-700 border-teal-500 hover:border-teal-700 text-sm border-4 text-white py-1 px-2 rounded"
                type="button"
              >
                Sign Up
              </button>
              <button
                className="flex-shrink-0 border-transparent border-4 text-teal-500 hover:text-teal-800 text-sm py-1 px-2 rounded"
                type="button"
              >
                Cancel
              </button>
            </div>
          </form>
          <ChartArea
            graphOneData={dataPart1}
            graphOneX={"month"}
            graphOneY={"avg"}
            graphOneType={"line"}
            graphTwoData={dataPart2}
            graphTwoX={"month"}
            graphTwoY={"count"}
            graphTwoType={"line"}
          />
        </main>
      </div>
    </>
  )
}

Page.getInitialProps = async ({ query }) => {
  // Access query parameters from query object
  const { year } = query
  // Fetch data based on query parameters
  // Return data as props
  return { year }
}
