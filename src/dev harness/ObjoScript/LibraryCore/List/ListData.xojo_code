#tag Class
Protected Class ListData
	#tag Method, Flags = &h0, Description = 52657475726E73206120737472696E6720726570726573656E746174696F6E206F662074686520617272617920696E2074686520666F726D61743A20225B6974656D312C206974656D4E5D222E
		Function ToString() As String
		  /// Returns a string representation of the array in the format: "[item1, itemN]".
		  
		  Var s() As String = Array("[")
		  
		  Var iLimit As Integer = Items.LastIndex
		  For i As Integer = 0 To iLimit
		    s.Add(ObjoScript.VM.ValueToString(Items(i)))
		    If i < iLimit Then
		      s.Add(",")
		    End If
		  Next i
		  
		  s.Add("]")
		  
		  Return String.FromArray(s, "")
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0, Description = 546865206E756D626572206F66206974656D7320696E207468652061727261792E
		#tag Getter
			Get
			  Return Items.Count
			  
			End Get
		#tag EndGetter
		Count As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Index As Double = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Items() As Variant
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0, Description = 54686520696E646578206F6620746865206C617374206974656D20696E207468652061727261792E
		#tag Getter
			Get
			  Return Items.LastIndex
			End Get
		#tag EndGetter
		LastIndex As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		NextValue As Variant = False
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
			Name="LastIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
