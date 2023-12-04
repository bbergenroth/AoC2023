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
	total := 0

	for l := 0; l < len(lines)-1; l++ {
		var good = true
		g := lines[l]
		gs := strings.Split(g, ":")
		game, err := strconv.Atoi(strings.Split(gs[0]," ")[1])
		if err != nil {
		}

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
			if m["red"] > 12 || m["green"] > 13 || m["blue"] > 14 {
				good = false
				break
			}
		}
		if good {
			total += game
		}
	}
	fmt.Println(total)
}
