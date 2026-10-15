-- Fails if a query doesn't fit the parser.
-- usage: nvim --clean -l check.lua <parser.so> <queries dir>
local parser, queries = arg[1], arg[2]
vim.treesitter.language.add("haskell", { path = parser })

local known = {}
for _, name in ipairs(vim.list_extend(vim.treesitter.query.list_predicates(), vim.treesitter.query.list_directives())) do
  known[name] = true
end

for name, kind in vim.fs.dir(queries) do
  if kind == "file" and name:match("%.scm$") then
    local file = assert(io.open(vim.fs.joinpath(queries, name)))
    local ok, query = pcall(vim.treesitter.query.parse, "haskell", file:read("*a"))
    file:close()
    assert(ok, name .. ": " .. tostring(query))

    -- Unknown predicates only error once a match is checked, so check them here
    for _, predicates in pairs(query.info.patterns) do
      for _, predicate in ipairs(predicates) do
        assert(known[predicate[1]:gsub("^not%-", "")], name .. ": unknown predicate " .. predicate[1])
      end
    end
  end
end
