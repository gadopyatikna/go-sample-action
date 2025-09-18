package main

import (
	"fmt"
	"os"
	"os/exec"
)

func run(cmd string, args ...string) error {
	c := exec.Command(cmd, args...)
	c.Stdout = os.Stdout
	c.Stderr = os.Stderr
	return c.Run()
}

func main() {
	fmt.Println("🔨 Building...")
	if err := run("go", "build", "./..."); err != nil {
		os.Exit(1)
	}

	fmt.Println("✅ Running tests...")
	if err := run("go", "test", "./..."); err != nil {
		os.Exit(1)
	}

	fmt.Println("🔍 Linting...")
	if err := run("golangci-lint", "run", "./..."); err != nil {
		os.Exit(1)
	}

	fmt.Println("🎉 All checks passed!")
}
