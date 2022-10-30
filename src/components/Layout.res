@react.component
let make = (~children: React.element) => {
  <div className="flex flex-grow relative w-screen flex-col h-screen"> {children} </div>
}
