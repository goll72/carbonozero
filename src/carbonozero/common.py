import rich
import grapheme

from rich.text import Text
from rich.align import Align


def text_bar(
    text: str | rich.console.RenderableType,
    width: int,
    *,
    aside: str | rich.console.RenderableType = "",
):
    _len = grapheme.length(text)
    _len_aside = grapheme.length(aside)

    return Align.center(
        Text(
            " " + text + " " * (width - _len - _len_aside - 2) + aside + " ",
            style="on grey15"
        )
    )
 
