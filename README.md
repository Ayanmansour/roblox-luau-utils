# Roblox Luau Utilities

A small, open-source collection of reusable **Roblox Luau** modules. This is an early starter project intended for learning and community collaboration.

## What's included

- **Cooldown** — server-side cooldowns keyed by player UserId and action name. Includes `tryUse`, `remaining`, `clear`, and `clearPlayer`.
- **Countdown** — runs a countdown with `onTick` and an optional completion callback. Returns a function to cancel it.
- **SessionData** — stores session-only coins and levels in memory. **Not persistent**; values disappear when the server stops.

## Install in Roblox Studio

1. Open **Explorer** and find `ServerScriptService`.
2. Add a Folder named `Utilities` inside `ServerScriptService`.
3. For each file in `src/`, create a **ModuleScript** with the same name (without `.lua`) under `Utilities`, and paste in its contents.
4. Add a normal **Script** under `ServerScriptService`, and paste in `examples/ServerExample.lua`.
5. Press **Play** and inspect the **Output** window.

## Small example

```lua
local Cooldown = require(game.ServerScriptService.Utilities.Cooldown)
if Cooldown.tryUse(player.UserId, "dash", 2) then
    -- Perform the dash on the server after validating the request.
end
```

## Notes and limitations

- **Never trust client-supplied user IDs or rewards.** Call these utilities from trusted server code and validate RemoteEvent inputs.
- `Cooldown` uses `os.clock()` and applies only within the current server. It does not synchronize across servers.
- `Countdown` uses `task.wait(1)`; scheduler delays can make wall-clock timing imprecise.
- `SessionData` deliberately **does not use DataStoreService**. Do not use it for permanent progress or purchases.
- These modules are starter examples and have **not been tested in Roblox Studio** in this environment. Test them before using them in a published experience.

## Roadmap

- Add Studio-tested automated checks and examples.
- Add optional DataStore persistence with retry handling.
- Improve documentation and edge-case coverage.

## Contributing

Issues, suggestions, and small improvements are welcome. Please explain what changed and how you tested it in Roblox Studio.

## License

MIT. See [LICENSE](LICENSE).
