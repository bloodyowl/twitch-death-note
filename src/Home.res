let killable = Belt.Set.String.fromArray([
  "darth vader",
  "bowser",
  "dolores umbridge",
  "gerald darmanin",
  "thanos",
])

let getImageUrl = killableName => {
  Router.makeHref(
    "/assets/images/" ++
    killableName->String.toLowerCase->String.replaceRegExp(%re("/\s+/"), "_") ++ ".png",
  )
}

module ActualApp = {
  module Styles = {
    open Emotion
    let container = css({
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "stretch",
      "flexGrow": 1,
    })
    let written = css({
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "flexGrow": 1,
      "height": 1,
      "overflowY": "auto",
    })
    let image = css({
      "width": "200px",
      "height": "auto",
    })
    let input = css({
      "position": "sticky",
      "bottom": 0,
      "width": "100%",
      "boxSizing": "border-box",
      "border": "none",
      "padding": 10,
      "borderTop": "3px solid #000",
      "fontSize": "inherit",
      "fontFamily": "inherit",
    })
    let killableContainer = css({
      "position": "relative",
      "width": "200px",
      "minHeight": "200px",
      "display": "flex",
      "alignItems": "center",
      "justifyContent": "center",
      "textAlign": "center",
    })
    let fadeAndScaleAnimation = keyframes({
      "from": {
        "transform": "scale(1.05)",
        "opacity": 0,
      },
    })
    let skullUrl = Router.makeHref("/assets/images/skull.png")
    let skull = css({
      "position": "absolute",
      "top": 0,
      "left": 0,
      "right": 0,
      "bottom": 0,
      "backgroundColor": "rgba(255, 255, 255, 0.3)",
      "backgroundImage": `url("${skullUrl}")`,
      "backgroundRepeat": "no-repeat",
      "backgroundPosition": "50% 50%",
      "backgroundSize": "contain",
      "animation": `300ms ease-in-out ${fadeAndScaleAnimation}`,
    })
  }

  external elementAsObject: Dom.element => {..} = "%identity"

  @react.component
  let make = () => {
    let (input, setInput) = React.useState(() => "")
    let (scheduledKills, setScheduledKills) = React.useState(() => [])
    let (effectivelyKilled, setEffectivelyKilled) = React.useState(() => Belt.Set.String.empty)
    let scrollViewRef = React.useRef(Nullable.null)

    React.useEffect1(() => {
      switch scrollViewRef.current->Nullable.toOption {
      | Some(scrollView) =>
        let scrollView = scrollView->elementAsObject
        scrollView["scrollTop"] = scrollView["scrollHeight"]
      | None => ()
      }
      None
    }, [scheduledKills])

    <div className=Styles.container>
      <div className=Styles.written ref={ReactDOM.Ref.domRef(scrollViewRef)}>
        {scheduledKills
        ->Array.mapWithIndex((scheduledKill, index) => {
          <div key={index->Int.toString} className=Styles.killableContainer>
            {if killable->Belt.Set.String.has(scheduledKill) {
              <img src={getImageUrl(scheduledKill)} alt=scheduledKill className=Styles.image />
            } else {
              <div> {scheduledKill->React.string} </div>
            }}
            {effectivelyKilled->Belt.Set.String.has(scheduledKill)
              ? <div className=Styles.skull />
              : React.null}
          </div>
        })
        ->React.array}
      </div>
      <input
        type_="text"
        className=Styles.input
        value=input
        placeholder={"Enter someone to kill"}
        onChange={event => {
          let target = event->ReactEvent.Form.target
          let value = target["value"]
          setInput(_ => value)
        }}
        onKeyDown={event => {
          if event->ReactEvent.Keyboard.key === "Enter" {
            setInput(_ => "")
            let normalizedInput = input->String.trim->String.toLowerCase
            setScheduledKills(scheduledKills =>
              scheduledKills->Array.concat([
                killable->Belt.Set.String.has(normalizedInput)
                  ? normalizedInput
                  : input->String.trim,
              ])
            )
            if scheduledKills->Array.length >= 2 {
              let notDeadYet =
                scheduledKills->Array.filter(scheduledKill =>
                  !(effectivelyKilled->Belt.Set.String.has(scheduledKill))
                )
              let randomIndex =
                Math.floor(Math.random() *. notDeadYet->Array.length->Int.toFloat)->Float.toInt
              setEffectivelyKilled(effectivelyKilled => {
                switch notDeadYet[randomIndex] {
                | None => effectivelyKilled
                | Some(toKillNext) => effectivelyKilled->Belt.Set.String.add(toKillNext)
                }
              })
            }
          }
        }}
      />
    </div>
  }
}

