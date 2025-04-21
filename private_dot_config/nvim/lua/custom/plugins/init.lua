-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {}

      vim.keymap.set('n', '<leader>g', '<cmd>Neogit kind=vsplit<cr>', { desc = 'Open Neogit' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    config = function(_, opts)
      vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>')

      vim.keymap.set('n', '<leader>dd', function()
        require('dap').continue()
      end)
      vim.keymap.set('n', '<leader>dn', function()
        require('dap').step_over()
      end)
      vim.keymap.set('n', '<leader>di', function()
        require('dap').step_into()
      end)
      vim.keymap.set('n', '<leader>do', function()
        require('dap').step_out()
      end)
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
    },
    config = function(_, opts)
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
      vim.keymap.set('n', '<leader>dpr', function()
        require('dap-python').test_method()
      end)
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
}
