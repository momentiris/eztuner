module Base = {
  @react.component
  let make = (
    ~children: React.element,
    ~onClick,
    ~onMouseDown=() => (),
    ~buttonState: State.Button.Note.t,
  ) => {
    let defaultClassnames = "py-2 relative animation--soundwave active:button--scale origin-center select-none transition-transform-colors duration-150 tracking-widest px-6 font-bold border-dark border-4 text-xl w-full cursor-pointer"
    let activeClassnames = ""

    let classnames =
      defaultClassnames ++
      " " ++
      switch buttonState {
      | Active => activeClassnames ++ " " ++ "bg-accentlight text-dark"
      | Inactive => activeClassnames ++ " " ++ "bg-accent text-accentlight"
      }

    let handleMouseDown = () => {
      onMouseDown()
    }

    let animations = React.useMemo1(_ =>
      switch buttonState {
      | Inactive => React.null
      | Active =>
        Belt.Array.range(0, 25)
        ->Belt.Array.mapWithIndex((_, index) =>
          <div
            key={Belt.Int.toString(index)}
            className="bar bg-main"
            style={ReactDOM.Style.make(
              ~animationDuration=Js.Math.random_int(350, 500)->Belt.Int.toString ++ "ms",
              ~height=Js.Math.random_int(3, 6)->Belt.Int.toString ++ "px",
              (),
            )}
          />
        )
        ->React.array
      }
    , [buttonState])

    <button onMouseDown={_ => handleMouseDown()} onClick={onClick} className=classnames>
      <div className="bars z-0"> {animations} </div>
      <span className="relative z-10"> {children} </span>
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
