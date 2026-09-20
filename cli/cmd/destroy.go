/*
Copyright © 2026 Vadim Sobakr <vsobakar2205@gmail.com>
*/
package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

var yes_destroy bool

// destroyCmd represents the destroy command
var destroyCmd = &cobra.Command{
	Use:   "destroy",
	Short: "Destoy all infrastructure of your app",
	Long:  `Text text text`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("destroy called", env)
	},
}

func init() {
	rootCmd.AddCommand(destroyCmd)

	destroyCmd.Flags().BoolVar(&yes_destroy, "yes", false, "apply immediately, without confirmation") //bool
}
