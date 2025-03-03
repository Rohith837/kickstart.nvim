-- https://github.com/tpope/vim-dadbod/issues/81

-- https://github.com/kristijanhusak/vim-dadbod-ui/issues/69

-- echo &ft to know the filetype

-- for connecting to sqlserver sqlserver://sa:track%40123@100.100.100.100:1433/smgt_test
-- go install github.com/microsoft/go-mssqldb@latest
-- go list -m github.com/microsoft/go-mssqldb@latest
-- choco install sqlcmd
-- https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Cwindows&pivots=cs1-bash

return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  'kristijanhusak/vim-dadbod-ui',
}
