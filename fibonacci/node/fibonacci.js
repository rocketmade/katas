var fibonacci = function* () {
    var curr = 1
    var next = 1
    while (1) {
        yield curr
        var temp = curr
        curr = next
        next += temp
    }
}

module.exports = fibonacci()
