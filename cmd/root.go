package cmd

import (
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	"gopkg.in/telebot.v4"

	"github.com/Trohimmaster/kbot/handlers"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "kbot",
	Short: "A brief description of your application",
	Run: func(cmd *cobra.Command, args []string) {
		token := os.Getenv("TELE_TOKEN")
		if token == "" {
			log.Fatal("TELE_TOKEN env variable is not set")
		}

		pref := telebot.Settings{
			Token:  token,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		}

		bot, err := telebot.NewBot(pref)
		if err != nil {
			log.Fatal(err)
		}

		bot.Handle(telebot.OnText, handlers.EchoHandler(bot))
		log.Println("Bot is up and running...")
		bot.Start()
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
func Execute() {
	if err := rootCmd.Execute(); err != nil {
		log.Fatal(err)
	}
}
