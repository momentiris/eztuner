module PlayNote = {
  @react.component
  let make = (~children: React.element, ~onClick) => {
    <button
      onClick={onClick}
      className="tracking-widest px-6 py-2 bg-accent font-bold text-accentlight border-dark border-4 text-lg w-full cursor-pointer">
      {children}
    </button>
  }
}

module Unmute = {
  @react.component
  let make = (~children: React.element, ~onClick, ~onMouseDown: option<unit => unit>=?) => {
    <button
      onMouseDown={_ =>
        switch onMouseDown {
        | Some(fn) => fn()
        | _ => ()
        }}
      onClick={onClick}
      className="px-6 py-2 bg-accent tracking-widest font-bold text-current border-dark border-4 text-lg w-full cursor-pointer">
      {children}
    </button>
  }
}
