"use client"

import AreaChartPlot from "@/components/AreaChartPlot"

interface Props {
  data: []
  x: string
  y: string
}

const Charts = (props: Props) => {
  return (
    <>
      <section className="flex my-4 px-4 gap-3">
        <div className="w-1/2 h-[300px] bg-gray-700 rounded">
          <AreaChartPlot data={props.data} x={props.x} y={props.y} />
        </div>
        <div className="w-1/2 h-[300px] bg-gray-700 rounded"></div>
      </section>
    </>
  )
}

export default Charts
