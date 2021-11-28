@react.component
let make = (~onClick, ~note, ~isActive) => {
  let classNames =
    "p-2 flex items-center justify-center w-full cursor-pointer select-none font-medium" ++ (
      isActive ? " bg-gray-200 text-dark" : "text-accent font-medium md:hover:bg-gray-100"
    )

  <button onClick={onClick} className=classNames> {note->React.string} </button>
}
