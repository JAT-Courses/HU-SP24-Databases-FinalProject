import { getQ1 } from "@/api/data"

// `app/dashboard/page.tsx` is the UI for the `/dashboard` URL
export default async function Page() {
  const Q1result = await getQ1()

  return <h1>Hello, Dashboard Page!</h1>
}
