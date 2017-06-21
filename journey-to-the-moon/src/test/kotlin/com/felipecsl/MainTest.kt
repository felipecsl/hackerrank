package com.felipecsl

import org.junit.Assert.assertEquals
import org.junit.Test
import java.io.ByteArrayOutputStream
import java.io.PrintStream

class MainTest {
  @Test fun testCase0() {
    withTestInput("input00.txt") {
      assertEquals("6", it.toString())
    }
  }

  @Test fun testCase1() {
    withTestInput("input01.txt") {
      assertEquals("5", it.toString())
    }
  }

  @Test fun testCase7() {
    withTestInput("input07.txt") {
      assertEquals("11082889", it.toString())
    }
  }

  @Test fun testCase11() {
    withTestInput("input11.txt") {
      assertEquals("4999949998", it.toString())
    }
  }

  @Test fun testCase13() {
    withTestInput("input13.txt") {
      assertEquals("4527147", it.toString())
    }
  }

  fun withTestInput(
      filename: String,
      mainArgs: Array<String> = emptyArray(),
      block: (ByteArrayOutputStream) -> Unit) {
    javaClass.classLoader.getResource(filename).openStream().use { fileStream ->
      System.setIn(fileStream)
      ByteArrayOutputStream().use { baos ->
        PrintStream(baos).use { ps ->
          System.setOut(ps)
          main(mainArgs)
          block(baos)
        }
      }
    }
  }
}