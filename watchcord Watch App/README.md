#  the watch app

this is here so i dont go insane

# APP STRUCTURE

## ContentView - List of guilds
    Each guild is represented by a GuildItem, and leads to a GuildDetails page.
## GuildDetails - Details of guild, channels, etc.
    Each channel is represented by a ChannelItem, and leads to a Messages page.
## Messages - Messages in a channel
    ...

# better app structure
- start at ContentView and see all guilds
- when pressed on guild go to GuildDetails which shows only channel categories
- when pressed on category go to all channels in that category
