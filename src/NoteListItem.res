@react.component
let make = (~onClick, ~note, ~isActive) => {
  let classNames =
    "p-2 flex items-center justify-center w-full cursor-pointer select-none font-medium" ++ (
      isActive ? " bg-light bg-opacity-40 text-dark" : "text-accent font-medium"
    )

  <button onClick={onClick} className=classNames> {note->React.string} </button>
}