module Book = {
  module Styles = {
    open Emotion
    let fadeAndScaleAnimation = keyframes({
      "from": {
        "transform": "scale(1.05)",
        "opacity": 0,
      },
    })
    let root = css({
      "display": "flex",
      "flexGrow": 1,
      "alignSelf": "stretch",
      "alignItems": "center",
      "justifyContent": "center",
      "opacity": 1,
      "transform": "scale(1)",
      "animation": `300ms ease-in-out ${fadeAndScaleAnimation} backwards`,
    })
    let centerAnimation = keyframes({
      "from": {
        "transform": "translateX(0)",
      },
    })
    let container = css({
      "width": "30%",
      "position": "relative",
      "perspective": "1000px",
      "transform": "translateX(50%)",
      "animation": `300ms ease-in-out ${centerAnimation} 1000ms backwards`,
    })
    let coverOpenAnimation = keyframes({
      "from": {
        "transform": "rotateY(0)",
      },
    })
    let deathNoteImageUrl = Router.makeHref("/assets/images/death_note.png")
    let cover = css({
      "width": "100%",
      "paddingBottom": "144.99411072%",
      "backgroundImage": `url("${deathNoteImageUrl}")`,
      "backgroundColor": "#000",
      "backgroundSize": "cover",
      "position": "absolute",
      "top": 0,
      "left": 0,
      "transformOrigin": "0 0",
      "transformStyle": "preserve-3d",
      "backfaceVisibility": "hidden",
      "transform": "rotateY(-180deg)",
      "animation": `300ms ease-in-out ${coverOpenAnimation} 1000ms backwards`,
    })
    let coverBack = css({
      "position": "absolute",
      "top": 0,
      "left": 0,
      "right": 0,
      "bottom": 0,
      "backgroundColor": "#000",
      "transformStyle": "preserve-3d",
      "backfaceVisibility": "hidden",
      "transform": "rotateY(180deg)",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "justifyContent": "flex-end",
      "padding": "10px",
    })
    let sticker = css({
      "opacity": 0.6,
      "backgroundColor": "#fff",
      "padding": "10px",
      "color": "#000",
      "fontSize": "12px",
      "position": "relative",
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "textAlign": "center",
    })
    let barCode = css({
      "width": "100px",
      "height": "auto",
    })
    let inside = css({
      "paddingBottom": "144.99411072%",
      "position": "relative",
    })
    let insideContents = css({
      "position": "absolute",
      "top": 0,
      "left": 0,
      "right": 0,
      "bottom": 0,
      "boxShadow": "inset 0 0 0 4px #000",
      "padding": 4,
      "backgroundColor": "#FFF",
      "display": "flex",
      "flexDirection": "column",
    })
  }
  let barCodeUrl = Router.makeHref("/assets/images/barcode.png")
  @react.component
  let make = () => {
    <div className=Styles.root>
      <div className=Styles.container>
        <div className=Styles.inside>
          <div className=Styles.insideContents> <ActualApp /> </div>
        </div>
        <div className=Styles.cover>
          <div className=Styles.coverBack>
            <div className=Styles.sticker>
              {`Propriété du CDI`->React.string}
              <br />
              {`Collège Cyril Hanouna`->React.string}
              <Spacer height="5px" />
              <img className=Styles.barCode src={barCodeUrl} width="422" height="77" alt="" />
            </div>
          </div>
        </div>
      </div>
    </div>
  }
}

module Styles = {
  open Emotion
  let woodUrl = Router.makeHref("/assets/images/wood.jpg")

  let container = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
    "flexGrow": 1,
    "backgroundImage": `url("${woodUrl}")`,
    "backgroundColor": "#B99579",
    "backgroundSize": "cover",
    "backgroundPosition": "50% 50%",
  })
}

@react.component
let make = () => {
  <>
    <Head> <title> {"Welcome"->React.string} </title> </Head>
    <div className=Styles.container> <Book /> </div>
  </>
}
