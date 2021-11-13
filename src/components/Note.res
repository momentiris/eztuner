@react.component
let make = (~active, ~note, ~nodeRef) => {
  <div
    className={`flex text-lg tracking-widest w-note snap-center items-center font-bold justify-center flex-shrink-0 my-2 py-4 border-r border-dashed border-gray-400 select-none ${active
        ? "text-accentlight"
        : "text-accent"}`}
    id={note}
    ref={nodeRef}>
    {note->React.string}
  </div>
}
