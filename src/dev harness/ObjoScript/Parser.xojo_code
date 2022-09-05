#tag Class
Protected Class Parser
	#tag Method, Flags = &h21, Description = 416476616E63657320746F20746865206E65787420746F6B656E2C2073746F72696E672061207265666572656E636520746F207468652070726576696F757320746F6B656E2E
		Private Sub Advance()
		  /// Advances to the next token, storing a reference to the previous token.
		  
		  Previous = Current
		  mCurrentIndex = mCurrentIndex + 1
		  Current = mTokens(mCurrentIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5472756520696620776527766520726561636865642074686520656E64206F662074686520746F6B656E2073747265616D2E
		Private Function AtEnd() As Boolean
		  /// True if we've reached the end of the token stream.
		  
		  Return mCurrentIndex > mTokens.LastRowIndex Or Current.Type = ObjoScript.TokenTypes.EOF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F7220612062696E617279206F70657261746F722E
		Private Function BinaryOperator(precedence As Integer, rightAssociative As Boolean = False) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a binary operator.
		  
		  Return New ObjoScript.GrammarRule(Nil, New BinaryParselet(precedence, rightAssociative), precedence)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074727565206966207468652063757272656E7420746F6B656E206D61746368657320616E79206F6620746865207370656369666965642074797065732E2053696D696C617220746F20604D617463682829602062757420646F6573204E4F5420636F6E73756D65207468652063757272656E7420746F6B656E2069662074686572652069732061206D617463682E
		Private Function Check(types() As ObjoScript.TokenTypes) As Boolean
		  /// Returns true if the current token matches any of the specified types.
		  /// Similar to `Match()` but does NOT consume the current token if there is a match.
		  
		  For Each type As ObjoScript.TokenTypes In types
		    If Current.Type = type Then Return True
		  Next type
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E732074727565206966207468652063757272656E7420746F6B656E206D61746368657320616E79206F6620746865207370656369666965642074797065732E2053696D696C617220746F20604D617463682829602062757420646F6573204E4F5420636F6E73756D65207468652063757272656E7420746F6B656E2069662074686572652069732061206D617463682E
		Private Function Check(ParamArray types As ObjoScript.TokenTypes) As Boolean
		  /// Returns true if the current token matches any of the specified types.
		  /// Similar to `Match()` but does NOT consume the current token if there is a match.
		  
		  For Each type As ObjoScript.TokenTypes In types
		    If Current.Type = type Then Return True
		  Next type
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  InitialiseGrammar
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 4966207468652063757272656E7420746F6B656E206D6174636865732060657870656374656460207468656E206974277320636F6E73756D65642E204966206E6F742C20776520726169736520616E20657863657074696F6E207769746820606D657373616765602E
		Sub Consume(expected As ObjoScript.TokenTypes, message As String = "")
		  /// If the current token matches `expected` then it's consumed.
		  /// If not, we raise an exception with `message`.
		  
		  If Current.Type <> expected Then
		    message = If(message = "", "Expected " + expected.ToString + " but got " + Current.Type.ToString + " instead.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 417373657274732074686174207468652063757272656E7420746F6B656E20697320616E20454F4C2E20496620736F20697420697320636F6E73756D65642E204F746865727769736520616E206572726F72207769746820746865206F7074696F6E616C20606D6573736167656020697320637265617465642E
		Private Sub ConsumeNewLine(message As String = "")
		  /// Asserts that the current token is an EOL. If so it is consumed. 
		  /// Otherwise an error with the optional `message` is created.
		  
		  If Current.Type <> ObjoScript.TokenTypes.EOL Then
		    message = If(message = "", "Expected a new line.", message)
		    Raise New ObjoScript.ParserException(message, Current)
		  Else
		    Advance
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273652061206465636C61726174696F6E20696E746F2061206053746D74602E
		Private Function Declaration() As ObjoScript.Stmt
		  /// Parse a declaration into a `Stmt`.
		  ///
		  /// An ObjoScript program is a series of statements. Statements produce a side effect. 
		  /// Declarations are a type of statement that bind new identifiers.
		  /// Regular statements produce side effects but do not introduce new bindings.
		  
		  // For now, we only parse statements (not definitions like `var` and `class`).
		  Return Statement
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 526169736573206120506172736572457863657074696F6E206174207468652063757272656E74206C6F636174696F6E2E20496620746865206572726F72206973206E6F74206174207468652063757272656E74206C6F636174696F6E2C20606C6F636174696F6E60206D61792062652070617373656420696E73746561642E
		Sub Error(message As String, location As ObjoScript.Token = Nil)
		  /// Raises a ParserException at the current location. If the error is not at the current location,
		  /// `location` may be passed instead.
		  
		  If location = Nil Then location = Current
		  
		  Raise New ObjoScript.ParserException(message, location)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E2065787072657373696F6E2E
		Function Expression() As ObjoScript.Expr
		  /// Parses an expression.
		  
		  // Parse the lowest precedence level which subsumes all of the higher
		  // precedence expressions too.
		  Return ParsePrecedence(Precedences.Lowest)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320616E2065787072657373696F6E20616E6420777261707320697420757020696E7369646520612073746174656D656E742E
		Private Function ExpressionStatement() As ObjoScript.Stmt
		  /// Parses an expression and wraps it up inside a statement.
		  
		  // Store the location of the start of the expression.
		  Var location As ObjoScript.Token = Current
		  
		  // Consume the expression.
		  Var expr As ObjoScript.Expr = Expression
		  
		  ConsumeNewLine
		  
		  Return New ObjoScript.ExpressionStmt(expr, location)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E7320746865206772616D6D61722072756C6520666F7220746865207370656369666965642060746F6B656E602E
		Private Function GetRule(token As ObjoScript.TokenTypes) As ObjoScript.GrammarRule
		  /// Returns the grammar rule for the specified `token`.
		  
		  #Pragma BreakOnExceptions False
		  
		  Return mRules.Value(token)
		  
		  Exception e As KeyNotFoundException
		    Error("There is no grammar rule for the `" + token.ToString + "` token.")
		    
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 496E697469616C6973657320746865207061727365722773206772616D6D61722072756C65732E
		Private Sub InitialiseGrammar()
		  /// Initialises the parser's grammar rules.
		  
		  #Pragma Warning "TODO"
		  ' 1. Need to add CallParselet and elevate precedence for the `LParen` entry.
		  ' 2. Add LCurly
		  ' 3. Add Lsquare
		  ' 4. Add Dot 
		  
		  mRules = New Dictionary( _
		  TokenTypes.Ampersand         : BinaryOperator(Precedences.BitwiseAnd), _
		  TokenTypes.And_              : BinaryOperator(Precedences.LogicalAnd), _
		  TokenTypes.Assert            : Unused, _
		  TokenTypes.As_               : Unused, _
		  TokenTypes.Boolean_          : Unused, _
		  TokenTypes.Breakpoint        : Unused, _
		  TokenTypes.Caret             : BinaryOperator(Precedences.BitwiseXor), _
		  TokenTypes.Class_            : Unused, _
		  TokenTypes.Colon             : Unused, _
		  TokenTypes.Comma             : Unused, _
		  TokenTypes.Construct         : Unused, _
		  TokenTypes.Continue_         : Unused, _
		  TokenTypes.Dot               : Unused, _
		  TokenTypes.DotDot            : BinaryOperator(Precedences.Range), _
		  TokenTypes.DotDotDot         : BinaryOperator(Precedences.Range), _
		  TokenTypes.Else_             : Unused, _
		  TokenTypes.EOF               : Unused, _
		  TokenTypes.EOL               : Unused, _
		  TokenTypes.Equal             : Unused, _
		  TokenTypes.EqualEqual        : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Exit_             : Unused, _
		  TokenTypes.Export            : Unused, _
		  TokenTypes.FieldIdentifier   : Unused, _
		  TokenTypes.Foreign           : Unused, _
		  TokenTypes.ForwardSlash      : BinaryOperator(Precedences.Factor), _
		  TokenTypes.ForwardSlashEqual : Unused, _
		  TokenTypes.For_              : Unused, _
		  TokenTypes.Function_         : Unused, _
		  TokenTypes.Greater           : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterEqual      : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.GreaterGreater    : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.Identifier        : Unused, _
		  TokenTypes.If_               : Unused, _
		  TokenTypes.Import            : Unused, _
		  TokenTypes.In_               : Unused, _
		  TokenTypes.Is_               : BinaryOperator(Precedences.Is_), _
		  TokenTypes.LCurly            : Unused, _
		  TokenTypes.Less              : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessEqual         : BinaryOperator(Precedences.Comparison), _
		  TokenTypes.LessLess          : BinaryOperator(Precedences.BitwiseShift), _
		  TokenTypes.LParen            : NewRule(New GroupParselet,  Nil, Precedences.None), _
		  TokenTypes.LSquare           : Unused, _
		  TokenTypes.Minus             : Operator, _
		  TokenTypes.MinusEqual        : Unused, _
		  TokenTypes.NotEqual          : BinaryOperator(Precedences.Equality), _
		  TokenTypes.Nothing           : Unused, _
		  TokenTypes.Not_              : Prefix(New UnaryParselet), _
		  TokenTypes.Null              : Unused, _
		  TokenTypes.Number            : Prefix(New NumberParselet), _
		  TokenTypes.Or_               : BinaryOperator(Precedences.LogicalOr), _
		  TokenTypes.Percent           : BinaryOperator(Precedences.Factor), _
		  TokenTypes.Pipe              : BinaryOperator(Precedences.BitwiseOr), _
		  TokenTypes.Plus              : BinaryOperator(Precedences.Term), _
		  TokenTypes.PlusEqual         : Unused, _
		  TokenTypes.PlusPlus          : Unused, _
		  TokenTypes.Print             : Unused, _
		  TokenTypes.Query             : Unused, _
		  TokenTypes.RCurly            : Unused, _
		  TokenTypes.Return_           : Unused, _
		  TokenTypes.RParen            : Unused, _
		  TokenTypes.RSquare           : Unused, _
		  TokenTypes.Star              : BinaryOperator(Precedences.Factor), _
		  TokenTypes.StarEqual         : Unused, _
		  TokenTypes.Static_           : Unused, _
		  TokenTypes.String_           : Unused, _
		  TokenTypes.This              : Unused, _
		  TokenTypes.Tilde             : NewRule(New UnaryParselet, Nil, Precedences.None), _
		  TokenTypes.Underscore        : Unused, _
		  TokenTypes.Var_              : Unused, _
		  TokenTypes.While_            : Unused, _
		  TokenTypes.Xor_              : BinaryOperator(Precedences.LogicalXor) _
		  )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 4966207468652063757272656E7420746F6B656E206D61746368657320616E79206F66207468652073706563696669656420747970657320697420697320636F6E73756D656420616E64207468652066756E6374696F6E2072657475726E7320547275652E204F7468657277697365206974206A7573742072657475726E732046616C73652E
		Private Function Match(ParamArray types As ObjoScript.TokenTypes) As Boolean
		  /// If the current token matches any of the specified types it is consumed and 
		  /// the function returns True. Otherwise it just returns False.
		  
		  If Check(types) Then
		    Advance
		    Return True
		  End If
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F72206372656174696E672061206E6577204772616D6D617252756C652077697468206120736C696768746C792073686F727465722073796E7461782E
		Private Function NewRule(prefix As ObjoScript.PrefixParselet, infix As ObjoScript.InfixParselet, precedence As Integer) As ObjoScript.GrammarRule
		  /// Convenience method for creating a new GrammarRule with a slightly shorter syntax.
		  
		  Return New ObjoScript.GrammarRule(prefix, infix, precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120756E61727920616E642062696E617279206F70657261746F722E
		Private Function Operator(rightAssociative As Boolean = False, precedence As Integer = ObjoScript.Precedences.Term) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a unary and binary operator.
		  
		  Return New ObjoScript.GrammarRule(New UnaryParselet, New BinaryParselet(precedence, rightAssociative), precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50757473207468652070617273657220696E746F2070616E6963206D6F64652E
		Private Sub Panic(e As ObjoScript.ParserException)
		  /// Puts the parser into panic mode. 
		  ///
		  /// We try to put the parser back into a usable state once it has encountered an error.
		  /// This allows the parser to keep parsing even though an error has occurred without causing 
		  /// all subsequent code to be misinterpreted.
		  ///
		  /// `e` contains details of the error that triggered panic mode.
		  
		  // Add this error to our array of errors.
		  Errors.AddRow(e)
		  
		  // Try to recover.
		  Synchronise
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E206172726179206F6620746F6B656E7320696E746F20616E2061627374726163742073796E74617820747265652E
		Function Parse(tokens() As ObjoScript.Token) As ObjoScript.Stmt()
		  /// Parses an array of tokens into an abstract syntax tree.
		  
		  Reset
		  
		  // Keep a reference to the passed in array of tokens.
		  mTokens = tokens
		  
		  // Prime the pump.
		  Advance
		  
		  While Not AtEnd
		    Try
		      mAST.Add(Declaration)
		    Catch e As ObjoScript.ParserException
		      Panic(e)
		    End Try
		  Wend
		  
		  Return mAST
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 50617273657320616E642072657475726E7320616E2065787072657373696F6E2061742074686520676976656E20707265636564656E6365206C6576656C206F72206869676865722E
		Function ParsePrecedence(precedence As Integer) As ObjoScript.Expr
		  /// Parses and returns an expression at the given precedence level or higher.
		  ///
		  /// This is the main entry point for the top-down operator precedence parser.
		  
		  Advance
		  
		  // The prefix token will be the previously consumed one.
		  Var rule As ObjoScript.GrammarRule = GetRule(Previous.Type)
		  
		  Var prefix As ObjoScript.PrefixParselet = rule.Prefix
		  If prefix  = Nil Then
		    Error("Expected an expression. Instead got `" + Current.Type.ToString + "`.")
		  End If
		  
		  // Track if the precedence of the surrounding expression is low enough to
		  // allow an assignment inside this one. We can't parse an assignment like
		  // a normal expression because it requires us to handle the LHS specially
		  // (it needs to be an lvalue, not an rvalue). 
		  // So, for each of the kinds of expressions that are valid 
		  /// lvalues (e.g. names, subscripts, fields, etc) we pass in whether or not 
		  // it appears in a context loose enough to allow "=". 
		  // If so, it will parse the "=" itself and handle it appropriately.
		  Var canAssign As Boolean = precedence <= Precedences.Conditional
		  
		  Var left As ObjoScript.Expr = prefix.Parse(Self)
		  
		  While precedence < GetRule(Current.Type).Precedence
		    Advance
		    Var infix As ObjoScript.InfixParselet = GetRule(Previous.Type).Infix
		    left = infix.Parse(Self, left, canAssign)
		  Wend
		  
		  If canAssign And Match(ObjoScript.TokenTypes.Equal) Then
		    Error("Invalid assigment token.")
		  End If
		  
		  Return left
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577206772616D6D61722072756C6520666F72206120707265666978206F70657261746F722E
		Private Function Prefix(prefixParselet As ObjoScript.PrefixParselet, precedence As Integer = ObjoScript.Precedences.None) As ObjoScript.GrammarRule
		  /// Convenience method for returning a new grammar rule for a prefix operator.
		  
		  Return New ObjoScript.GrammarRule(prefixParselet, Nil, precedence)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657365747320746865207061727365722C20726561647920746F20706172736520616761696E2E
		Private Sub Reset()
		  /// Resets the parser, ready to parse again.
		  
		  mAST.ResizeTo(-1)
		  Previous = Nil
		  Current = Nil
		  mCurrentIndex = -1
		  Errors.ResizeTo(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 50617273657320612073746174656D656E742E
		Private Function Statement() As ObjoScript.Stmt
		  /// Parses a statement.
		  
		  // For now, we only parse expression statements.
		  Return ExpressionStatement
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 43616C6C6564207768656E207468652070617273657220656E746572732070616E6963206D6F64652E20547269657320746F206765742074686520706172736572206261636B20746F20612073746174652077686572652069742063616E20636F6E74696E75652070617273696E672E
		Private Sub Synchronise()
		  /// Called when the parser enters panic mode.
		  /// Tries to get the parser back to a state where it can continue parsing.
		  ///
		  /// We do this by discarding tokens until we hit a statement boundary.
		  
		  Advance
		  
		  While Not AtEnd
		    If Previous.Type = ObjoScript.TokenTypes.EOL Then
		      Return
		    End If
		    
		    Select Case Current.Type
		    Case ObjoScript.TokenTypes.Assert, ObjoScript.TokenTypes.Breakpoint, _
		      ObjoScript.TokenTypes.Class_, ObjoScript.TokenTypes.Continue_, _
		      ObjoScript.TokenTypes.Else_, ObjoScript.TokenTypes.Exit_, _
		      ObjoScript.TokenTypes.Export, ObjoScript.TokenTypes.Foreign, _
		      ObjoScript.TokenTypes.For_, ObjoScript.TokenTypes.Function_, _
		      ObjoScript.TokenTypes.If_, ObjoScript.TokenTypes.Import, _
		      ObjoScript.TokenTypes.Print, ObjoScript.TokenTypes.Return_, _
		      ObjoScript.TokenTypes.Static_, ObjoScript.TokenTypes.Var_, _
		      ObjoScript.TokenTypes.While_
		      // This token is the start of a statement. Hopefully we're synchronised now.
		      Return
		    End Select
		    
		    Advance
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 436F6E76656E69656E6365206D6574686F6420666F722072657475726E696E672061206E6577204772616D6D617252756C65207468617420697320756E757365642E
		Private Function Unused() As ObjoScript.GrammarRule
		  /// Convenience method for returning a new GrammarRule that is unused.
		  
		  Return New GrammarRule(Nil, Nil, Precedences.None)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Precedences Enum Notes
		Lower precedence = low "binding power"
		The ordering of the enums is CRUCIAL. Xojo automatically assigns increasing values to enums from top to bottom.
		
		None         :
		Assignment   : =
		Lowest       :
		Assignment   : =
		Conditional  : ?:
		LogicalOr    : or
		LogicalAnd   : and
		Equality     : == <>
		Is           : is
		Comparison   : < > <= >=
		BitwiseOr    : |
		BitwiseXor   : ^
		BitwiseAnd   : &
		BitwiseShift : << >>
		Range        : .. ...
		Term         : + -
		Factor       : * / %
		Unary        : - not ~ ++
		Call         : . () []
		Primary      :
		
		
	#tag EndNote


	#tag Property, Flags = &h0, Description = 54686520746F6B656E2063757272656E746C79206265696E67206576616C75617465642E
		Current As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 416E79206572726F72732074686174206D61792068617665206F6363757272656420647572696E67207468652070617273696E672070726F636573732E
		Errors() As ObjoScript.ParserException
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 5468652061627374726163742073796E7461782074726565206265696E6720636F6E737472756374656420627920746865207061727365722E
		Private mAST() As ObjoScript.Stmt
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520696E64657820696E20606D546F6B656E7360206F662074686520746F6B656E2063757272656E746C79206265696E672070726F6365737365642E
		Private mCurrentIndex As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 436F6E7461696E7320746865206772616D6D61722072756C657320666F7220746865207061727365722E204B6579203D204F626A6F5363726970742E546F6B656E54797065732C2056616C7565203D204F626A6F5363726970742E4772616D6D617252756C652E
		Private mRules As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 546865206172726179206F6620746F6B656E7320746861742074686973207061727365722077696C6C2070726F636573732E
		Private mTokens() As ObjoScript.Token
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468652070726576696F75736C79206576616C756174656420746F6B656E202877696C6C206265204E696C207768656E207468652070617273657220626567696E73292E
		Previous As ObjoScript.Token
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
