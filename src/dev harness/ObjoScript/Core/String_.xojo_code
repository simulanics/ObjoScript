#tag Module
Protected Module String_
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520537472696E6720636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the String class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The String class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320547275652069662074686520737472696E6720626567696E7320776974682060707265666978602E
		Protected Sub BeginsWith(vm As ObjoScript.VM)
		  /// Returns True if the string begins with `prefix`.
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a string
		  /// - Slot 1 is the prefix to check for.
		  ///
		  /// String.beginsWith(prefix) -> boolean
		  
		  /// Since this is a built-in type, slot 0 will be a string (not an instance object).
		  Var s As String = vm.GetSlotValue(0)
		  
		  vm.SetReturn(s.BeginsWith(vm.GetSlotAsString(1), ComparisonOptions.CaseSensitive))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060537472696E676020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `String` class or Nil if there is no such method.
		  
		  If isStatic Then
		    
		  Else
		    If signature.CompareCase("beginsWith(_)") Then
		      Return AddressOf BeginsWith
		    End If
		  End If
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
