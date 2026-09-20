/*
Copyright © 2026 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var env_status string

// statusCmd represents the status command
var statusCmd = &cobra.Command{
	Use:   "status",
	Short: "Check status of your app",
	Long:  `Fastest way to monitor and check status of your app`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("status called", env_status)
	},
}

func init() {
	rootCmd.AddCommand(statusCmd)

	statusCmd.Flags().StringVar(&env_status, "env", "dev", "environment dev|staging|prod")
}
