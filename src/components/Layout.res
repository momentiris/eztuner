@react.component
let make = (~children: React.element) => {
  <div className="flex flex-grow relative w-full"> <Navbar /> {children} </div>
}
