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

package br.com.zup.beagle.data.serializer.adapter

import br.com.zup.beagle.action.Action
import br.com.zup.beagle.action.CustomAction
import br.com.zup.beagle.action.FormValidation
import br.com.zup.beagle.action.Navigate
import br.com.zup.beagle.action.ShowNativeDialog
import br.com.zup.beagle.data.serializer.PolymorphicJsonAdapterFactory

private const val BEAGLE_WIDGET_TYPE = "_beagleType_"
private const val BEAGLE_NAMESPACE = "beagle"
private const val ACTION_NAMESPACE = "action"

internal object ActionJsonAdapterFactory {

    fun make(): PolymorphicJsonAdapterFactory<Action> {
        return PolymorphicJsonAdapterFactory.of(Action::class.java, BEAGLE_WIDGET_TYPE)
            .withSubtype(CustomAction::class.java, createNamespaceFor<CustomAction>())
            .withSubtype(FormValidation::class.java, createNamespaceFor<FormValidation>())
            .withSubtype(Navigate::class.java, createNamespaceFor<Navigate>())
            .withSubtype(ShowNativeDialog::class.java, createNamespaceFor<ShowNativeDialog>())
    }

    private inline fun <reified T : Action> createNamespaceFor(): String {
        return "$BEAGLE_NAMESPACE:$ACTION_NAMESPACE:${T::class.java.simpleName.toLowerCase()}"
    }
}