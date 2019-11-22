package br.com.zup.beagleui.framework.widget.layout

import br.com.zup.beagleui.framework.widget.core.NativeWidget
import br.com.zup.beagleui.framework.widget.core.Widget

data class ScrollView(
    val child: Widget,
    val scrollDirection: ScrollAxis? = null,
    val scrollBarEnabled: Boolean? = null
) : NativeWidget

enum class ScrollAxis {
    VERTICAL,
    HORIZONTAL
}
