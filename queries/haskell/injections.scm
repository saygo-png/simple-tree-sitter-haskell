; -----------------------------------------------------------------------------
; General language injection
(quasiquote
  (quoter) @injection.language
  (quasiquote_body) @injection.content)

((comment) @injection.content
  (#set! injection.language "comment"))
