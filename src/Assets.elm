module Assets exposing (logo)

import Css
import Html.Styled exposing (Html)
import Messages exposing (Msg)
import Model exposing (Model)
import Style.Extra exposing (ifMobile)
import Svg.Styled exposing (..)
import Svg.Styled.Attributes exposing (..)


logoPath : Html Msg
logoPath =
    Svg.Styled.path
        [ d """M0,200 C0,0 183.916355,
               3.55271368e-15 200,0 C216.083645,0 400,0 400,200 C400,
               360.602127 263.263237,400 200,400 C169.940075,
               400 130.053436,383.872837 110.053436,360 C83.687159,
               328.528108 81.6540229,287.441333 100,280 C120,
               271.887777 144.702055,
               320 200,320 C255.297945,320 320,270.651856 320,200 C320,
               129.348144 280,80 200,80 C120,80 79.9607444,129.348144 79.9607444,
               200 L79.9607444,380 C79.9607444,400.484491 52.5173973,
               420 40,420 C27.4826027,420 7.10542736e-15,398.833096 0,
               380 L0,200 Z M200,260 C166.862915,
               260 140,233.137085 140,200 C140,166.862915 166.862915,140 200,
               140 C233.137085,140 260,166.862915 260,200 C260,
               233.137085 233.137085,260 200,260 Z"""
        , fill "url(#radialGradient-1)"
        ]
        []


logoText : Int -> Html Msg
logoText currentWidth =
    text_
        [ fontFamily "VarelaRound, Varela Round"
        , fontSize "230"
        , fontWeight "normal"
        , letterSpacing "-12.5"
        , css <|
            ifMobile currentWidth
                [ Css.display Css.none ]
                [ Css.fill Css.currentColor ]
        ]
        [ tspan
            [ x "473"
            , y "367"
            ]
            [ text "poac" ]
        ]


logo : Model -> Html Msg
logo model =
    svg
        [ width "70"
        , height "40"
        , viewBox "0 0 1060 460"
        , version "1.1"
        , css <|
            ifMobile model.width
                [ Css.width (Css.px 40) ]
                []
        ]
        [ defs []
            [ radialGradient
                [ cx "10.5172853%"
                , cy "100%"
                , fx "10.5172853%"
                , fy "100%"
                , r "119.945282%"
                , gradientTransform
                    """translate(0.105173,1.000000)
                          ,scale(1.000000,0.952381)
                          ,rotate(-51.739535)
                          ,scale(1.000000,0.892357)
                          ,translate(-0.105173,-1.000000)"""
                , id "radialGradient-1"
                ]
                [ stop
                    [ stopColor "#3023AE"
                    , offset "0%"
                    ]
                    []
                , stop
                    [ stopColor "#53A0FD"
                    , offset "79.8743881%"
                    ]
                    []
                , stop
                    [ stopColor "#51DEEC"
                    , offset "100%"
                    ]
                    []
                ]
            ]
        , g
            [ id "logo"
            , stroke "none"
            , strokeWidth "1"
            , fill "none"
            , fillRule "evenodd"
            ]
            [ g []
                [ g [ transform "translate(40.000000, 20.000000)" ]
                    [ logoPath
                    , logoText model.width
                    ]
                ]
            ]
        ]
