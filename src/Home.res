module ActualApp = {
  @react.component
  let make = () => {
    <div> {`TO DO: the actual app`->React.string} </div>
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
      "boxShadow": "inset 0 0 0 2px #000",
      "position": "relative",
    })
    let insideContents = css({
      "display": "flex",
      "flexDirection": "column",
      "alignItems": "center",
      "justifyContent": "center",
      "position": "absolute",
      "top": 0,
      "left": 0,
      "right": 0,
      "bottom": 0,
    })
  }
  let barCodeUrl = Router.makeHref("/assets/images/barcode.png")
  @react.component
  let make = () => {
    <div className=Styles.root>
      <div className=Styles.container>
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
        <div className=Styles.inside>
          <div className=Styles.insideContents> <ActualApp /> </div>
        </div>
      </div>
    </div>
  }
}

module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
    "flexGrow": 1,
  })
}

@react.component
let make = () => {
  <>
    <Head> <title> {"Welcome"->React.string} </title> </Head>
    <div className=Styles.container> <Book /> </div>
  </>
}
