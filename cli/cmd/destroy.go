/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var env_destroy string
var yes_destroy bool

// destroyCmd represents the destroy command
var destroyCmd = &cobra.Command{
	Use:   "destroy",
	Short: "Destoy all infrastructure of your app",
	Long:  `Text text text`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("destroy called")
	},
}

func init() {
	rootCmd.AddCommand(destroyCmd)

	destroyCmd.Flags().StringVar(&env_destroy, "env", "dev", "environment: dev|staging|prod")
	destroyCmd.Flags().BoolVar(&yes_destroy, "yes", false, "apply immediately, without confirmation") //bool
}
