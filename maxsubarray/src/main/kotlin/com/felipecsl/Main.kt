package com.felipecsl

// https://www.hackerrank.com/challenges/maxsubarray

fun main(args: Array<String>) {
  val totalArrays = readLine()!!.trim().toInt()
  val arrays = (0 until totalArrays).map {
    readLine() // arr length, unused
    readInputLine()
  }
  arrays.forEach {
    println("${maxContiguousSubArray(it)} ${maxNonContiguousSubArray(it)}")
  }
}

fun maxContiguousSubArray(arr: List<Int>): Int {
  var maxEndingHere = 0
  var maxSoFar = Int.MIN_VALUE
  arr.forEach { x ->
    maxEndingHere = Math.max(x, maxEndingHere + x)
    maxSoFar = Math.max(maxSoFar, maxEndingHere)
  }
  return maxSoFar
}

fun maxNonContiguousSubArray(arr: List<Int>) =
    if (arr.any { it > 0 })
      arr.filter { it > 0 }.sum()
    else
      arr.max()

private fun readInputLine() =
    readLine()!!.trim().split(' ').map(String::toInt)
