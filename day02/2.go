package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	bytesRead, _ := ioutil.ReadFile("input.txt")
	fileContent := string(bytesRead)
	lines := strings.Split(fileContent, "\n")
	var total = 0

	for l := 0; l < len(lines)-1; l++ {
		var maxB = 0
		var maxR = 0
		var maxG = 0
		g := lines[l]
		gs := strings.Split(g, ":")
		s := strings.Split(gs[1], ";")

		for i := 0; i < len(s); i++ {
			m := make(map[string]int)
			c := strings.Split(s[i], ",")

			for j := 0; j < len(c); j++ {
				x := strings.Split(c[j], " ")
				a := x[2]
				b := x[1]
				f, err := strconv.Atoi(b)
				if err != nil {
				}
				m[a] = f
			}

			if m["blue"] > maxB {
				maxB = m["blue"]
			}
			if m["red"] > maxR {
				maxR = m["red"]
			}
			if m["green"] > maxG {
				maxG = m["green"]
			}
		}

		total += maxR * maxG * maxB

	}
	fmt.Println(total)
}
