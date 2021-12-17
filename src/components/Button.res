module Base = {
  @react.component
  let make = (~children: React.element, ~onClick, ~onMouseDown=?, ~isActive: bool) => {
    let defaultClassnames = "rounded-md flex items-center justify-center px-2 py-1 tracking-wide font-bold border-dark border-4 text-xl w-full cursor-pointer"

    let classnames =
      defaultClassnames ++
      " " ++
      switch isActive {
      | true => "bg-light text-dark"
      | _ => "bg-accent text-light"
      }

    <button
      onMouseDown={_ => Belt.Option.map(onMouseDown, fn => fn)->ignore}
      onClick={onClick}
      className=classnames>
      {children}
    </button>
  }
}

module PlayNote = {
  @react.component
  let make = (~children: React.element, ~onClick) => {
    <button
      onClick={onClick}
      className="button-transition tracking-widest px-6 py-2 bg-accent font-bold text-accentlight border-dark border-4 text-lg w-full cursor-pointer">
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
      className="min-w-[8rem] button-transition px-6 py-2 bg-accent tracking-widest font-bold text-current border-dark border-4 text-lg cursor-pointer">
      {children}
    </button>
  }
}
