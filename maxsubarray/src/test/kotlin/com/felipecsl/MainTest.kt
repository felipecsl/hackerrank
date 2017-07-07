package com.felipecsl

import org.junit.Assert.assertEquals
import org.junit.Test
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.io.PrintStream

class MainTest {
  @Test fun testCase0() {
    runTestCase("00")
  }

  @Test fun testCase1() {
    runTestCase("01")
  }

  @Test fun testCase2() {
    runTestCase("02")
  }

  private fun withTestInput(
      filename: String,
      mainArgs: Array<String> = emptyArray(),
      block: (String) -> Unit) {
    asInputStream(filename) {
      System.setIn(it)
      ByteArrayOutputStream().use { baos ->
        PrintStream(baos).use { ps ->
          System.setOut(ps)
          main(mainArgs)
          block(baos.toString())
        }
      }
    }
  }

  private fun readFile(filename: String): String {
    asInputStream(filename) {
      it.bufferedReader().use { reader ->
        return reader.readText()
      }
    }
  }

  private fun runTestCase(testNumber: String) {
    withTestInput("input$testNumber.txt") {
      assertEquals(readFile("output$testNumber.txt"), it)
    }
  }

  private inline fun <R> asInputStream(filename: String, block: (InputStream) -> R): R =
      javaClass.classLoader.getResource(filename).openStream().use {
        return block(it)
      }
}