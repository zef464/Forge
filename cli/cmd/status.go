/*
Copyright © 2026 Vadim Sovakar <vsobakar2205@gmail.com>
*/
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

// statusCmd represents the status command
var statusCmd = &cobra.Command{
	Use:   "status",
	Short: "Check status of your app",
	Long:  `Fastest way to monitor and check status of your app`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("status called", env)
	},
}

func init() {
	rootCmd.AddCommand(statusCmd)
}
