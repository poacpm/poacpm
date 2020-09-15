module Messages exposing (Msg(..))

import Browser exposing (UrlRequest)
import Browser.Dom exposing (Viewport)
import Time exposing (Posix)
import Url exposing (Url)


type Msg
    = OnUrlChange Url
    | OnUrlRequest UrlRequest
    | OnAnimationFrame Posix
    | GotNewViewport Viewport
    | GotNewWidth Int
    | OnSearchInput String
    | Search Int
