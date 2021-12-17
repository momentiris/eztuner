@react.component
let make = (~onClick, ~note, ~isActive) => {
  let classNames =
    "p-1 flex items-center justify-center w-full cursor-pointer select-none font-medium rounded-lg shadow-md" ++ (
      isActive ? " bg-accent text-white" : " bg-light text-accent font-medium md:hover:bg-gray-100"
    )

  <button onClick={onClick} className=classNames> {note->React.string} </button>
}
