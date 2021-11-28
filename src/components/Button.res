module Base = {
  @react.component
  let make = (~children: React.element, ~onClick, ~onMouseDown=() => (), ~isActive: bool) => {
    let defaultClassnames = "rounded-md flex items-center justify-center p-1 active:button--scale origin-center tracking-wide font-bold border-dark border-4 text-xl w-full cursor-pointer"

    let classnames =
      defaultClassnames ++
      " " ++
      switch isActive {
      | true => "bg-light text-dark"
      | _ => "bg-accent text-light"
      }

    let handleMouseDown = () => {
      onMouseDown()
    }

    // let animations = React.useMemo1(_ =>
    //   switch isActive {
    //   | false => React.null
    //   | _ =>
    //     Belt.Array.range(0, 5)
    //     ->Belt.Array.mapWithIndex((_, index) =>
    //       <div
    //         key={Belt.Int.toString(index)}
    //         className="bar bg-gray-500"
    //         style={ReactDOM.Style.make(
    //           ~animationDuration=Js.Math.random_int(350, 500)->Belt.Int.toString ++ "ms",
    //           ~height=Js.Math.random_int(3, 6)->Belt.Int.toString ++ "px",
    //           (),
    //         )}
    //       />
    //     )
    //     ->React.array
    //   }
    // , [isActive])

    <button onMouseDown={_ => handleMouseDown()} onClick={onClick} className=classnames>
      <div
        className={"bars z-0 transition-opacity" ++
        " " ++
        switch isActive {
        | false => "opacity-0"
        | _ => "opacity-100"
        }}
      />
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
