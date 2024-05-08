import Link from "next/link"

const Sidebar = () => {
  return (
    <>
      <aside className="fixed top-0 left-0 w-64 h-full">
        <div className="overflow-y-auto py-5 px-3 h-full bg-white border-r border-gray-200 dark:bg-gray-800 dark:border-gray-700">
          <ul className="space-y-2">
            <li>
              <Link
                href="/"
                className="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              >
                <span className="ml-3">Home</span>
              </Link>
            </li>
          </ul>
          <ul className="pt-5 mt-5 space-y-2 border-t border-gray-200 dark:border-gray-700">
            <li>
              <Link
                href="/Q1"
                className="flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group"
              >
                <span className="flex-1 ml-3 whitespace-nowrap">Q1</span>
              </Link>
            </li>
          </ul>
        </div>
      </aside>
    </>
  )
}

export default Sidebar
