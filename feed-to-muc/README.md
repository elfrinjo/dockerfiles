## feed-to-muc: Bridge a rss-feed to a xmpp muc
Run Martin Doschs Feed-to-MUC bridge inside a docker container.
https://salsa.debian.org/mdosch-guest/feed-to-muc

This image expects the following configuration file at `/.config/feed-to-muc/config.json`

```json
{
"ServerAddress": "example.com:5222",
"BotJid":        "feedbot@example.com",
"Password":      "ChangeThis!",
"Muc":           "muc-to-feed@conference.example.com",
"MucNick":       "feedbot",
"Contact":       "xmpp:botadmin@example.com",
"MaxArticles":    5,
"RefreshTime":    30,
"NoExcerpt":     false,
"Quiet":         false,
"Filter":        [ "submitted by", "[link]" ],
"Feeds":         [ "https://www.debian.org/News/news",
                 "https://www.debian.org/security/dsa-long",
                 "https://www.reddit.com/r/FDroidUpdates/new.rss" ]
}
```

## Usage
```console
# sudo docker run -d \
    -v /path/to/config.json:/.config/feed-to-muc/config.json
    elfrinjo/feed-to-muc:latest
```
