#tag Class
Protected Class Klass
Implements ObjoScript.Value
	#tag Method, Flags = &h0
		Sub Constructor(name As String, isForeign As Boolean)
		  Self.Name = name
		  Self.Methods = ParseJSON("{}") // HACK: Case sensitive.
		  Self.StaticMethods = ParseJSON("{}") // HACK: Case sensitive.
		  Self.StaticFields = ParseJSON("{}") // HACK: Case sensitive.
		  mToString = Name + " class"
		  Self.IsForeign = isForeign
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F66207468697320636C6173732E
		Function ToString() As String
		  /// Returns a string representation of this class.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return mToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 546869732076616C7565277320747970652E
		Function Type() As ObjoScript.ValueTypes
		  /// This value's type.
		  ///
		  /// Part of the ObjoScript.Value interface.
		  
		  Return ObjoScript.ValueTypes.Klass
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 54686520636C61737320636F6E7374727563746F72732E2054686520696E6465782069732074686520617267756D656E7420636F756E742E
		Constructors() As ObjoScript.Func
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 49662074686973206973206120666F726569676E20636C6173732C207468657365206172652074686520636C6173732064656C65676174657320746F207573696E672075706F6E20696E7374616E74696174696F6E20616E64206465737472756374696F6E2E204D6179206265204E696C2E
		ForeignDelegates As ObjoScript.ForeignClassDelegates
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 547275652069662074686973206973206120666F726569676E20636C6173732E
		IsForeign As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520726567756C617220286E6F6E2D7365747465722920636C61737320696E7374616E6365206D6574686F647320284B6579203D207369676E61747572652C2056616C7565203D206046756E6360206F722060466F726569676E4D6574686F6460292E
		Methods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 507265636F6D70757465642076616C756520746F2072657475726E2066726F6D2060546F537472696E672829602E
		Private mToString As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 546865206E616D65206F662074686520636C6173732E
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C6173732720737461746963206669656C647320284B6579203D206E616D652C2056616C7565203D2056617269616E74292E
		StaticFields As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520726567756C617220286E6F6E2D736574746572292073746174696320636C617373206D6574686F647320284B6579203D206D6574686F64206E616D652C2056616C7565203D206046756E6360206F722060466F726569676E4D6574686F6460292E
		StaticMethods As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 5468697320636C61737327207375706572636C6173732E204D6179206265204E696C2E
		Superclass As ObjoScript.Klass
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
		#tag ViewProperty
			Name="Name"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsForeign"
			Visible=false
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
