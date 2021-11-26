@react.component
let make = (~onClick, ~note, ~isActive) => {
  let classNames =
    "p-2 flex items-center justify-center w-full cursor-pointer select-none" ++ (
      isActive ? " bg-light bg-opacity-40" : ""
    )

  <button onClick={onClick} className=classNames> {note->React.string} </button>
}
