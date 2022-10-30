module Base = {
  @react.component
  let make = (~children: React.element, ~onClick, ~onMouseDown=?, ~isActive: bool) => {
    let defaultClassnames = " flex items-center justify-center p-1 tracking-wide font-bold border-r border-b text-xl cursor-pointer hover:bg-gray-100 py-6"

    let classnames = defaultClassnames

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
      onMouseDown={_ => Belt.Option.map(onMouseDown, fn => fn)->ignore}
      onClick={onClick}
      className="min-w-[8rem] button-transition px-6 py-2 bg-accent tracking-widest font-bold text-current border-dark border-4 text-lg cursor-pointer">
      {children}
    </button>
  }
}
