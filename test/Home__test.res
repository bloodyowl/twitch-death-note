open ReactTest

testWithReact("Home renders", container => {
  act(() => ReactDOM.render(<Home />, container))

  Assert.elementContains(~message="Renders sticker", container, `Propriété du CDI`)
})
