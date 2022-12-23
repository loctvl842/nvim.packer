tvl.initialize_packer()

-- local use_dev = false

-- if use_dev then
--   -- use the local project
--   vim.opt.runtimepath:prepend(vim.fn.expand("~/projects/lazy.nvim"))
-- else
--   -- bootstrap from github
--   local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--   if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--       "git",
--       "clone",
--       "--filter=blob:none",
--       "--single-branch",
--       "https://github.com/folke/lazy.nvim.git",
--       lazypath,
--     })
--   end
--   vim.opt.runtimepath:prepend(lazypath)
-- end

-- -- load lazy
-- require("lazy").setup("core.plugins", {
--   defaults = { lazy = true },
-- })
