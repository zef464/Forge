package cmd

import (
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

var yes bool

var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create app in environment",
	Args:  cobra.ExactArgs(1),
	RunE: func(cmd *cobra.Command, args []string) error {
		app := args[0]
		targetEnv := resolveEnv()

		tok, err := resolveToken()
		if err != nil {
			return err
		}
		cloudID, folderID, err := resolveYandexIDs()
		if err != nil {
			return err
		}

		envDir := "terraform/environments/" + targetEnv
		tfEnv := []string{
			"TF_VAR_yc_token=" + tok,
			"TF_VAR_yc_cloud_id=" + cloudID,
			"TF_VAR_yc_folder_id=" + folderID,
		}

		if err := runTerraform(envDir, tfEnv, "init", "-input=false"); err != nil {
			return err
		}
		return runTerraform(envDir, tfEnv, "plan", "-input=false")
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

	rootCmd.PersistentFlags().GetString("env")
	createCmd.Flags().BoolVar(&yes, "yes", false, "apply immediately, without confirmation")
}
