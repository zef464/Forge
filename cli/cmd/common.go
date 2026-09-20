package cmd

import (
	"fmt"
	"os/exec"
	"strings"
)

// resolveEnv — если пользователь не передал --env, берём default_env из forge.yaml
func resolveEnv() string {
	if env != "" {
		return env
	}
	return projectConfig.GetString("default_env")
}

func resolveToken() (string, error) {
	if t := credentials.GetString("yandex.token"); t != "" {
		return t, nil
	}

	// yc CLI — то, что Viper сам не умеет, оставляем ручным fallback'ом
	out, err := exec.Command("yc", "iam", "create-token").Output()
	if err == nil {
		return strings.TrimSpace(string(out)), nil
	}

	return "", fmt.Errorf(
		"нет токена Yandex Cloud. Заполни ~/.forge/credentials.yaml, " +
			"передай --token, выставь FORGE_YC_TOKEN, или сделай yc init",
	)
}

func resolveYandexIDs() (cloudID, folderID string, err error) {
	cloudID = credentials.GetString("yandex.cloud_id")
	folderID = credentials.GetString("yandex.folder_id")
	if cloudID == "" || folderID == "" {
		return "", "", fmt.Errorf("заполни yandex.cloud_id и yandex.folder_id в ~/.forge/credentials.yaml")
	}
	return cloudID, folderID, nil
}
