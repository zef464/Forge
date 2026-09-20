package cmd

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/spf13/viper"
)

// Два отдельных Viper-инстанса — потому что это два разных файла с разным
// назначением и разным местом хранения (репозиторий vs домашняя папка).
// Смешивать их в один было бы тем самым риском "секрет улетит в git".
var projectConfig = viper.New()
var credentials = viper.New()

func initConfig() {
	projectConfig.SetConfigName("forge")
	projectConfig.SetConfigType("yaml")
	projectConfig.AddConfigPath(".")
	projectConfig.SetDefault("provider", "yandex")
	projectConfig.SetDefault("default_env", "dev")

	if err := projectConfig.ReadInConfig(); err != nil {
		if _, notFound := err.(viper.ConfigFileNotFoundError); !notFound {
			fmt.Fprintln(os.Stderr, "предупреждение: forge.yaml:", err)
		}
		// файла нет — не страшно, работаем на дефолтах
	}

	home, err := os.UserHomeDir()
	if err == nil {
		credentials.SetConfigName("credentials")
		credentials.SetConfigType("yaml")
		credentials.AddConfigPath(filepath.Join(home, ".forge"))
		_ = credentials.ReadInConfig() // тоже не критично, если файла ещё нет
	}

	// Вот тут магия приоритетов: флаг --token, если передан, побеждает
	// значение из файла — без единого if'а с нашей стороны.
	credentials.BindPFlag("yandex.token", rootCmd.PersistentFlags().Lookup("token"))
	credentials.BindEnv("yandex.token", "FORGE_YC_TOKEN")
}
