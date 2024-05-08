"use client"

// components/ColumnChart.js
import React, { Component } from "react"
import CanvasJSReact from "@canvasjs/react-charts"

var CanvasJSChart = CanvasJSReact.CanvasJSChart

class App extends Component {
  render() {
    const options = {
      theme: "light1", // "light2", "dark1", "dark2"
      animationEnabled: true,
      title: {
        text: "Basic Column Chart in Next.js",
      },
      data: [
        {
          type: "column",
          dataPoints: [
            { label: "apple", y: 10 },
            { label: "orange", y: 15 },
            { label: "banana", y: 25 },
            { label: "mango", y: 30 },
            { label: "grape", y: 28 },
          ],
        },
      ],
    }
    const containerProps = {
      width: "80%",
      height: "360px",
      margin: "auto",
    }
    return (
      <div>
        <CanvasJSChart
          options={options}
          containerProps={containerProps}
          onRef={(ref) => (this.chart = ref)}
        />
      </div>
    )
  }
}

export default App
