import { getQ1 } from "@/api/data"
import ColumnChart from "@/components/ColumnChart"

// `app/dashboard/page.tsx` is the UI for the `/dashboard` URL
export default async function Page() {
  const Q1result = await getQ1()

  return (
    <div>
      <h1>My Data Visualization</h1>
      <ColumnChart />
    </div>
  )
}
