"use client"

import LineChartPlot from "@/components/LineChartPlot"
import mysql2 from "mysql2/promise"
import { getQ1_Part1 } from "@/api/data"

interface Props {
  graphOneX: string
  graphOneY: string
  graphOneType: string
  graphTwoX: string
  graphTwoY: string
  graphTwoType: string
}

const ChartArea = (props: Props) => {
  let ChartOne = <></>
  let ChartTwo = <></>

  if (props.graphOneType === "line") {
    ChartOne = (
      <LineChartPlot
        data={props.graphOneData}
        x={props.graphOneX}
        y={props.graphOneY}
      />
    )
  } else if (props.graphOneType === "bar") {
  }

  if (props.graphTwoType === "line") {
    ChartTwo = (
      <LineChartPlot
        data={props.graphTwoData}
        x={props.graphTwoX}
        y={props.graphTwoY}
      />
    )
  } else if (props.graphTwoType === "bar") {
  }

  return (
    <>
      <section className="flex my-4 px-4 gap-3">
        <div className="w-1/2 h-[300px] bg-gray-700 rounded">{ChartOne}</div>
        <div className="w-1/2 h-[300px] bg-gray-700 rounded">{ChartTwo}</div>
      </section>
    </>
  )
}

export default ChartArea
