@react.component
let make = (~onClick) => {
  <ul className="currentColor">
    <li onClick={_ => RescriptReactRouter.push("/")->onClick}> {"Basic"->React.string} </li>
    <li onClick={_ => RescriptReactRouter.push("/free")->onClick}> {"Free"->React.string} </li>
  </ul>
}
