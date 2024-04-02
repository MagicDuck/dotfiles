(variable_declarator value: (_) @my.variable_decl.rhs)
(assignment_expression right: (_) @my.variable_decl.rhs)

(expression_statement) @my.statement
(lexical_declaration) @my.statement

(arguments (_) @my.args) 
(formal_parameters (_) @my.args)

(statement_block (_) @my.block.inner)
(statement_block) @my.block.outer 

(function_declaration) @my.function.outer
(arrow_function) @my.function.outer
(method_definition) @my.function.outer
(export_statement (function_declaration)) @my.function.outer

; broken -> (export_statement value: (function)) @my.function.outer
(export_statement value: (assignment_expression right: (arrow_function))) @my.function.outer
(export_statement declaration: (lexical_declaration (variable_declarator value: (arrow_function)))) @my.function.outer

(function_declaration) @my.function.outer
(arrow_function) @my.function.outer

(arrow_function body: (_) @my.function.body)
(function_declaration body: (_) @my.function.body)
; ((function_declaration body: (statement_block . (_) @_start (_)* @_end ))
;  (#make-range! "my.function.body" @_start @_end)
; )

(((comment) @_start (comment)* @_end)
 (#make-range! "my.comment" @_start @_end)
)
