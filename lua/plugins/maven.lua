require('maven').setup({
    executable = "./mvnw", -- `mvn` should be in your `PATH`, or the path to the maven exectable, for example `./mvnw`
    cwd = nil,           -- work directory, default to `vim.fn.getcwd()`
    settings = nil,      -- specify the settings file or use the default settings
    commands = {         -- add custom goals to the command list
        { cmd = { "clean", "compile" }, desc = "clean then compile" },
    },
})
