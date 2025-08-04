package handlers

import (
	"gopkg.in/telebot.v4"
)

func EchoHandler(bot *telebot.Bot) func(c telebot.Context) error {
	return func(c telebot.Context) error {
		msg := c.Message().Text
		return c.Send("Ви написали: " + msg)
	}
}
