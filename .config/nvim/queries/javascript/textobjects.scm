(variable_declarator value: (_) @my.variable_decl.rhs)
(assignment_expression right: (_) @my.variable_decl.rhs)

(expression_statement) @my.statement
(lexical_declaration) @my.statement

(arguments (_) @my.args) 
(formal_parameters (_) @my.args)

(statement_block (_) @my.block.inner)
(statement_block) @my.block.outer 
