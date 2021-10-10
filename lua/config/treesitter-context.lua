require('treesitter-context').setup({
  patterns = {
    default = {
      'class',
      'function',
      'method',
      'if',
      'for',
      'while',
      'switch',
      'case',
    },
  },
})
