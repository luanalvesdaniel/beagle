/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package br.com.zup.beagle.automatedTests

import android.util.Log
import br.com.zup.beagle.android.logger.BeagleLogger
import br.com.zup.beagle.automatedTests.config.BeagleLoggerDefault
import io.mockk.every
import io.mockk.mockkStatic
import io.mockk.unmockkStatic
import io.mockk.verify
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

private const val BEAGLE_TAG = "BeagleSDK"
private const val LOG = "log"

class BeagleLoggerDefaultTest {

    private lateinit var beagleLoggerDispatchingDefault: BeagleLogger

    @BeforeEach
    fun setUp() {
        mockkStatic(Log::class)

        beagleLoggerDispatchingDefault = BeagleLoggerDefault()

        every { Log.w(any(), any<String>()) }returns 0
        every { Log.i(any(), any()) } returns 0
        every { Log.e(any(), any()) } returns 0
        every { Log.d(any(), any()) } returns 0
        every { Log.v(any(), any()) } returns 0
    }

    @AfterEach
    fun tearDown() {
        unmockkStatic(Log::class)
    }

    @Test
    fun warning_should_call_Log_w() {
        // When
        beagleLoggerDispatchingDefault.warning(LOG)

        // Then
        verify(exactly = 1) { Log.w(BEAGLE_TAG, LOG) }
    }

    @Test
    fun error_should_call_Log_w() {
        // When
        beagleLoggerDispatchingDefault.error(LOG)

        // Then
        verify(exactly = 1) { Log.e(BEAGLE_TAG, LOG) }
    }
    
    @Test
    fun info_should_call_Log_w() {
        // When
        beagleLoggerDispatchingDefault.info(LOG)

        // Then
        verify(exactly = 1) { Log.i(BEAGLE_TAG, LOG) }
    }

}