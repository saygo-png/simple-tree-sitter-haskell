; Haskell highlights, forked from nvim-treesitter's queries/haskell/highlights.scm.

; ----------------------------------------------------------------------------
; Literals and comments
(integer) @number
(float) @number.float
(char) @character
(string) @string
(comment) @comment
(haddock) @comment.documentation

; ----------------------------------------------------------------------------
; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ","
  ";"
] @punctuation.delimiter

; ----------------------------------------------------------------------------
; Keywords
[
  "forall"
  "∀"
] @keyword.repeat

(pragma) @keyword.directive

[
  "if"
  "then"
  "else"
  "case"
  "cases"
  "of"
] @keyword.conditional

[
  "import"
  "qualified"
  "module"
] @keyword.import

[
  "where"
  "let"
  "in"
  "class"
  "instance"
  "pattern"
  "data"
  "newtype"
  "family"
  "type"
  "as"
  "hiding"
  "deriving"
  "via"
  "stock"
  "anyclass"
  "do"
  "mdo"
  "rec"
  "infix"
  "infixl"
  "infixr"
] @keyword

; ----------------------------------------------------------------------------
; Operators
[
  (operator)
  (constructor_operator)
  (all_names)
  "."
  ".."
  "="
  "|"
  "::"
  "=>"
  "->"
  "<-"
  "\\"
  "`"
  "@"
] @operator

(negation
  "-" @operator)

(wildcard) @character.special

; ----------------------------------------------------------------------------
; Modules, also the qualifier in qualified names (Map.lookup)
(module) @module

(module
  "." @module)

; ----------------------------------------------------------------------------
; Types
(name) @type

(type/unit
  [
    "("
    ")"
  ] @type)

(type/list
  [
    "["
    "]"
  ] @type)

(type/star) @type

(constructor) @constructor

; ----------------------------------------------------------------------------
; Names used infix with backticks are operators (a `div` b, a `M.div` b)
(infix_id
  [
    (variable) @operator
    (constructor) @operator
    (qualified
      id: (_) @operator)
  ])

; ----------------------------------------------------------------------------
; Quasi-quotes, the body of other languages is handled by injections.scm
(quoter) @function.macro

; ----------------------------------------------------------------------------
; Record fields
(field_name
  (variable) @variable.member)

; ----------------------------------------------------------------------------
; Spell checking
(comment) @spell
