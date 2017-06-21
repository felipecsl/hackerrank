package com.felipecsl

import java.util.*

// https://www.hackerrank.com/challenges/journey-to-the-moon

// the entire graph
val NODES: MutableMap<Astronaut, MutableList<Edge>> = mutableMapOf()

// list of every disjoint graph (with astronauts grouped by nation)
val countries: MutableList<Country> = mutableListOf()
val debug = true

class Country(val nodes: MutableSet<Astronaut> = mutableSetOf()) {
  override fun toString(): String {
    return "Country(NODES=$nodes)"
  }
}

class Astronaut(val value: Int, var country: Country? = null) {
  override fun toString(): String {
    return value.toString()
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (other?.javaClass != javaClass) return false

    other as Astronaut

    if (value != other.value) return false

    return true
  }

  override fun hashCode(): Int {
    return value
  }

  fun assignCountry(country: Country) {
    this.country = country
    country.nodes.add(this)
  }
}

data class Edge(val from: Astronaut, val to: Astronaut) {
  fun assignCountry(country: Country) {
    from.assignCountry(country)
    to.assignCountry(country)
  }
}

fun main(args: Array<String>) {
  val tokens = readInputLine()
  val n = tokens[0]
  val p = tokens[1]
  val pairs = (0 until p)
      .map { readInputLine() }
      .map { Pair(it[0], it[1]) }
  print(solve(n, pairs))
}

fun solve(n: Int, pairs: List<Pair<Int, Int>>): Long {
  populateNodes(n, pairs)
  for ((node, edges) in NODES) {
    if (node.country == null) {
      val country = Country()
      node.assignCountry(country)
      edges.forEach { traverseGraph(it, country) }
      countries.add(country)
    }
  }
  val sums: MutableMap<Int, Int> = mutableMapOf()
  var result = 0L
  (1 until countries.size).forEach {
    val prevSum = if (it > 1) sums[it - 1]!! else countries[0].nodes.size
    sums.put(it, prevSum + countries[it].nodes.size)
    result += (prevSum * countries[it].nodes.size).toLong()
  }
  return result
}

fun addNode(from: Astronaut, to: Astronaut) {
  val lst = NODES[from]
  val edge = Edge(from, to)
  if (lst != null) {
    lst.add(edge)
  } else {
    NODES.put(from, mutableListOf(edge))
  }
}

// Finds all astronauts in the provided graph (edge list) - depth first
fun traverseGraph(currEdge: Edge, country: Country) {
  val visited = mutableSetOf<Edge>()
  val queue: Queue<Edge> = ArrayDeque()
  visited.add(currEdge)
  queue.offer(currEdge)
  currEdge.assignCountry(country)
  while (!queue.isEmpty()) {
    val current = queue.poll()
    NODES[current.to]!!.forEach {
      if (!visited.contains(it)) {
        it.assignCountry(country)
        visited.add(it)
        queue.offer(it)
      }
    }
  }
}

private fun readInputLine() =
    readLine()!!.split(' ').map(String::toInt)

fun populateNodes(n: Int, pairs: List<Pair<Int, Int>>) {
  pairs.forEach {
    val src = Astronaut(it.first)
    val dst = Astronaut(it.second)
    addNode(src, dst)
    addNode(dst, src)
  }
  (0 until n).forEach {
    val astronaut = Astronaut(it)
    if (!NODES.containsKey(astronaut)) {
      NODES.put(astronaut, mutableListOf())
    }
  }
}