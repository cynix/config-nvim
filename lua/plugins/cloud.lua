return {
  {
    'p00f/godbolt.nvim',
    keys = {
      { '<Leader>gb', ":'<,'>Godbolt<CR>", desc='Godbolt', mode='x' },
    },
    opts = {
      languages = {
        cpp = {
          compiler = 'clang1301',
          options = { '-std=c++17' },
        },
      },
      quickfix = {
        auto_open = true,
        enable = true,
      },
    },
  },
}
