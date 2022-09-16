#tag Class
Protected Class ContinueStmt
Implements ObjoScript.Stmt
	#tag Method, Flags = &h0, Description = 50617274206F6620746865204F626A6F5363726970742E53746D7420696E746572666163652E
		Function Accept(visitor As ObjoScript.StmtVisitor) As Variant
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return visitor.VisitContinueStmt(Self)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(continueKeyword As ObjoScript.Token)
		  mContinueKeyword = continueKeyword
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546865206C6F636174696F6E206F66207468652060636F6E74696E756560206B6579776F72642E
		Function Location() As ObjoScript.Token
		  /// The location of the `continue` keyword.
		  ///
		  /// Part of the ObjoScript.Stmt interface.
		  
		  Return mContinueKeyword
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21, Description = 5468652060636F6E74696E756560206B6579776F72642E
		Private mContinueKeyword As ObjoScript.Token
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
