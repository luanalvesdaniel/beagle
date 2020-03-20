/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.action

import android.content.Context
import br.com.zup.beagle.view.ViewFactory

internal class ShowNativeDialogActionHandler(
    private val viewFactory: ViewFactory = ViewFactory()
) : ActionHandler<ShowNativeDialog> {

    override fun handle(context: Context, action: ShowNativeDialog) {
        viewFactory.makeAlertDialogBuilder(context)
            .setTitle(action.title)
            .setMessage(action.message)
            .setPositiveButton(action.buttonText) { dialog, _ ->
                dialog.dismiss()
            }.show()
    }
}
