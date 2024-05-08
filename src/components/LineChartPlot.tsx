import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
  LineChart,
  Line,
  Legend,
} from "recharts"

interface Props {
  data: []
  x: string
  y: string
}

const LineChartPlot = (props: Props) => {
  return (
    <>
      <ResponsiveContainer width="100%" height="100%">
        <LineChart
          width={730}
          height={250}
          data={props.data}
          margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
        >
          <defs>
            <linearGradient id="colorUv" x1="0" y1="0" x2="0" y2="1">
              <stop offset="5%" stopColor="#8884d8" stopOpacity={0.8} />
              <stop offset="95%" stopColor="#8884d8" stopOpacity={0} />
            </linearGradient>
          </defs>
          <XAxis dataKey={props.x} />
          <YAxis dataKey={props.y} />
          <Tooltip />
          <Line
            type="monotone"
            dataKey={props.y}
            stroke="#82ca9d"
            activeDot={{ r: 8 }}
          />
          <CartesianGrid strokeDasharray="3 3" />
          <Legend />
          <Tooltip />
        </LineChart>
      </ResponsiveContainer>
    </>
  )
}
export default LineChartPlot
