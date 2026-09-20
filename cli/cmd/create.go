package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

var env string
var yes bool

var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create app in environment",
	Args:  cobra.ExactArgs(1),
	RunE: func(cmd *cobra.Command, args []string) error {
		app := args[0]
		fmt.Printf("создаю %s в окружении %s\n", app, env)

		envDir := "../terraform/environments/" + env

		if err := runTerraform(envDir, "init", "-input=false"); err != nil {
			return err
		}
		if err := runTerraform(envDir, "plan", "-input=false"); err != nil {
			return err
		}

		return nil
	},
}

func runTerraform(dir string, args ...string) error {
	cmd := exec.Command("terraform", args...)
	cmd.Dir = dir
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}

func init() {
	rootCmd.AddCommand(createCmd)

	createCmd.Flags().StringVar(&env, "env", "dev", "environment: dev|staging|prod")
	createCmd.Flags().BoolVar(&yes, "yes", false, "apply immediately, without confirmation")
}
