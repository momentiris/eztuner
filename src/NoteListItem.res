@react.component
let make = (~onClick, ~note, ~isActive) => {
  let classNames =
    "p-1 h-full flex items-center justify-center w-full cursor-pointer select-none font-medium border-r border-b" ++ (
      isActive ? " bg-green-100" : " font-medium md:hover:bg-green-50"
    )

  <button onClick={onClick} className=classNames> {note->React.string} </button>
}
