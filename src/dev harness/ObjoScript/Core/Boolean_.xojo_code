#tag Module
Protected Module Boolean_
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E672074686520426F6F6C65616E20636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// The user is calling the Boolean class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("The Boolean class does not have a constructor.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E207468652060426F6F6C65616E6020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `Boolean` class or Nil if there is no such method.
		  
		  // All methods on `Boolean` are instance methods.
		  If isStatic Then Return Nil
		  
		  If signature.CompareCase("toString()") Then
		    Return AddressOf ToString
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468697320626F6F6C65616E27732076616C7565206173206120737472696E672028227472756522206F72202266616C736522292E
		Protected Sub ToString(vm As ObjoScript.VM)
		  /// Returns this boolean's value as a string ("true" or "false").
		  ///
		  /// Assumes: 
		  /// - Slot 0 is a boolean
		  ///
		  /// Boolean.toString() -> string
		  
		  vm.SetReturn(vm.GetSlotAsString(0))
		  
		End Sub
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
