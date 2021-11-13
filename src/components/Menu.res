@react.component
let make = (~onClick) => {
  <ul className="currentColor font-semibold flex flex-col gap-4">
    <li
      className="cursor-pointer text-accent hover:text-dark"
      onClick={_ => RescriptReactRouter.push("/")->onClick}>
      {"Basic"->React.string}
    </li>
    <li
      className="cursor-pointer text-accent hover:text-dark"
      onClick={_ => RescriptReactRouter.push("/free")->onClick}>
      {"Free"->React.string}
    </li>
  </ul>
}
